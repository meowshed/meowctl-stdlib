# components/bandwhich.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# bandwhich — terminal bandwidth utilization by process.
# https://github.com/imsnif/bandwhich
# Installed via mise.

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "aqua:imsnif/bandwhich", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("bandwhich", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "aqua:imsnif/bandwhich")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "aqua:imsnif/bandwhich")
