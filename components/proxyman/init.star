# components/proxyman.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Proxyman HTTP/HTTPS debugging proxy.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "proxyman", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Proxyman"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "proxyman", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "proxyman", cask = True)
