# tests/fixtures/components/test-gem.star
# Installs rake via gem (mise gem backend on non-Alpine; direct gem on Alpine).
after = ["@stdlib//components/ruby"]

pkg(manager = "gem", name = "rake")

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("rake", ["--version"])
