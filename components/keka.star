# components/keka.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Keka file archiver.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "keka", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Keka"])
