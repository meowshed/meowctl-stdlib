# components/steam.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Steam gaming platform.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "steam", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Steam"])
