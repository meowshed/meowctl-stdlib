# components/linear.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Linear project management.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "linear-linear", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Linear"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "linear-linear", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "linear-linear", cask = True)
