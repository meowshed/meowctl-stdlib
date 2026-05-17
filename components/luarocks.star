# components/luarocks.star
#
# pm_name:  luarocks
# platform: all
# after:    ["mise"]
#
# On Alpine, uses system packages (lua5.4 + luarocks5.4) to avoid source
# compilation. The system binary is luarocks-5.4; _luarocks_cmd() returns
# the correct name for the current platform.
#
# On all other platforms, installs lua + luarocks via mise's vfox-lua plugin,
# which compiles lua from source and bundles luarocks alongside it. The
# install dir is located via `mise where lua` and added to PATH.
#
# install_pkg / uninstall_pkg delegate to `luarocks install` / `luarocks remove`.
# interrogate: `luarocks list --porcelain` → unique rock names (first field).

pm_name = "luarocks"
after = ["@stdlib//components/mise"]

def _is_alpine(p):
    return p.os == "linux" and (p.distro == "alpine" or p.distro_like == "alpine")

def _luarocks_cmd():
    p = platform()
    if _is_alpine(p):
        return "luarocks-5.4"
    return "luarocks"

def install(ctx):
    p = platform()
    if p.os == "linux":
        if _is_alpine(p):
            # Use system packages — no source compilation.
            pkg(manager = "apk", name = "lua5.4")
            pkg(manager = "apk", name = "lua5.4-dev")
            pkg(manager = "apk", name = "luarocks5.4")
            return
        elif p.distro == "arch" or p.distro_like == "arch":
            # vfox-lua requires unzip to install LuaRocks alongside Lua.
            pkg(manager = "pacman", name = "base-devel")
            pkg(manager = "pacman", name = "unzip")

    # mise's vfox-lua plugin compiles Lua and bundles luarocks.
    pkg(manager = "mise", name = "lua", version = "5.4")

    # Locate the install dir and add luarocks/bin to PATH.
    result = ctx.run("mise", ["where", "lua"])
    lua_dir = result.stdout.strip()
    if lua_dir:
        ctx.add_path(lua_dir + "/luarocks/bin")

def upgrade(ctx):
    p = platform()
    if _is_alpine(p):
        uppkg(manager = "apk", name = "lua5.4")
        uppkg(manager = "apk", name = "lua5.4-dev")
        uppkg(manager = "apk", name = "luarocks5.4")
    else:
        uppkg(manager = "mise", name = "lua")

def uninstall(ctx):
    p = platform()
    if _is_alpine(p):
        unpkg(manager = "apk", name = "lua5.4")
        unpkg(manager = "apk", name = "lua5.4-dev")
        unpkg(manager = "apk", name = "luarocks5.4")
    else:
        unpkg(manager = "mise", name = "lua")

def _activate_luarocks(ctx):
    p = platform()
    if _is_alpine(p):
        return  # system luarocks-5.4 is already on PATH
    _activate_shims(ctx)
    result = ctx.run("mise", ["where", "lua"])
    lua_dir = result.stdout.strip()
    if lua_dir:
        ctx.add_path(lua_dir + "/luarocks/bin")

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def verify(ctx):
    _activate_luarocks(ctx)
    ctx.run(_luarocks_cmd(), ["--version"])

def install_pkg(ctx, name, version, **kwargs):
    _activate_luarocks(ctx)
    if version and version != "latest":
        ctx.run(_luarocks_cmd(), ["install", name, version])
    else:
        ctx.run(_luarocks_cmd(), ["install", name])

def uninstall_pkg(ctx, name, version, **kwargs):
    _activate_luarocks(ctx)
    if version and version != "latest":
        ctx.run(_luarocks_cmd(), ["remove", name, version])
    else:
        ctx.run(_luarocks_cmd(), ["remove", name])

def interrogate(ctx):
    _activate_luarocks(ctx)
    result = ctx.run(_luarocks_cmd(), ["list", "--porcelain"])
    seen = {}
    names = []
    for line in result.stdout.splitlines():
        line = line.strip()
        if not line:
            continue
        rock = line.split()[0]
        if rock not in seen:
            seen[rock] = True
            names.append(rock)
    return names
