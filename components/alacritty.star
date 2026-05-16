# components/alacritty.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Alacritty GPU-accelerated terminal.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager="brew", name="alacritty", cask=True)

def verify(ctx):
    ctx.run("open", ["-a", "Alacritty"])
