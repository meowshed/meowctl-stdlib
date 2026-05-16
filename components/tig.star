# components/tig.star
#
# platform: all
# after:     —
#
# tig text-mode interface for git.
# No mise backend; installed via native system PM.

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "tig")
    elif p.os == "linux":
        if p.distro == "ubuntu" or p.distro == "debian" or p.distro_like == "debian":
            pkg(manager = "apt", name = "tig")
        elif p.distro == "fedora" or p.distro == "rhel" or p.distro_like == "fedora" or p.distro_like == "rhel":
            pkg(manager = "dnf", name = "tig")
        elif p.distro == "arch" or p.distro_like == "arch":
            pkg(manager = "pacman", name = "tig")
        elif p.distro == "alpine" or p.distro_like == "alpine":
            pkg(manager = "apk", name = "tig")
        else:
            ctx.log("tig: unsupported distro %r — install manually then re-run" % p.distro)

def verify(ctx):
    ctx.run("tig", ["--version"])
