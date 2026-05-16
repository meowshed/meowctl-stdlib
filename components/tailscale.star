# components/tailscale.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Tailscale VPN client.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager="brew", name="tailscale", cask=True)

def verify(ctx):
    ctx.run("open", ["-a", "Tailscale"])
