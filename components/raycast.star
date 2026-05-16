# components/raycast.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Raycast launcher.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "raycast", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Raycast"])
