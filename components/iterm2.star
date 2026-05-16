# components/iterm2.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# iTerm2 terminal emulator.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "iterm2", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "iTerm"])
