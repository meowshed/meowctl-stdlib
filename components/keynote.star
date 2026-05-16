# components/keynote.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/mas"]
#
# Keynote — Mac App Store.
# Installed via mas (Mac App Store CLI).

platforms = ["macos"]
after = ["@stdlib//components/mas"]

def install(ctx):
    pkg(manager = "mas", name = "Keynote", version = "361285480")

def verify(ctx):
    ctx.run("mas", ["list"])
