# components/telegram.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/flatpak"]
#
# Telegram messenger.
# macOS: Homebrew cask. Linux: native package manager or Flatpak.

after = ["@stdlib//components/brew", "@stdlib//components/flatpak"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "telegram", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            pkg(manager = "apt", name = "telegram-desktop")
        elif p.distro_like == "fedora":
            pkg(manager = "dnf", name = "telegram-desktop")
        elif p.distro_like == "arch":
            pkg(manager = "pacman", name = "telegram-desktop")
        else:
            pkg(manager = "flatpak", name = "org.telegram.desktop")

def verify(ctx):
    p = platform()
    if p.os == "macos":
        ctx.run("open", ["-a", "Telegram"])
    else:
        ctx.run("telegram-desktop", ["--version"])
