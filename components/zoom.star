# components/zoom.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Zoom video conferencing.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager="brew", name="zoom", cask=True)

def verify(ctx):
    ctx.run("open", ["-a", "zoom.us"])
