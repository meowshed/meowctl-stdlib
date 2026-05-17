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

def upgrade(ctx):
    p = platform()
    if p.os == "macos":
        uppkg(manager = "brew", name = "alacritty", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            uppkg(manager = "apt", name = "alacritty")
        elif p.distro_like == "fedora":
            uppkg(manager = "dnf", name = "alacritty")
        elif p.distro_like == "arch":
            uppkg(manager = "pacman", name = "alacritty")
        else:
            uppkg(manager = "flatpak", name = "org.alacritty.Alacritty")

def uninstall(ctx):
    p = platform()
    if p.os == "macos":
        unpkg(manager = "brew", name = "alacritty", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            unpkg(manager = "apt", name = "alacritty")
        elif p.distro_like == "fedora":
            unpkg(manager = "dnf", name = "alacritty")
        elif p.distro_like == "arch":
            unpkg(manager = "pacman", name = "alacritty")
        else:
            unpkg(manager = "flatpak", name = "org.alacritty.Alacritty")
