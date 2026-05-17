# components/sony_ps_remote_play.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# PS Remote Play — control your PlayStation 4 or PlayStation 5 remotely.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "sony-ps-remote-play", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "PS Remote Play"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "sony-ps-remote-play", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "sony-ps-remote-play", cask = True)
