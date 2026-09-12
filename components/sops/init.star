# components/sops.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# sops — encrypted secrets in git-friendly config files.
# https://github.com/getsops/sops
# Installed via mise.

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "sops", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("sops", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "sops")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "sops")
