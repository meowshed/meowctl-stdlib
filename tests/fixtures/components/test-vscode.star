# tests/fixtures/components/test-vscode.star
# Installs VS Code and verifies the `code` CLI is available.
# macOS only — VS Code has a glibc dependency that prevents it running on Alpine,
# and the Arch AUR is not supported in CI.
after = ["@stdlib//components/vscode"]

def verify(ctx):
    ctx.run("code", ["--version"])
