# components/espanso.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Espanso cross-platform text expander.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "espanso", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Espanso"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "espanso", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "espanso", cask = True)
