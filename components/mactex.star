# components/mactex.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# MacTeX LaTeX distribution (no GUI tools).
# Installed via Homebrew cask (mactex-no-gui).

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "mactex-no-gui", cask = True)

def verify(ctx):
    ctx.run("tex", ["--version"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "mactex-no-gui", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "mactex-no-gui", cask = True)
