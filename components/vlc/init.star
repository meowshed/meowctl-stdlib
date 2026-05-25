# components/vlc.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/flatpak"]
#
# VLC media player.
# macOS: Homebrew cask. Linux: native package manager or Flatpak.

after = ["@stdlib//components/brew", "@stdlib//components/flatpak"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "vlc", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            pkg(manager = "apt", name = "vlc")
        elif p.distro_like == "fedora":
            pkg(manager = "dnf", name = "vlc")
        elif p.distro_like == "arch":
            pkg(manager = "pacman", name = "vlc")
        else:
            pkg(manager = "flatpak", name = "org.videolan.VLC")

def verify(ctx):
    p = platform()
    if p.os == "macos":
        ctx.run("open", ["-a", "VLC"])
    else:
        ctx.run("vlc", ["--version"])

def upgrade(ctx):
    p = platform()
    if p.os == "macos":
        uppkg(manager = "brew", name = "vlc", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            uppkg(manager = "apt", name = "vlc")
        elif p.distro_like == "fedora":
            uppkg(manager = "dnf", name = "vlc")
        elif p.distro_like == "arch":
            uppkg(manager = "pacman", name = "vlc")
        else:
            uppkg(manager = "flatpak", name = "org.videolan.VLC")

def uninstall(ctx):
    p = platform()
    if p.os == "macos":
        unpkg(manager = "brew", name = "vlc", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            unpkg(manager = "apt", name = "vlc")
        elif p.distro_like == "fedora":
            unpkg(manager = "dnf", name = "vlc")
        elif p.distro_like == "arch":
            unpkg(manager = "pacman", name = "vlc")
        else:
            unpkg(manager = "flatpak", name = "org.videolan.VLC")
