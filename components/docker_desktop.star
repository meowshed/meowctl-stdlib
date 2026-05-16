# components/docker_desktop.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Docker Desktop.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager="brew", name="docker", cask=True)

def verify(ctx):
    ctx.run("open", ["-a", "Docker"])
