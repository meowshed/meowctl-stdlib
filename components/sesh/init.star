# components/sesh.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# sesh — smart terminal session manager for tmux.
# https://github.com/joshmedeski/sesh
# Installed via mise (aqua backend, prebuilt binary).

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "aqua:joshmedeski/sesh", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("sesh", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "aqua:joshmedeski/sesh")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "aqua:joshmedeski/sesh")
