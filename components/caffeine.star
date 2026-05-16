# components/caffeine.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Caffeine keep-awake utility.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "caffeine", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Caffeine"])
