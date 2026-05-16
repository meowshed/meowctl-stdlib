# components/brave.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Brave browser.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager="brew", name="brave-browser", cask=True)

def verify(ctx):
    ctx.run("open", ["-a", "Brave Browser"])
