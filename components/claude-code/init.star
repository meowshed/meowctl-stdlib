# components/claude-code.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Claude Code — Anthropic's official CLI for Claude.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "claude-code", cask = True)

def verify(ctx):
    ctx.run("claude", ["--version"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "claude-code", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "claude-code", cask = True)
