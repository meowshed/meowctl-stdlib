# tests/fixtures/components/test-github.star
# Installs jq via github component (delegates to mise github: backend).
# jq releases are published to GitHub Releases — good end-to-end test.
after = ["@stdlib//components/github"]

pkg(manager = "github", name = "jqlang/jq")

def verify(ctx):
    # mise github: backend may name the binary jq-linux-amd64 or similar;
    # use `mise exec` to run it without relying on PATH or binary name.
    ctx.run("mise", ["exec", "github:jqlang/jq", "--", "jq", "--version"])
