# tests/fixtures/components/test-dnf.star
# Installs jq via dnf. Safe, fast, no interaction required.
pkg(manager = "dnf", name = "jq")

def verify(ctx):
    ctx.run("jq", ["--version"])
