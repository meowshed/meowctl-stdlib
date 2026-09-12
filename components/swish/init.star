# components/swish.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Swish — trackpad gestures for window management.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "swish", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Swish"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "swish", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "swish", cask = True)
