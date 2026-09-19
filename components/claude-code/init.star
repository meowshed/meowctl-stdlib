# components/claude-code.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/mise"]
#
# Claude Code — Anthropic's official CLI for Claude.
#
# Installed through mise rather than the Homebrew cask, to match opencode and
# the rest of the CLI toolchain and to keep one updater. Switching an existing
# machine means removing the cask first — `brew uninstall claude-code` — which
# cannot be done from inside a running Claude Code session, because that is the
# binary being replaced.

platforms = ["macos"]
after = ["@stdlib//components/mise"]

def install(ctx):
    pkg(manager = "mise", name = "npm:@anthropic-ai/claude-code", version = "latest")

def verify(ctx):
    ctx.run("claude", ["--version"])

def upgrade(ctx):
    uppkg(manager = "mise", name = "npm:@anthropic-ai/claude-code")

def uninstall(ctx):
    unpkg(manager = "mise", name = "npm:@anthropic-ai/claude-code")
