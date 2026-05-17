# components/tailscale.star
#
# platform: all
# after:     ["@stdlib//components/brew"]
#
# Tailscale VPN client.
# macOS: Homebrew cask. Linux: official install script (all distros).

after = ["@stdlib//components/brew"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "tailscale", cask = True)
    elif p.os == "linux":
        ctx.run("bash", ["-c", "curl -fsSL https://tailscale.com/install.sh | sh"])

def verify(ctx):
    ctx.run("tailscale", ["version"])

def upgrade(ctx):
    p = platform()
    if p.os == "macos":
        uppkg(manager = "brew", name = "tailscale", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            uppkg(manager = "apt", name = "tailscale")
        elif p.distro_like == "fedora":
            uppkg(manager = "dnf", name = "tailscale")
        elif p.distro_like == "arch":
            uppkg(manager = "pacman", name = "tailscale")
        else:
            ctx.log("tailscale: re-run install script to upgrade on distro %r" % p.distro)

def uninstall(ctx):
    p = platform()
    if p.os == "macos":
        unpkg(manager = "brew", name = "tailscale", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            unpkg(manager = "apt", name = "tailscale")
        elif p.distro_like == "fedora":
            unpkg(manager = "dnf", name = "tailscale")
        elif p.distro_like == "arch":
            unpkg(manager = "pacman", name = "tailscale")
        else:
            ctx.log("tailscale: remove manually — distro %r not recognised" % p.distro)
