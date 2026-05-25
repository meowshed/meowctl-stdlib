# components/elgato_studio.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Elgato Studio — capture and manage Elgato devices for content creation.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "elgato-studio", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Elgato Studio"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "elgato-studio", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "elgato-studio", cask = True)
