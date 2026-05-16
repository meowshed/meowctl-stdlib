# components/kitty.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# kitty terminal emulator.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager="brew", name="kitty", cask=True)

def verify(ctx):
    ctx.run("open", ["-a", "kitty"])
