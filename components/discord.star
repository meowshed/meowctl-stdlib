# components/discord.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Discord voice and text chat.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "discord", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Discord"])
