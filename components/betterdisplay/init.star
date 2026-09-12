# components/betterdisplay.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# BetterDisplay — display management, scaling and dummy screens.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "betterdisplay", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "BetterDisplay"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "betterdisplay", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "betterdisplay", cask = True)
