# components/alacritty.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/flatpak"]
#
# Alacritty GPU-accelerated terminal.
# macOS: Homebrew cask. Linux: native package manager or Flatpak.

after = ["@stdlib//components/brew", "@stdlib//components/flatpak"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "alacritty", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            pkg(manager = "apt", name = "alacritty")
        elif p.distro_like == "fedora":
            pkg(manager = "dnf", name = "alacritty")
        elif p.distro_like == "arch":
            pkg(manager = "pacman", name = "alacritty")
        else:
            pkg(manager = "flatpak", name = "org.alacritty.Alacritty")

def verify(ctx):
    p = platform()
    if p.os == "macos":
        ctx.run("open", ["-a", "Alacritty"])
    else:
        ctx.run("alacritty", ["--version"])
