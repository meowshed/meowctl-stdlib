# components/git.star
#
# platform: all
# after:     —
#
# git version control system.
# No mise backend; installed via native system PM.

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "git")
    elif p.os == "linux":
        if p.distro == "ubuntu" or p.distro == "debian" or p.distro_like == "debian":
            pkg(manager = "apt", name = "git")
        elif p.distro == "fedora" or p.distro == "rhel" or p.distro_like == "fedora" or p.distro_like == "rhel":
            pkg(manager = "dnf", name = "git")
        elif p.distro == "arch" or p.distro_like == "arch":
            pkg(manager = "pacman", name = "git")
        elif p.distro == "alpine" or p.distro_like == "alpine":
            pkg(manager = "apk", name = "git")
        else:
            ctx.log("git: unsupported distro %r — install git manually then re-run" % p.distro)

def verify(ctx):
    ctx.run("git", ["--version"])

def upgrade(ctx):
    p = platform()
    if p.os == "macos":
        uppkg(manager = "brew", name = "git")
    elif p.os == "linux":
        if p.distro == "ubuntu" or p.distro == "debian" or p.distro_like == "debian":
            uppkg(manager = "apt", name = "git")
        elif p.distro == "fedora" or p.distro == "rhel" or p.distro_like == "fedora" or p.distro_like == "rhel":
            uppkg(manager = "dnf", name = "git")
        elif p.distro == "arch" or p.distro_like == "arch":
            uppkg(manager = "pacman", name = "git")
        elif p.distro == "alpine" or p.distro_like == "alpine":
            uppkg(manager = "apk", name = "git")
        else:
            ctx.log("git: unsupported distro %r — install git manually then re-run" % p.distro)

def uninstall(ctx):
    p = platform()
    if p.os == "macos":
        unpkg(manager = "brew", name = "git")
    elif p.os == "linux":
        if p.distro == "ubuntu" or p.distro == "debian" or p.distro_like == "debian":
            unpkg(manager = "apt", name = "git")
        elif p.distro == "fedora" or p.distro == "rhel" or p.distro_like == "fedora" or p.distro_like == "rhel":
            unpkg(manager = "dnf", name = "git")
        elif p.distro == "arch" or p.distro_like == "arch":
            unpkg(manager = "pacman", name = "git")
        elif p.distro == "alpine" or p.distro_like == "alpine":
            unpkg(manager = "apk", name = "git")
        else:
            ctx.log("git: unsupported distro %r — install git manually then re-run" % p.distro)
