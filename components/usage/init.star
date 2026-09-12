# components/usage.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# usage — CLI spec tool powering mise task args and completions.
# https://usage.jdx.dev
# Installed via mise (aqua backend, prebuilt binary).

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "usage", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("usage", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "usage")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "usage")
