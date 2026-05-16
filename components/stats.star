# components/stats.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Stats system monitor menu bar app.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "stats", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Stats"])
