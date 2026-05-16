# components/mini_motorways.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/mas"]
#
# Mini Motorways — Mac App Store.
# Installed via mas (Mac App Store CLI).

platforms = ["macos"]
after = ["@stdlib//components/mas"]

def install(ctx):
    pkg(manager="mas", name="Mini Motorways", version="1456188526")

def verify(ctx):
    ctx.run("mas", ["list"])
