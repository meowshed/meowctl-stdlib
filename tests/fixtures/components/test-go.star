# tests/fixtures/components/test-go.star
# Installs staticcheck via go install. Small binary, fast to build.
after = ["@stdlib//components/go"]

pkg(manager = "go_install", name = "honnef.co/go/tools/cmd/staticcheck", version = "latest")

def _activate_shims(ctx):
    # Add mise shims dir (covers go itself) and GOPATH/bin (covers staticcheck).
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")
    if ctx.which("go"):
        result = ctx.run("go", ["env", "GOPATH"])
        gopath = result.stdout.strip()
        if gopath:
            ctx.add_path(gopath + "/bin")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("staticcheck", ["-version"])
