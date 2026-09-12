# components/ouch.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# ouch — painless compression and decompression for any archive.
# https://github.com/ouch-org/ouch
# Installed via mise (aqua backend, prebuilt binary).

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "aqua:ouch-org/ouch", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("ouch", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "aqua:ouch-org/ouch")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "aqua:ouch-org/ouch")
