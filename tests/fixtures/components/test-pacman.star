# tests/fixtures/components/test-pacman.star
# Installs jq via pacman. Safe, fast, no interaction required.
after = ["@stdlib//components/pacman"]

pkg(manager = "pacman", name = "jq")

def verify(ctx):
    ctx.run("jq", ["--version"])
