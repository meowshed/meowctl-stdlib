# components/backblaze.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Backblaze unlimited cloud backup.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "backblaze", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Backblaze"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "backblaze", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "backblaze", cask = True)
