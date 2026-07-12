# components/watch.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# watch — run a command periodically and show its output fullscreen.
# Installed via Homebrew formula.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "watch")

def verify(ctx):
    ctx.run("watch", ["--version"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "watch")

def uninstall(ctx):
    unpkg(manager = "brew", name = "watch")
