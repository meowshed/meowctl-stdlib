# tests/fixtures/components/test-cargo.star
# Installs bat via cargo. bat is small and widely used; compiles in ~60s.
after = ["@stdlib//components/rust"]

pkg(manager = "cargo", name = "bat")

def verify(ctx):
    ctx.run("bat", ["--version"])
