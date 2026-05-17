# components/hammerspoon.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Hammerspoon macOS automation framework.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "hammerspoon", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Hammerspoon"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "hammerspoon", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "hammerspoon", cask = True)
