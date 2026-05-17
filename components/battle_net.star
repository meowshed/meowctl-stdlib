# components/battle_net.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Battle.net game launcher.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "battle-net", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Battle.net"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "battle-net", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "battle-net", cask = True)
