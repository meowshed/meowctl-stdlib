# components/telegram.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Telegram messenger.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "telegram", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Telegram"])
