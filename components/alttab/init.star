# components/alttab.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# AltTab — Windows-style window switcher with previews.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "alt-tab", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "AltTab"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "alt-tab", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "alt-tab", cask = True)
