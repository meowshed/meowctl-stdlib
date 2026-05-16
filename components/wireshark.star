# components/wireshark.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Wireshark network analyser.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager="brew", name="wireshark", cask=True)

def verify(ctx):
    ctx.run("open", ["-a", "Wireshark"])
