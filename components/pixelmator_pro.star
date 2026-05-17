# components/pixelmator_pro.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/mas"]
#
# Pixelmator Pro — Mac App Store.
# Installed via mas (Mac App Store CLI).

platforms = ["macos"]
after = ["@stdlib//components/mas"]

def install(ctx):
    pkg(manager = "mas", name = "Pixelmator Pro", version = "1289583905")

def verify(ctx):
    ctx.run("mas", ["list"])

def upgrade(ctx):
    uppkg(manager = "mas", name = "1289583905")

def uninstall(ctx):
    unpkg(manager = "mas", name = "1289583905")
