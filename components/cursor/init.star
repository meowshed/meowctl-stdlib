# components/cursor.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/flatpak"]
#
# Cursor AI code editor.
# macOS: Homebrew cask. Linux: official AppImage via Flatpak or direct download.

after = ["@stdlib//components/brew", "@stdlib//components/flatpak"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "cursor", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            pkg(manager = "flatpak", name = "com.cursor.Cursor")
        elif p.distro_like == "fedora":
            pkg(manager = "flatpak", name = "com.cursor.Cursor")
        elif p.distro_like == "arch":
            pkg(manager = "pacman", name = "cursor-bin")
        else:
            pkg(manager = "flatpak", name = "com.cursor.Cursor")

def verify(ctx):
    p = platform()
    if p.os == "macos":
        ctx.run("open", ["-a", "Cursor"])
    else:
        ctx.run("cursor", ["--version"])

def upgrade(ctx):
    p = platform()
    if p.os == "macos":
        uppkg(manager = "brew", name = "cursor", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            uppkg(manager = "flatpak", name = "com.cursor.Cursor")
        elif p.distro_like == "fedora":
            uppkg(manager = "flatpak", name = "com.cursor.Cursor")
        elif p.distro_like == "arch":
            uppkg(manager = "pacman", name = "cursor-bin")
        else:
            uppkg(manager = "flatpak", name = "com.cursor.Cursor")

def uninstall(ctx):
    p = platform()
    if p.os == "macos":
        unpkg(manager = "brew", name = "cursor", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            unpkg(manager = "flatpak", name = "com.cursor.Cursor")
        elif p.distro_like == "fedora":
            unpkg(manager = "flatpak", name = "com.cursor.Cursor")
        elif p.distro_like == "arch":
            unpkg(manager = "pacman", name = "cursor-bin")
        else:
            unpkg(manager = "flatpak", name = "com.cursor.Cursor")
