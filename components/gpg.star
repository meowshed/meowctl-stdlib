# components/gpg.star
#
# platform: all
# after:     —
#
# GnuPG encryption and signing tool.
# No mise backend; installed via native system PM.

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "gnupg")
    elif p.os == "linux":
        if p.distro == "ubuntu" or p.distro == "debian" or p.distro_like == "debian":
            pkg(manager = "apt", name = "gnupg")
        elif p.distro == "fedora" or p.distro == "rhel" or p.distro_like == "fedora" or p.distro_like == "rhel":
            pkg(manager = "dnf", name = "gnupg2")
        elif p.distro == "arch" or p.distro_like == "arch":
            pkg(manager = "pacman", name = "gnupg")
        elif p.distro == "alpine" or p.distro_like == "alpine":
            pkg(manager = "apk", name = "gnupg")
        else:
            ctx.log("gpg: unsupported distro %r — install manually then re-run" % p.distro)

def verify(ctx):
    ctx.run("gpg", ["--version"])
