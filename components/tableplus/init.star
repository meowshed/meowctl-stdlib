# components/tableplus.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# TablePlus database GUI.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "tableplus", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "TablePlus"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "tableplus", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "tableplus", cask = True)
