# components/procs.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# procs — ps replacement.
# Installed via mise (aqua backend, prebuilt binary).

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "procs", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("procs", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "procs")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "procs")
