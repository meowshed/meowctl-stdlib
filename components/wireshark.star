# components/wireshark.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/flatpak"]
#
# Wireshark network analyser.
# macOS: Homebrew cask. Linux: native package manager or Flatpak.

after = ["@stdlib//components/brew", "@stdlib//components/flatpak"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "wireshark", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            pkg(manager = "apt", name = "wireshark")
        elif p.distro_like == "fedora":
            pkg(manager = "dnf", name = "wireshark")
        elif p.distro_like == "arch":
            pkg(manager = "pacman", name = "wireshark-qt")
        else:
            pkg(manager = "flatpak", name = "org.wireshark.Wireshark")

def verify(ctx):
    ctx.run("wireshark", ["--version"])
