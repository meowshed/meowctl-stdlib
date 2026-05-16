# components/apk.star
#
# pm_name:  apk
# platforms: ["linux"]
# distros:   ["alpine"]
# after:    —
#
# PM kwargs: none
#
# Bootstrap PM. apk is a system-level package manager; no higher-level PM
# can install it. install() is a no-op — apk is always present on Alpine.
#
# Package names are standard apk package names (e.g. "curl", "git").
# install_pkg: runs `apk add <name>` (Alpine runs as root in containers;
#              no sudo needed).
# uninstall_pkg: runs `apk del <name>`.
# interrogate: `apk list --installed` → lines of the form `<name>-<version> ...`;
#              extracts the package name by stripping the trailing version suffix.

platforms = ["linux"]
distros = ["alpine"]
pm_name = "apk"

def install(ctx):
    # apk is a system PM — always present on Alpine; nothing to install.
    pass

def verify(ctx):
    ctx.run("apk", ["--version"])

def add_repo(ctx, **kwargs):
    # apk uses /etc/apk/repositories for repos; no generic add_repo supported.
    pass

def install_pkg(ctx, name, version, **kwargs):
    ctx.run("apk", ["add", name])

def uninstall_pkg(ctx, name, version, **kwargs):
    ctx.run("apk", ["del", name])

def _strip_version(spec):
    """Recursively strip trailing '-<digit>...' version segments from an apk package spec."""
    idx = spec.rfind("-")
    if idx == -1:
        return spec
    if spec[idx + 1:idx + 2] >= "0" and spec[idx + 1:idx + 2] <= "9":
        return _strip_version(spec[:idx])
    return spec

def interrogate(ctx):
    result = ctx.run("apk", ["list", "--installed"])
    pkgs = []
    for line in result.stdout.splitlines():
        line = line.strip()
        if not line:
            continue
        # line format: "<name>-<version>-r<N> <arch> {<origin>} ..."
        # Per apk-package(5): the version boundary is the LAST occurrence of
        # "-<digit>", so we must split from the right.
        # Algorithm: strip the trailing "-r<N>" release suffix, then strip
        # the remaining version by finding the last "-<digit>" boundary.
        spec = line.split(" ")[0]  # e.g. "py3-setuptools-67.8.0-r1"
        # Drop -r<N> release suffix — guard: char after "-r" must be a digit
        # and index must be in bounds (spec[idx+2:idx+3] returns "" when OOB,
        # which compares less than "0" and would silently skip stripping).
        idx = spec.rfind("-r")
        if idx != -1 and idx + 2 < len(spec) and spec[idx + 2:idx + 3] >= "0" and spec[idx + 2:idx + 3] <= "9":
            spec = spec[:idx]  # e.g. "py3-setuptools-67.8.0"
        # Drop version: strip trailing "-<digit>..." segments until none remain.
        # Starlark has no while loops; use a helper function instead.
        spec = _strip_version(spec)
        if spec:
            pkgs.append(spec)
    return pkgs
