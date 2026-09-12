# components/pyright.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# pyright — static type checker and language server for Python.
# https://microsoft.github.io/pyright/
# Installed via mise.

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "npm:pyright", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("pyright", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "npm:pyright")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "npm:pyright")
