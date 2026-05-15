# components/pacman.star
#
# pm_name:  pacman
# platform: ["linux"]
# distro:   arch
# after:    —
#
# PM kwargs: none
#
# Bootstrap PM. pacman is a system-level package manager; no higher-level PM
# can install it. install() is a no-op — pacman is always present on Arch.
#
# Package names are standard pacman package names (e.g. "curl", "git").
# install_pkg: runs `sudo pacman -S --noconfirm <name>`.
# uninstall_pkg: runs `sudo pacman -R --noconfirm <name>`.
# interrogate: `pacman -Qq` → list of installed package names.

platforms = ["linux"]
pm_name = "pacman"

def install(ctx):
    # pacman is a system PM — always present on Arch; nothing to install.
    pass

def verify(ctx):
    ctx.run("pacman", ["--version"])

def add_repo(ctx, **kwargs):
    # pacman uses /etc/pacman.conf for repos; no generic add_repo supported.
    pass

def install_pkg(ctx, name, version, **kwargs):
    if version:
        ctx.log("warning: pacman does not support version pinning; installing latest %s" % name)
    ctx.run("sudo", ["pacman", "-S", "--noconfirm", name])

def uninstall_pkg(ctx, name, version, **kwargs):
    ctx.run("sudo", ["pacman", "-R", "--noconfirm", name])

def interrogate(ctx):
    result = ctx.run("pacman", ["-Qq"])
    pkgs = []
    for line in result.stdout.splitlines():
        line = line.strip()
        if line:
            pkgs.append(line)
    return pkgs
