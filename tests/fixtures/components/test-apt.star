# tests/fixtures/components/test-apt.star
# Installs jq via apt. Safe, fast, no interaction required.
pkg(manager = "apt", name = "jq")

def verify(ctx):
    ctx.run("jq", ["--version"])
