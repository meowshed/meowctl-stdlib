# components/typora.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/brew"]
#
# Typora Markdown editor.
# Installed via Homebrew cask.

platforms = ["macos"]
after = ["@stdlib//components/brew"]

def install(ctx):
    pkg(manager = "brew", name = "typora", cask = True)

def verify(ctx):
    ctx.run("open", ["-a", "Typora"])
