# components/vlc.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# VLC media player.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "vlc", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "VLC"])
