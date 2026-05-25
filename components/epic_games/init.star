# components/epic_games.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Epic Games Launcher.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "epic-games", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Epic Games Launcher"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "epic-games", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "epic-games", cask = True)
