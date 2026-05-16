# tests/fixtures/components/test-uv.star
# Installs ruff via uv tool. Fast to install, widely known.
after = ["@stdlib//components/uv"]

pkg(manager = "uv", name = "ruff")

def _activate_shims(ctx):
    # Add mise shims dir (covers uv itself) and uv tool bin dir (covers ruff).
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")
    if ctx.which("uv"):
        result = ctx.run("uv", ["tool", "dir"])
        tool_dir = result.stdout.strip()
        if tool_dir:
            ctx.add_path(tool_dir + "/bin")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("ruff", ["--version"])
