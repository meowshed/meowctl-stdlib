# components/pre_commit.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# pre-commit — git hook framework for linters and formatters.
# https://pre-commit.com
# Installed via mise.

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "pipx:pre-commit", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("pre-commit", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "pipx:pre-commit")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "pipx:pre-commit")
