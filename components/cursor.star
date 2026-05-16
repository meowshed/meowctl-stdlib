# components/cursor.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Cursor AI code editor.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager="brew", name="cursor", cask=True)

def verify(ctx):
    ctx.run("open", ["-a", "Cursor"])
