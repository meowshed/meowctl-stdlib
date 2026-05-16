# components/httpie.star
#
# platform: all
# after:     —
#
# HTTPie user-friendly HTTP client.
# No mise backend; installed via native system PM.

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager="brew", name="httpie")
    elif p.os == "linux":
        if p.distro == "ubuntu" or p.distro == "debian" or p.distro_like == "debian":
            pkg(manager="apt", name="httpie")
        elif p.distro == "fedora" or p.distro == "rhel" or p.distro_like == "fedora" or p.distro_like == "rhel":
            pkg(manager="dnf", name="httpie")
        elif p.distro == "arch" or p.distro_like == "arch":
            pkg(manager="pacman", name="httpie")
        elif p.distro == "alpine" or p.distro_like == "alpine":
            pkg(manager="apk", name="py3-httpie")
        else:
            ctx.log("httpie: unsupported distro %r — install manually then re-run" % p.distro)

def verify(ctx):
    ctx.run("http", ["--version"])
