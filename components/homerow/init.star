# components/homerow.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Homerow — keyboard-driven clicking across all macOS apps.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "homerow", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Homerow"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "homerow", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "homerow", cask = True)
