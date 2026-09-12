# components/yazi.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# yazi — blazing fast terminal file manager with rich previews.
# https://github.com/sxyazi/yazi
# Installed via mise (aqua backend, prebuilt binary).

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "yazi", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("yazi", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "yazi")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "yazi")
