# components/helm.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# Helm — the Kubernetes package manager.
# https://helm.sh
# Installed via mise.

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "helm", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("helm", ["version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "helm")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "helm")
