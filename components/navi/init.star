# components/navi.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/mise"]
#
# navi — interactive cheatsheet tool for the command-line.
# macOS: installed via Homebrew (aqua backend is linux/windows-only).
# Linux: installed via mise (aqua backend).

after = ["@stdlib//components/brew", "@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "navi")
    else:
        _activate_shims(ctx)
        pkg(manager = "mise", name = "navi", version = "latest")

def verify(ctx):
    ctx.run("navi", ["--version"])

def upgrade(ctx):
    p = platform()
    if p.os == "macos":
        uppkg(manager = "brew", name = "navi")
    else:
        _activate_shims(ctx)
        uppkg(manager = "mise", name = "navi")

def uninstall(ctx):
    p = platform()
    if p.os == "macos":
        unpkg(manager = "brew", name = "navi")
    else:
        _activate_shims(ctx)
        unpkg(manager = "mise", name = "navi")
