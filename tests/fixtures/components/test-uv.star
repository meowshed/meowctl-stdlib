# tests/fixtures/components/test-uv.star
# Installs ruff via uv tool. Fast to install, widely known.
after = ["@stdlib//components/uv.star"]

pkg(manager = "uv", name = "ruff")

def verify(ctx):
    ctx.run("ruff", ["--version"])
