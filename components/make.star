# components/make.star
#
# platform: all
# after:     —
#
# GNU make build tool.
# No mise backend (conda only); installed via native system PM.

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager="brew", name="make")
    elif p.os == "linux":
        if p.distro == "ubuntu" or p.distro == "debian" or p.distro_like == "debian":
            pkg(manager="apt", name="make")
        elif p.distro == "fedora" or p.distro == "rhel" or p.distro_like == "fedora" or p.distro_like == "rhel":
            pkg(manager="dnf", name="make")
        elif p.distro == "arch" or p.distro_like == "arch":
            pkg(manager="pacman", name="make")
        elif p.distro == "alpine" or p.distro_like == "alpine":
            pkg(manager="apk", name="make")
        else:
            ctx.log("make: unsupported distro %r — install manually then re-run" % p.distro)

def verify(ctx):
    ctx.run("make", ["--version"])
