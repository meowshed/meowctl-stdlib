# components/glow.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# glow terminal Markdown renderer.
# Installed via mise (aqua backend, prebuilt binary).

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "glow", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("glow", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "glow")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "glow")
