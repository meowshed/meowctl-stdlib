# components/drawio.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# draw.io diagramming tool.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager="brew", name="drawio", cask=True)

def verify(ctx):
    ctx.run("open", ["-a", "draw.io"])
