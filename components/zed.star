# components/zed.star
#
# platform: all
# after:     ["@stdlib//components/brew"]
#
# Zed high-performance code editor.
# macOS: Homebrew cask. Linux: official install script.

after = ["@stdlib//components/brew"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "zed", cask = True)
    elif p.os == "linux":
        ctx.run("bash", ["-c", "curl -fsSL https://zed.dev/install.sh | sh"])

def verify(ctx):
    ctx.run("zed", ["--version"])
