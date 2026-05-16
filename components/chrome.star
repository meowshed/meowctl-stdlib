# components/chrome.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Google Chrome browser.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager="brew", name="google-chrome", cask=True)

def verify(ctx):
    ctx.run("open", ["-a", "Google Chrome"])
