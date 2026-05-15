# tests/fixtures/components/test-brew.star
# Installs jq via brew. Safe, fast, no interaction required.
after = ["@stdlib//components/brew.star"]

pkg(manager = "brew", name = "jq")

def verify(ctx):
    ctx.run("jq", ["--version"])
