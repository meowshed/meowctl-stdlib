# tests/fixtures/components/test-cargo.star
# Installs bat via cargo (mise cargo backend). bat is small and widely used.
after = ["@stdlib//components/rust"]

pkg(manager = "cargo", name = "bat")

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("bat", ["--version"])
