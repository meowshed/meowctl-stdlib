# components/displayplacer.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# displayplacer display layout tool.
# Installed via Homebrew formula.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "displayplacer")

def verify(ctx):
    ctx.run("displayplacer", ["--version"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "displayplacer")

def uninstall(ctx):
    unpkg(manager = "brew", name = "displayplacer")
