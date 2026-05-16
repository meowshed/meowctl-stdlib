# tests/fixtures/components/test-uv.star
# Installs ruff via uv (mise pipx backend). Fast to install, widely known.
after = ["@stdlib//components/uv"]

pkg(manager = "uv", name = "ruff")

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("ruff", ["--version"])
