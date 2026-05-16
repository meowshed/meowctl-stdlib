# components/onepassword.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# 1Password password manager.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "1password", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "1Password 7"])
