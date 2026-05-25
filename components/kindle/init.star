# components/kindle.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/mas"]
#
# Kindle — Mac App Store.
# Installed via mas (Mac App Store CLI).

platforms = ["macos"]
after = ["@stdlib//components/mas"]

def install(ctx):
    pkg(manager = "mas", name = "Kindle", version = "302584613")

def verify(ctx):
    ctx.run("mas", ["list"])

def upgrade(ctx):
    uppkg(manager = "mas", name = "302584613")

def uninstall(ctx):
    unpkg(manager = "mas", name = "302584613")
