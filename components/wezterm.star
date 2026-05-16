# components/wezterm.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# WezTerm terminal emulator.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "wezterm", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "WezTerm"])
