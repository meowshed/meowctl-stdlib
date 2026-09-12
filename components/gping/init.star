# components/gping.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# gping — ping with a live graph.
# https://github.com/orf/gping
# Installed via mise.

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "gping", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("gping", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "gping")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "gping")
