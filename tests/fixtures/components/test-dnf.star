# tests/fixtures/components/test-dnf.star
# Installs jq via dnf. Safe, fast, no interaction required.
after = ["@stdlib//components/dnf"]

pkg(manager = "dnf", name = "jq")

def verify(ctx):
    ctx.run("jq", ["--version"])
