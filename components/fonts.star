# components/fonts.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Nerd Fonts (Hack Nerd Font).
# Installed via Homebrew formula.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "font-hack-nerd-font")

def verify(ctx):
    ctx.run("brew", ["list", "font-hack-nerd-font"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "font-hack-nerd-font")

def uninstall(ctx):
    unpkg(manager = "brew", name = "font-hack-nerd-font")
