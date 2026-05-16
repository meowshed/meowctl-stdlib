# tests/fixtures/components/test-luarocks.star
# Installs luasocket via luarocks. Small, widely available rock.
after = ["@stdlib//components/luarocks"]

pkg(manager = "luarocks", name = "luasocket")

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def _luarocks_cmd():
    p = platform()
    if p.os == "linux" and (p.distro == "alpine" or p.distro_like == "alpine"):
        return "luarocks-5.4"
    return "luarocks"

def verify(ctx):
    _activate_shims(ctx)
    ctx.run(_luarocks_cmd(), ["show", "luasocket"])
