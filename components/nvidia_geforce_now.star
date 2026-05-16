# components/nvidia_geforce_now.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# NVIDIA GeForce NOW game streaming.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager="brew", name="nvidia-geforce-now", cask=True)

def verify(ctx):
    ctx.run("open", ["-a", "GeForce NOW"])
