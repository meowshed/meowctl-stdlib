# components/arc.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Arc browser.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "arc", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Arc"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "arc", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "arc", cask = True)
