# components/tree_sitter.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/mise"]
#
# tree-sitter CLI — parser generator tool.
# macOS: installed via Homebrew.
# Linux: installed via mise (aqua backend).

after = ["@stdlib//components/brew", "@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "tree-sitter")
    else:
        _activate_shims(ctx)
        pkg(manager = "mise", name = "tree-sitter", version = "latest")

def verify(ctx):
    ctx.run("tree-sitter", ["--version"])

def upgrade(ctx):
    p = platform()
    if p.os == "macos":
        uppkg(manager = "brew", name = "tree-sitter")
    else:
        _activate_shims(ctx)
        uppkg(manager = "mise", name = "tree-sitter")

def uninstall(ctx):
    p = platform()
    if p.os == "macos":
        unpkg(manager = "brew", name = "tree-sitter")
    else:
        _activate_shims(ctx)
        unpkg(manager = "mise", name = "tree-sitter")
