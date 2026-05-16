# components/ffmpeg.star
#
# platform: all
# after:     —
#
# ffmpeg audio/video processing toolkit.
# No mise backend (conda only); installed via native system PM.

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "ffmpeg")
    elif p.os == "linux":
        if p.distro == "ubuntu" or p.distro == "debian" or p.distro_like == "debian":
            pkg(manager = "apt", name = "ffmpeg")
        elif p.distro == "fedora" or p.distro == "rhel" or p.distro_like == "fedora" or p.distro_like == "rhel":
            pkg(manager = "dnf", name = "ffmpeg")
        elif p.distro == "arch" or p.distro_like == "arch":
            pkg(manager = "pacman", name = "ffmpeg")
        elif p.distro == "alpine" or p.distro_like == "alpine":
            pkg(manager = "apk", name = "ffmpeg")
        else:
            ctx.log("ffmpeg: unsupported distro %r — install manually then re-run" % p.distro)

def verify(ctx):
    ctx.run("ffmpeg", ["--version"])
