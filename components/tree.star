# components/tree.star
#
# platform: all
# after:     —
#
# tree directory listing tool.
# No mise backend; installed via native system PM.

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager="brew", name="tree")
    elif p.os == "linux":
        if p.distro == "ubuntu" or p.distro == "debian" or p.distro_like == "debian":
            pkg(manager="apt", name="tree")
        elif p.distro == "fedora" or p.distro == "rhel" or p.distro_like == "fedora" or p.distro_like == "rhel":
            pkg(manager="dnf", name="tree")
        elif p.distro == "arch" or p.distro_like == "arch":
            pkg(manager="pacman", name="tree")
        elif p.distro == "alpine" or p.distro_like == "alpine":
            pkg(manager="apk", name="tree")
        else:
            ctx.log("tree: unsupported distro %r — install manually then re-run" % p.distro)

def verify(ctx):
    ctx.run("tree", ["--version"])
