# components/insomnia.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Insomnia API client.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager="brew", name="insomnia", cask=True)

def verify(ctx):
    ctx.run("open", ["-a", "Insomnia"])
