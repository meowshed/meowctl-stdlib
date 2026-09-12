# components/golangci_lint.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# golangci-lint — aggregate linter runner for Go.
# https://golangci-lint.run
# Installed via mise.

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "golangci-lint", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("golangci-lint", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "golangci-lint")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "golangci-lint")
