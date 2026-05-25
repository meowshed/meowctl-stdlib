# components/dasel.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# dasel — query and transform JSON, YAML, TOML, XML, CSV.
# Installed via mise (aqua backend, prebuilt binary).

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "dasel", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("dasel", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "dasel")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "dasel")
