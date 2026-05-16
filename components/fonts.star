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
    ctx.run("fc-list", ["| grep", "Hack"])
