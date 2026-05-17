# components/orbstack.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# OrbStack Docker and Linux runtime.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "orbstack", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "OrbStack"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "orbstack", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "orbstack", cask = True)
