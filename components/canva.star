# components/canva.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Canva graphic design.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "canva", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Canva"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "canva", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "canva", cask = True)
