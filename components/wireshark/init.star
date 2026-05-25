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

def upgrade(ctx):
    p = platform()
    if p.os == "macos":
        uppkg(manager = "brew", name = "wireshark", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            uppkg(manager = "apt", name = "wireshark")
        elif p.distro_like == "fedora":
            uppkg(manager = "dnf", name = "wireshark")
        elif p.distro_like == "arch":
            uppkg(manager = "pacman", name = "wireshark-qt")
        else:
            uppkg(manager = "flatpak", name = "org.wireshark.Wireshark")

def uninstall(ctx):
    p = platform()
    if p.os == "macos":
        unpkg(manager = "brew", name = "wireshark", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            unpkg(manager = "apt", name = "wireshark")
        elif p.distro_like == "fedora":
            unpkg(manager = "dnf", name = "wireshark")
        elif p.distro_like == "arch":
            unpkg(manager = "pacman", name = "wireshark-qt")
        else:
            unpkg(manager = "flatpak", name = "org.wireshark.Wireshark")
