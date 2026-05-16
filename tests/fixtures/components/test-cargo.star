# tests/fixtures/components/test-cargo.star
# Installs bat via cargo. bat is small and widely used; compiles in ~60s.
after = ["@stdlib//components/rust"]

pkg(manager = "cargo", name = "bat")

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")
    # cargo installs binaries into ~/.cargo/bin
    if home:
        ctx.add_path(home + "/.cargo/bin")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("bat", ["--version"])
