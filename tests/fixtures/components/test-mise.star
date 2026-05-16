# tests/fixtures/components/test-mise.star
# Installs direnv via mise. Tests the full mise tool install lifecycle.
# direnv is a small, self-contained binary — quick to install, no shared deps.
after = ["@stdlib//components/mise"]

pkg(manager = "mise", name = "direnv", version = "latest")

def verify(ctx):
    ctx.run("direnv", ["version"])
