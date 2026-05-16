# components/mas_mini_metro.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/mas"]
#
# Mini Metro+ — Mac App Store.
# Installed via mas (Mac App Store CLI).

platforms = ["macos"]
after = ["@stdlib//components/mas"]

def install(ctx):
    pkg(manager="mas", name="Mini Metro+", version="1550663539")

def verify(ctx):
    ctx.run("mas", ["list"])
