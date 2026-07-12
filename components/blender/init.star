# components/blender.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Blender 3D creation suite.
# Installed via Homebrew cask. (The mise/aqua backend extracts the .dmg into a
# temp dir and trips over a File-system-loop in bundled symlinks, so cask is the
# stable path on macOS.)

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "blender", cask = True)

def verify(ctx):
    ctx.run("brew", ["list", "--cask", "blender"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "blender", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "blender", cask = True)
