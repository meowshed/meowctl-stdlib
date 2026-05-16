# components/ghostty.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/flatpak"]
#
# Ghostty terminal emulator.
# macOS: Homebrew cask. Linux: native package manager or Flatpak.

after = ["@stdlib//components/brew", "@stdlib//components/flatpak"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "ghostty", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            pkg(manager = "apt", name = "ghostty")
        elif p.distro_like == "fedora":
            pkg(manager = "dnf", name = "ghostty")
        elif p.distro_like == "arch":
            pkg(manager = "pacman", name = "ghostty")
        else:
            pkg(manager = "flatpak", name = "com.mitchellh.ghostty")

def verify(ctx):
    p = platform()
    if p.os == "macos":
        ctx.run("open", ["-a", "Ghostty"])
    else:
        ctx.run("ghostty", ["--version"])
