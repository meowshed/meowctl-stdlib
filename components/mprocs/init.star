# components/mprocs.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# mprocs — run multiple long-running commands in a split TUI.
# https://github.com/pvolok/dekit
# Installed via mise (aqua backend, prebuilt binary). Upstream renamed the
# project to dekit: mise's `mprocs` entry now installs `aqua:pvolok/dekit`,
# whose binary is `dekit`.

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "mprocs", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("dekit", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "mprocs")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "mprocs")
