# tests/fixtures/components/test-npm.star
# Installs cowsay via npm globally. Safe, fast.
after = ["@stdlib//components/node"]

pkg(manager = "npm", name = "cowsay")

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")
    # npm global packages land in `mise where node`/bin; add explicitly.
    if ctx.which("mise"):
        result = ctx.run("mise", ["where", "node"])
        node_dir = result.stdout.strip()
        if node_dir:
            ctx.add_path(node_dir + "/bin")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("cowsay", ["hello"])
