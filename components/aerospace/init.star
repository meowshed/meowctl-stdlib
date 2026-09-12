# components/aerospace.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# AeroSpace tiling window manager.
# https://github.com/nikitabobko/AeroSpace
# Installed via Homebrew cask from the nikitabobko/tap tap.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "aerospace", cask = True, tap = "nikitabobko/tap")

def verify(ctx):
    ctx.run("open", ["-a", "AeroSpace"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "aerospace", cask = True, tap = "nikitabobko/tap")

def uninstall(ctx):
    unpkg(manager = "brew", name = "aerospace", cask = True)
