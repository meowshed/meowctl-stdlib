# tests/fixtures/components/test-mas.star
# Installs mas (Mac App Store CLI) and verifies it runs.
# MEOW_ENABLE_MAS is not set so install_pkg is skipped (no App Store login in CI).
after = ["@stdlib//components/mas"]

def verify(ctx):
    ctx.run("mas", ["version"])
