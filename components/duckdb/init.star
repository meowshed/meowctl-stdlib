# components/duckdb.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# DuckDB — in-process analytical database with a SQL shell.
# https://duckdb.org
# Installed via mise.

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "duckdb", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("duckdb", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "duckdb")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "duckdb")
