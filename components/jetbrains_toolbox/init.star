# components/jetbrains_toolbox.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# JetBrains Toolbox — installer and updater for JetBrains IDEs.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "jetbrains-toolbox", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "JetBrains Toolbox"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "jetbrains-toolbox", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "jetbrains-toolbox", cask = True)
