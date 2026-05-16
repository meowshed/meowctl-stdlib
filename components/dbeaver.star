# components/dbeaver.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# DBeaver community database tool.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "dbeaver-community", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "DBeaver"])
