# components/yabai.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# yabai tiling window manager.
# Installed via Homebrew formula.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "yabai")

def verify(ctx):
    ctx.run("yabai", ["--version"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "yabai")

def uninstall(ctx):
    unpkg(manager = "brew", name = "yabai")
