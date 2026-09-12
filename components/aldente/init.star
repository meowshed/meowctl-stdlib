# components/aldente.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# AlDente — battery charge limiter for MacBooks.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "aldente", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "AlDente"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "aldente", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "aldente", cask = True)
