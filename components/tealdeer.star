# components/tealdeer.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# tealdeer fast tldr client.
# Installed via mise (aqua backend, prebuilt binary).

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "tealdeer", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("tldr", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "tealdeer")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "tealdeer")
