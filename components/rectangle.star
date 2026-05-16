# components/rectangle.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Rectangle window manager.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager="brew", name="rectangle", cask=True)

def verify(ctx):
    ctx.run("open", ["-a", "Rectangle"])
