# components/zed.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Zed high-performance code editor.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager="brew", name="zed", cask=True)

def verify(ctx):
    ctx.run("open", ["-a", "Zed"])
