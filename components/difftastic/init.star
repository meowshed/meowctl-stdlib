# components/difftastic.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# difftastic — structural diff that understands syntax.
# https://github.com/Wilfred/difftastic
# Installed via mise (aqua backend, prebuilt binary).

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "difftastic", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("difft", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "difftastic")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "difftastic")
