# components/hurl.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# hurl — run and test HTTP requests defined in plain text.
# Installed via mise (aqua backend, prebuilt binary).

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "hurl", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("hurl", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "hurl")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "hurl")
