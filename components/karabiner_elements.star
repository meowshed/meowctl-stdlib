# components/karabiner_elements.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Karabiner-Elements keyboard remapper.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager="brew", name="karabiner-elements", cask=True)

def verify(ctx):
    ctx.run("open", ["-a", "Karabiner-Elements"])
