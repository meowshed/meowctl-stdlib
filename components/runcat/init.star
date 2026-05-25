# components/runcat.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/mas"]
#
# RunCat — Mac App Store.
# Installed via mas (Mac App Store CLI).

platforms = ["macos"]
after = ["@stdlib//components/mas"]

def install(ctx):
    pkg(manager = "mas", name = "RunCat", version = "1429033973")

def verify(ctx):
    ctx.run("mas", ["list"])

def upgrade(ctx):
    uppkg(manager = "mas", name = "1429033973")

def uninstall(ctx):
    unpkg(manager = "mas", name = "1429033973")
