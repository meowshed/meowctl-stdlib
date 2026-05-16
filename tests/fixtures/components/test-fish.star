# tests/fixtures/components/test-fish.star
# Installs fish shell and verifies it runs.
# Fisher plugin manager bootstrap requires curl + fish, both available on Ubuntu.
after = ["@stdlib//components/fish"]

def verify(ctx):
    ctx.run("fish", ["--version"])
