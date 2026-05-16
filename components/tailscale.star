# components/tailscale.star
#
# platform: all
# after:     ["@stdlib//components/brew"]
#
# Tailscale VPN client.
# macOS: Homebrew cask. Linux: official install script (all distros).

after = ["@stdlib//components/brew"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "tailscale", cask = True)
    elif p.os == "linux":
        ctx.run("bash", ["-c", "curl -fsSL https://tailscale.com/install.sh | sh"])

def verify(ctx):
    ctx.run("tailscale", ["version"])
