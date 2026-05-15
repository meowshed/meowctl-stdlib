# tests/fixtures/components/test-apt.star
# Installs jq via apt. Safe, fast, no interaction required.
after = ["@stdlib//components/apt"]

pkg(manager = "apt", name = "jq")

def verify(ctx):
    ctx.run("jq", ["--version"])
