# components/vhs.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# vhs terminal GIF recorder.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "vhs")

def verify(ctx):
    ctx.run("vhs", ["--version"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "vhs")

def uninstall(ctx):
    unpkg(manager = "brew", name = "vhs")
