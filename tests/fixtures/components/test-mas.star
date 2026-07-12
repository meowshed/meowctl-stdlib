# tests/fixtures/components/test-mas.star
# Installs mas (Mac App Store CLI) and verifies it runs.
# No mas packages are declared here, so install_pkg is never called (no App
# Store login in CI).
after = ["@stdlib//components/mas"]

def verify(ctx):
    ctx.run("mas", ["version"])
