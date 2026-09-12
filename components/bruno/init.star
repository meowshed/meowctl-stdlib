# components/bruno.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Bruno — local-first, open-source API client.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "bruno", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Bruno"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "bruno", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "bruno", cask = True)
