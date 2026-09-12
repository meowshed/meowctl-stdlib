# components/ice.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Ice menu bar manager (open-source Bartender alternative).
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "jordanbaird-ice", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Ice"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "jordanbaird-ice", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "jordanbaird-ice", cask = True)
