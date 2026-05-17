# components/duf.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# duf — df replacement.
# Installed via mise (aqua backend, prebuilt binary).

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "duf", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("duf", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "duf")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "duf")
