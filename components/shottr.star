# components/shottr.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Shottr screenshot tool.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager="brew", name="shottr", cask=True)

def verify(ctx):
    ctx.run("open", ["-a", "Shottr"])
