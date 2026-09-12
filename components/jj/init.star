# components/jj.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# Jujutsu — git-compatible version control system.
# https://github.com/jj-vcs/jj
# Installed via mise.

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "jj", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("jj", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "jj")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "jj")
