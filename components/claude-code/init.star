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

def _finish_install(ctx):
    # mise installs npm packages with scripts disabled, and this package is a
    # launcher whose postinstall fetches the platform-native binary — without it
    # `claude` starts and reports "native binary not installed". Running the
    # script by hand is what the error message itself suggests.
    r = ctx.run("sh", ["-c",
        "f=$(find " + ctx.home + "/.local/share/mise/installs/npm-anthropic-ai-claude-code " +
        "-name install.cjs -path '*@anthropic-ai/claude-code/*' 2>/dev/null | head -1); " +
        "[ -n \"$f\" ] && cd \"$(dirname \"$f\")\" && node install.cjs >/dev/null 2>&1; :",
    ])
    _ = r

def install(ctx):
    pkg(manager = "mise", name = "npm:@anthropic-ai/claude-code", version = "latest")
    _finish_install(ctx)

def verify(ctx):
    ctx.run("claude", ["--version"])

def upgrade(ctx):
    uppkg(manager = "mise", name = "npm:@anthropic-ai/claude-code")
    _finish_install(ctx)

def uninstall(ctx):
    unpkg(manager = "mise", name = "npm:@anthropic-ai/claude-code")
