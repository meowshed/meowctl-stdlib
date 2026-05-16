# components/iina.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# IINA media player.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager="brew", name="iina", cask=True)

def verify(ctx):
    ctx.run("open", ["-a", "IINA"])
