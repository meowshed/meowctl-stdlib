# components/dive.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# dive — explore Docker image layers and discover wasted space.
# https://github.com/wagoodman/dive
# Installed via mise (aqua backend, prebuilt binary).

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "dive", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("dive", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "dive")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "dive")
