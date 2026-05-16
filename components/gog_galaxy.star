# components/gog_galaxy.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# GOG Galaxy game launcher.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager="brew", name="gog-galaxy", cask=True)

def verify(ctx):
    ctx.run("open", ["-a", "GOG Galaxy"])
