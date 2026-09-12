# components/arq.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Arq backup to cloud storage with client-side encryption.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "arq", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Arq"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "arq", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "arq", cask = True)
