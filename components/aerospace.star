# components/aerospace.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# AeroSpace tiling window manager.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "aerospace", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "AeroSpace"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "aerospace", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "aerospace", cask = True)
