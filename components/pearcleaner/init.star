# components/pearcleaner.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Pearcleaner — app uninstaller that removes leftover files.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "pearcleaner", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Pearcleaner"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "pearcleaner", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "pearcleaner", cask = True)
