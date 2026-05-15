# tests/fixtures/components/test-apt.star
# Installs jq via apt. Safe, fast, no interaction required.
after = ["@stdlib//components/apt.star"]

pkg(manager = "apt", name = "jq")

def verify(ctx):
    ctx.run("jq", ["--version"])
