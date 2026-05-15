# tests/fixtures/components/test-github-release.star
# Installs jq via github_release (delegates to mise under the hood).
# jq releases are published to GitHub Releases — good end-to-end test.
pkg(manager = "github_release", name = "jqlang/jq")

def verify(ctx):
    ctx.run("jq", ["--version"])
