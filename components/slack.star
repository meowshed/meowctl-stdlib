# components/slack.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Slack messaging.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "slack", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Slack"])
