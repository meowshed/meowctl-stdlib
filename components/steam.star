# components/steam.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/flatpak"]
#
# Steam gaming platform.
# macOS: Homebrew cask. Linux: native package manager or Flatpak.

after = ["@stdlib//components/brew", "@stdlib//components/flatpak"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "steam", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            pkg(manager = "apt", name = "steam")
        elif p.distro_like == "fedora":
            pkg(manager = "dnf", name = "steam")
        elif p.distro_like == "arch":
            pkg(manager = "pacman", name = "steam")
        else:
            pkg(manager = "flatpak", name = "com.valvesoftware.Steam")

def verify(ctx):
    p = platform()
    if p.os == "macos":
        ctx.run("open", ["-a", "Steam"])
    else:
        ctx.run("steam", ["-version"])
