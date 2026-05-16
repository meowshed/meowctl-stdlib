# tests/fixtures/components/test-npm.star
# Installs cowsay via npm (mise npm backend). Safe, fast.
after = ["@stdlib//components/node"]

pkg(manager = "npm", name = "cowsay")

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("cowsay", ["hello"])
