# components/maccy.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Maccy clipboard manager.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "maccy", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Maccy"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "maccy", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "maccy", cask = True)
