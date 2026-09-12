# components/gopls.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# gopls — the official Go language server.
# https://pkg.go.dev/golang.org/x/tools/gopls
# Installed via mise.

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "go:golang.org/x/tools/gopls", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("gopls", ["version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "go:golang.org/x/tools/gopls")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "go:golang.org/x/tools/gopls")
