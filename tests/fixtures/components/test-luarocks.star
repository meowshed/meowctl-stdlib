# tests/fixtures/components/test-luarocks.star
# Installs luasocket via luarocks. Small, widely available rock.
after = ["@stdlib//components/luarocks"]

pkg(manager = "luarocks", name = "luasocket")

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("luarocks", ["show", "luasocket"])
