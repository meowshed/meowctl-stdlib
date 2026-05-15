# tests/fixtures/components/test-npm.star
# Installs cowsay via npm globally. Safe, fast.
after = ["@stdlib//components/node.star"]

pkg(manager = "npm", name = "cowsay")

def verify(ctx):
    ctx.run("cowsay", ["hello"])
