# components/firefox.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/flatpak"]
#
# Firefox browser.
# macOS: Homebrew cask. Linux: native package manager or Flatpak.

after = ["@stdlib//components/brew", "@stdlib//components/flatpak"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "firefox", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            pkg(manager = "apt", name = "firefox")
        elif p.distro_like == "fedora":
            pkg(manager = "dnf", name = "firefox")
        elif p.distro_like == "arch":
            pkg(manager = "pacman", name = "firefox")
        else:
            pkg(manager = "flatpak", name = "org.mozilla.firefox")

def verify(ctx):
    p = platform()
    if p.os == "macos":
        ctx.run("open", ["-a", "Firefox"])
    else:
        ctx.run("firefox", ["--version"])
