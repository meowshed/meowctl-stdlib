# components/kubectl.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# kubectl — the Kubernetes command-line client.
# https://kubernetes.io/docs/reference/kubectl/
# Installed via mise.

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "kubectl", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("kubectl", ["version", "--client"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "kubectl")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "kubectl")
