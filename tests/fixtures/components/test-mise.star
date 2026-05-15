# tests/fixtures/components/test-mise.star
# Installs node@lts via mise. Tests the full mise tool install lifecycle.
pkg(manager = "mise", name = "node", version = "lts")

def verify(ctx):
    ctx.run("node", ["--version"])
