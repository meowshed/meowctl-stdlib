# components/kitty.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/flatpak"]
#
# kitty GPU-accelerated terminal emulator.
# macOS: Homebrew cask. Linux: native package manager or Flatpak.

after = ["@stdlib//components/brew", "@stdlib//components/flatpak"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "kitty", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            pkg(manager = "apt", name = "kitty")
        elif p.distro_like == "fedora":
            pkg(manager = "dnf", name = "kitty")
        elif p.distro_like == "arch":
            pkg(manager = "pacman", name = "kitty")
        else:
            pkg(manager = "flatpak", name = "net.kovidgoyal.kitty")

def verify(ctx):
    p = platform()
    if p.os == "macos":
        ctx.run("open", ["-a", "kitty"])
    else:
        ctx.run("kitty", ["--version"])
