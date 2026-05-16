# components/signal.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Signal encrypted messenger.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager="brew", name="signal", cask=True)

def verify(ctx):
    ctx.run("open", ["-a", "Signal"])
