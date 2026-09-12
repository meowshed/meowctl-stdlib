# components/skhd.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# skhd — simple hotkey daemon for macOS.
# https://github.com/koekeishiya/skhd
# Installed via Homebrew formula from the koekeishiya/formulae tap.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "skhd", tap = "koekeishiya/formulae")

def verify(ctx):
    ctx.run("skhd", ["--version"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "skhd", tap = "koekeishiya/formulae")

def uninstall(ctx):
    unpkg(manager = "brew", name = "skhd")
