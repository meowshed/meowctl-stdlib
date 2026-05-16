# components/curl.star
#
# platform: all
# after:     —
#
# curl HTTP transfer tool.
# No mise backend; installed via native system PM.

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "curl")
    elif p.os == "linux":
        if p.distro == "ubuntu" or p.distro == "debian" or p.distro_like == "debian":
            pkg(manager = "apt", name = "curl")
        elif p.distro == "fedora" or p.distro == "rhel" or p.distro_like == "fedora" or p.distro_like == "rhel":
            pkg(manager = "dnf", name = "curl")
        elif p.distro == "arch" or p.distro_like == "arch":
            pkg(manager = "pacman", name = "curl")
        elif p.distro == "alpine" or p.distro_like == "alpine":
            pkg(manager = "apk", name = "curl")
        else:
            ctx.log("curl: unsupported distro %r — install manually then re-run" % p.distro)

def verify(ctx):
    ctx.run("curl", ["--version"])
