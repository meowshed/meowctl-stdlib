# components/hiddenbar.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# HiddenBar menu bar manager.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "hiddenbar", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Hidden Bar"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "hiddenbar", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "hiddenbar", cask = True)
