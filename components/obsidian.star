# components/obsidian.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Obsidian knowledge base.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "obsidian", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Obsidian"])
