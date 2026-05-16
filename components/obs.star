# components/obs.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# OBS Studio screen recorder/streamer.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager="brew", name="obs", cask=True)

def verify(ctx):
    ctx.run("open", ["-a", "OBS"])
