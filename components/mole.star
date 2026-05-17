# components/mole.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Mole Mac cleaner and optimizer.
# Installed via Homebrew formula.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "mole")

def verify(ctx):
    ctx.run("mole", ["--version"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "mole")

def uninstall(ctx):
    unpkg(manager = "brew", name = "mole")
