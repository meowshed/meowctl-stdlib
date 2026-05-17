# components/whatsapp.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# WhatsApp messenger.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "whatsapp", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "WhatsApp"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "whatsapp", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "whatsapp", cask = True)
