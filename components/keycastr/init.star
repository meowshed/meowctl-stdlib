# components/keycastr.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# KeyCastr — on-screen keystroke visualizer for demos and screencasts.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "keycastr", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "KeyCastr"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "keycastr", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "keycastr", cask = True)
