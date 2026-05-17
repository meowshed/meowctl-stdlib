# components/notion.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Notion all-in-one workspace.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "notion", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Notion"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "notion", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "notion", cask = True)
