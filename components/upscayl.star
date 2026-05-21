# components/upscayl.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/flatpak"]
#
# Upscayl — free and open-source AI image upscaler.
# macOS: Homebrew cask. Linux: Flatpak.

after = ["@stdlib//components/brew", "@stdlib//components/flatpak"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "upscayl", cask = True)
    else:
        pkg(manager = "flatpak", name = "org.upscayl.Upscayl")

def verify(ctx):
    p = platform()
    if p.os == "macos":
        ctx.run("open", ["-a", "Upscayl"])
    else:
        ctx.run("flatpak", ["run", "org.upscayl.Upscayl", "--version"])

def upgrade(ctx):
    p = platform()
    if p.os == "macos":
        uppkg(manager = "brew", name = "upscayl", cask = True)
    else:
        uppkg(manager = "flatpak", name = "org.upscayl.Upscayl")

def uninstall(ctx):
    p = platform()
    if p.os == "macos":
        unpkg(manager = "brew", name = "upscayl", cask = True)
    else:
        unpkg(manager = "flatpak", name = "org.upscayl.Upscayl")
