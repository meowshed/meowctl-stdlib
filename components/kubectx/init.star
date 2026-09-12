# components/kubectx.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# kubectx / kubens — fast context and namespace switching.
# https://github.com/ahmetb/kubectx
# Installed via mise.

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "kubectx", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("kubectx", ["--help"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "kubectx")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "kubectx")
