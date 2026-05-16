# components/mas_prime_video.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/mas"]
#
# Prime Video — Mac App Store.
# Installed via mas (Mac App Store CLI).

platforms = ["macos"]
after = ["@stdlib//components/mas"]

def install(ctx):
    pkg(manager="mas", name="Prime Video", version="545519333")

def verify(ctx):
    ctx.run("mas", ["list"])
