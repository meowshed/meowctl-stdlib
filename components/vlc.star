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
