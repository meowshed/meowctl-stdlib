# components/claude-desktop.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Claude Desktop — Anthropic's desktop app (GUI counterpart to claude-code).
# Installed via Homebrew cask `claude`.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "claude", cask = True)

def verify(ctx):
    ctx.run("brew", ["list", "--cask", "claude"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "claude", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "claude", cask = True)
