# components/numbers.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/mas"]
#
# Numbers — Mac App Store.
# Installed via mas (Mac App Store CLI).

platforms = ["macos"]
after = ["@stdlib//components/mas"]

def install(ctx):
    pkg(manager = "mas", name = "Numbers", version = "361304891")

def verify(ctx):
    ctx.run("mas", ["list"])
