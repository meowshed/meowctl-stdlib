# components/imagemagick.star
#
# platform: all
# after:     —
#
# ImageMagick image processing suite.
# No mise backend (conda only); installed via native system PM.

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "imagemagick")
    elif p.os == "linux":
        if p.distro == "ubuntu" or p.distro == "debian" or p.distro_like == "debian":
            pkg(manager = "apt", name = "imagemagick")
        elif p.distro == "fedora" or p.distro == "rhel" or p.distro_like == "fedora" or p.distro_like == "rhel":
            pkg(manager = "dnf", name = "ImageMagick")
        elif p.distro == "arch" or p.distro_like == "arch":
            pkg(manager = "pacman", name = "imagemagick")
        elif p.distro == "alpine" or p.distro_like == "alpine":
            pkg(manager = "apk", name = "imagemagick")
        else:
            ctx.log("imagemagick: unsupported distro %r — install manually then re-run" % p.distro)

def verify(ctx):
    ctx.run("convert", ["--version"])
