# tests/fixtures/components/test-github.star
# Installs jq via github component (delegates to mise github: backend).
# jq releases are published to GitHub Releases — good end-to-end test.
after = ["@stdlib//components/github"]

pkg(manager = "github", name = "jqlang/jq")

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("jq", ["--version"])
