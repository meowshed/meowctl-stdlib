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
