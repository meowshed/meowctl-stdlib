# components/postman.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Postman API client.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager="brew", name="postman", cask=True)

def verify(ctx):
    ctx.run("open", ["-a", "Postman"])
