# tests/fixtures/components/test-luarocks.star
# Installs luasocket via luarocks. Small, widely available rock.
pkg(manager = "luarocks", name = "luasocket")

def verify(ctx):
    ctx.run("luarocks", ["show", "luasocket"])
