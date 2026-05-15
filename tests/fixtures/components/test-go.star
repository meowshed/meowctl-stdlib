# tests/fixtures/components/test-go.star
# Installs staticcheck via go install. Small binary, fast to build.
pkg(manager = "go_install", name = "honnef.co/go/tools/cmd/staticcheck", version = "latest")

def verify(ctx):
    ctx.run("staticcheck", ["-version"])
