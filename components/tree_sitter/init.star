# components/tree_sitter.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/mise"]
#
# tree-sitter CLI — parser generator tool.
# Installed via mise (available on all platforms via aqua backend).
# Falls back to Homebrew on macOS if mise not available.

after = ["@stdlib//components/brew", "@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "tree-sitter", version = "latest")

def verify(ctx):
    ctx.run("tree-sitter", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "tree-sitter")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "tree-sitter")
