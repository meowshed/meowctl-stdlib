# tests/fixtures/components/test-go.star
# Installs staticcheck via go install (mise go backend). Small binary, fast to build.
after = ["@stdlib//components/go"]

pkg(manager = "go_install", name = "honnef.co/go/tools/cmd/staticcheck", version = "latest")

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("staticcheck", ["-version"])
