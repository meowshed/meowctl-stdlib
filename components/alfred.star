# components/alfred.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Alfred launcher.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager="brew", name="alfred", cask=True)

def verify(ctx):
    ctx.run("open", ["-a", "Alfred"])
