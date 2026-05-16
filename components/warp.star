# components/warp.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Warp AI terminal.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager="brew", name="warp", cask=True)

def verify(ctx):
    ctx.run("open", ["-a", "Warp"])
