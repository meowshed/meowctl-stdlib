# tests/fixtures/components/test-uv.star
# Installs ruff via uv tool. Fast to install, widely known.
pkg(manager = "uv", name = "ruff")

def verify(ctx):
    ctx.run("ruff", ["--version"])
