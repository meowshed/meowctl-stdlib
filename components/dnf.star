# components/dnf.star
#
# pm_name:  dnf
# platform: ["linux"]
# distro:   fedora, rhel, and fedora-like
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

platforms = ["linux"]
pm_name = "dnf"

def install(ctx):
    # dnf is a system PM — always present on supported distros; nothing to install.
    pass

def verify(ctx):
    ctx.run("dnf", ["--version"])

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
        if line:
            pkgs.append(line)
    return pkgs
