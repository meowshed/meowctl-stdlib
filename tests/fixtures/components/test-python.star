# tests/fixtures/components/test-python.star
# Installs ruff via python (mise pipx backend). Fast to install, widely known.
after = ["@stdlib//components/python"]

pkg(manager = "python", name = "ruff")

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def _activate_pipx_bin(ctx):
    # On Alpine, pipx installs tool binaries into ~/.local/bin (not mise shims).
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/bin")

def verify(ctx):
    p = platform()
    if p.os == "linux" and (p.distro == "alpine" or p.distro_like == "alpine"):
        _activate_pipx_bin(ctx)
    else:
        _activate_shims(ctx)
    ctx.run("ruff", ["--version"])
