# tests/fixtures/components/test-github.star
# Installs jq via github component (delegates to mise github: backend).
# jq releases are published to GitHub Releases — good end-to-end test.
after = ["@stdlib//components/github"]

pkg(manager = "github", name = "jqlang/jq")

def verify(ctx):
    # mise github: backend does not always create a shim; locate the binary
    # via `mise where github:jqlang/jq` and add its dir to PATH.
    result = ctx.run("mise", ["where", "github:jqlang/jq"])
    install_dir = result.stdout.strip()
    if install_dir:
        ctx.add_path(install_dir)
    ctx.run("jq", ["--version"])
