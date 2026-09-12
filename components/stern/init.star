# components/stern.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# stern — multi-pod log tailing for Kubernetes.
# https://github.com/stern/stern
# Installed via mise.

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "stern", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("stern", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "stern")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "stern")
