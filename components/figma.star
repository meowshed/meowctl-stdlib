# components/figma.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Figma design tool.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "figma", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Figma"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "figma", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "figma", cask = True)
