# components/just.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# just — command runner with a make-like syntax and none of make's pitfalls.
# https://github.com/casey/just
# Installed via mise.

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "just", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("just", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "just")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "just")
