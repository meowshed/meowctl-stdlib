# tests/fixtures/components/test-gem.star
# Installs rake via gem. rake is part of the Ruby standard toolset — fast.
pkg(manager = "gem", name = "rake")

def verify(ctx):
    ctx.run("rake", ["--version"])
