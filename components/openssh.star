# components/openssh.star
#
# platform: all
# after:     ["@stdlib//components/brew"]
#
# OpenSSH — latest version of the SSH client and server.
# macOS ships an older OpenSSH; Homebrew provides the current release.
# Linux distros ship a recent version via system PM.

after = ["@stdlib//components/brew"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "openssh")
    elif p.os == "linux":
        if p.distro_like == "debian":
            pkg(manager = "apt", name = "openssh-client")
        elif p.distro_like == "fedora":
            pkg(manager = "dnf", name = "openssh-clients")
        elif p.distro_like == "arch":
            pkg(manager = "pacman", name = "openssh")
        elif p.distro_like == "alpine":
            pkg(manager = "apk", name = "openssh-client")
        else:
            ctx.log("ssh: unsupported distro %r — install openssh manually" % p.distro)

def verify(ctx):
    ctx.run("ssh", ["-V"])
