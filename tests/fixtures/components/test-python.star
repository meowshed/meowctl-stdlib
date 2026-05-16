# tests/fixtures/components/test-python.star
# Installs ruff via python (mise pipx backend). Fast to install, widely known.
after = ["@stdlib//components/python"]

pkg(manager = "python", name = "ruff")

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("ruff", ["--version"])
