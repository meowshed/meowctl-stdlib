# components/runcat.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/mas"]
#
# RunCat Neo — Mac App Store.
# Installed via mas (Mac App Store CLI).

platforms = ["macos"]
after = ["@stdlib//components/mas"]

def install(ctx):
    pkg(manager = "mas", name = "6757801838")  # RunCat Neo

def verify(ctx):
    ctx.run("mas", ["list"])

def upgrade(ctx):
    uppkg(manager = "mas", name = "6757801838")

def uninstall(ctx):
    unpkg(manager = "mas", name = "6757801838")
