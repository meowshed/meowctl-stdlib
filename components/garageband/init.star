# components/garageband.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/mas"]
#
# GarageBand — Mac App Store.
# Installed via mas (Mac App Store CLI).

platforms = ["macos"]
after = ["@stdlib//components/mas"]

def install(ctx):
    pkg(manager = "mas", name = "GarageBand", version = "682658836")

def verify(ctx):
    ctx.run("mas", ["list"])

def upgrade(ctx):
    uppkg(manager = "mas", name = "682658836")

def uninstall(ctx):
    unpkg(manager = "mas", name = "682658836")
