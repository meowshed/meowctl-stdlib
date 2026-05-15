# tests/fixtures/components/test-github-release.star
# Installs jq via github_release (delegates to mise under the hood).
# jq releases are published to GitHub Releases — good end-to-end test.
after = ["@stdlib//components/github_release"]

pkg(manager = "github-release", name = "jqlang/jq")

def verify(ctx):
    ctx.run("jq", ["--version"])
