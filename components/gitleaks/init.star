# components/gitleaks.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# gitleaks — scanner for secrets in git repos and history.
# https://github.com/gitleaks/gitleaks
# Installed via mise (aqua backend, prebuilt binary).

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "gitleaks", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("gitleaks", ["version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "gitleaks")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "gitleaks")
