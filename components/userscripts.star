# components/userscripts.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/mas"]
#
# Userscripts — Mac App Store.
# Installed via mas (Mac App Store CLI).

platforms = ["macos"]
after = ["@stdlib//components/mas"]

def install(ctx):
    pkg(manager="mas", name="Userscripts", version="1463298887")

def verify(ctx):
    ctx.run("mas", ["list"])
