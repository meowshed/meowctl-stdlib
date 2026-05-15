# tests/fixtures/components/test-brew.star
# Installs jq via brew. Safe, fast, no interaction required.
pkg(manager = "brew", name = "jq")

def verify(ctx):
    ctx.run("jq", ["--version"])
