# components/pages.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/mas"]
#
# Pages — Mac App Store.
# Installed via mas (Mac App Store CLI).

platforms = ["macos"]
after = ["@stdlib//components/mas"]

def install(ctx):
    pkg(manager = "mas", name = "Pages", version = "361309726")

def verify(ctx):
    ctx.run("mas", ["list"])

def upgrade(ctx):
    uppkg(manager = "mas", name = "361309726")

def uninstall(ctx):
    unpkg(manager = "mas", name = "361309726")
