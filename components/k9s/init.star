# components/k9s.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# k9s — terminal UI to interact with Kubernetes clusters.
# https://github.com/derailed/k9s
# Installed via mise (aqua backend, prebuilt binary).

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "k9s", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("k9s", ["version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "k9s")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "k9s")
