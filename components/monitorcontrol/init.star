# components/monitorcontrol.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# MonitorControl — brightness and volume control for external displays.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "monitorcontrol", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "MonitorControl"])

def upgrade(ctx):
    uppkg(manager = "brew", name = "monitorcontrol", cask = True)

def uninstall(ctx):
    unpkg(manager = "brew", name = "monitorcontrol", cask = True)
