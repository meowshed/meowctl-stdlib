# components/hexyl.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# hexyl — colourful command-line hex viewer.
# https://github.com/sharkdp/hexyl
# Installed via mise.

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "hexyl", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("hexyl", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "hexyl")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "hexyl")
