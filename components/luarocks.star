# components/luarocks.star
#
# pm_name:  luarocks
# platform: all
# after:    ["mise"]
#
# PM kwargs: none
#
# Installs luarocks via mise's lua plugin (vfox:mise-plugins/vfox-lua), which
# compiles Lua from source and automatically installs LuaRocks alongside it.
# luarocks is not a separate entry in the mise registry — it ships bundled
# with the lua vfox plugin's PostInstall hook.
#
# install_pkg / uninstall_pkg delegate to `luarocks install` / `luarocks remove`.
# Rocks are installed into the user tree so they are available on the default
# LUA_PATH without requiring root.
#
# Version format: passed verbatim as the second positional arg to luarocks.
# interrogate: `luarocks list --porcelain` → lines of "<name> <version> ...";
#              returns unique rock names (first field of each line).

pm_name = "luarocks"
after = ["mise"]

def install(ctx):
    # mise's lua plugin (vfox-lua) compiles Lua from source and installs
    # LuaRocks into <lua-install-dir>/luarocks/bin alongside it.
    # Ensure build tools are present on distros that lack them by default.
    p = platform()
    if p.os == "linux":
        if p.distro == "arch" or p.distro_like == "arch":
            pkg(manager="pacman", name="base-devel")
        elif p.distro == "alpine" or p.distro_like == "alpine":
            pkg(manager="apk", name="build-base")
            pkg(manager="apk", name="curl")
    pkg(manager="mise", name="lua", version="5.4")
    # The vfox-lua plugin installs luarocks alongside lua. Use mise where to
    # locate the install directory and add luarocks/bin to PATH.
    result = ctx.run("mise", ["where", "lua"])
    lua_dir = result.stdout.strip()
    if lua_dir:
        ctx.add_path(lua_dir + "/luarocks/bin")

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def _activate_luarocks(ctx):
    _activate_shims(ctx)
    # luarocks is bundled inside the vfox-lua install directory.
    # mise shims do not cover it, so we ask mise where lua is installed and
    # add <lua-install-dir>/luarocks/bin to PATH.
    result = ctx.run("mise", ["where", "lua"])
    lua_dir = result.stdout.strip()
    if lua_dir:
        ctx.add_path(lua_dir + "/luarocks/bin")

def verify(ctx):
    _activate_luarocks(ctx)
    ctx.run("luarocks", ["--version"])

def install_pkg(ctx, name, version, **kwargs):
    _activate_luarocks(ctx)
    if version:
        ctx.run("luarocks", ["install", name, version])
    else:
        ctx.run("luarocks", ["install", name])

def uninstall_pkg(ctx, name, version, **kwargs):
    _activate_luarocks(ctx)
    if version:
        ctx.run("luarocks", ["remove", name, version])
    else:
        ctx.run("luarocks", ["remove", name])

def interrogate(ctx):
    _activate_luarocks(ctx)
    result = ctx.run("luarocks", ["list", "--porcelain"])
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
