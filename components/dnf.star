# components/dnf.star
#
# pm_name:  dnf
# platforms: ["linux"]
# distros:   ["fedora", "rhel"]
# after:    —
#
# PM kwargs: none
#
# Bootstrap PM. dnf is a system-level package manager; no higher-level PM
# can install it. install() is a no-op — dnf is always present on supported
# distros.
#
# Package names are standard dnf package names (e.g. "curl", "git").
# install_pkg: runs `sudo dnf install -y <name>`.
# uninstall_pkg: runs `sudo dnf remove -y <name>`.
# interrogate: `dnf --quiet repoquery --installed --qf '%{name}'` → list of
#              installed package names. (--quiet placed before subcommand to
#              avoid dnf5 stdout contamination on some Fedora 41 builds.)
#
# add_repo kwargs:
#   copr=  COPR repo slug in "owner/repo" format (e.g. "jdxcode/mise").
#          Requires dnf-plugins-core to be installed first.

platforms = ["linux"]
distros = ["fedora", "rhel"]
pm_name = "dnf"

def install(ctx):
    # dnf is a system PM — always present on supported distros; nothing to install.
    pass

def verify(ctx):
    ctx.run("dnf", ["--version"])

def add_repo(ctx, **kwargs):
    copr = kwargs.get("copr", "")
    if copr:
        ctx.run("sudo", ["dnf", "install", "-y", "dnf-plugins-core"])
        ctx.run("sudo", ["dnf", "copr", "enable", "-y", copr])

def install_pkg(ctx, name, version, **kwargs):
    if version:
        ctx.run("sudo", ["dnf", "install", "-y", "%s-%s" % (name, version)])
    else:
        ctx.run("sudo", ["dnf", "install", "-y", name])

def uninstall_pkg(ctx, name, version, **kwargs):
    ctx.run("sudo", ["dnf", "remove", "-y", name])

def interrogate(ctx):
    result = ctx.run("dnf", ["--quiet", "repoquery", "--installed", "--qf", "%{name}\n"])
    pkgs = []
    for line in result.stdout.splitlines():
        line = line.strip()
        if not line:
            continue
        # Some RHEL builds emit "epoch:name" — strip any leading "N:" prefix.
        if ":" in line:
            line = line.split(":", 1)[1]
        if line:
            pkgs.append(line)
    return pkgs
