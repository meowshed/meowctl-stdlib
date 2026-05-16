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
    pkg(manager="mise", name="lua", version="latest")
    # The vfox-lua plugin adds <install-dir>/luarocks/bin to PATH via EnvKeys,
    # but that only takes effect after mise activation. Re-activate shims to
    # pick up the new paths, then add luarocks bin explicitly via its config.
    if ctx.which("luarocks"):
        result = ctx.run("luarocks", ["config", "home_tree"])
        home_tree = result.stdout.strip()
        if home_tree:
            ctx.add_path(home_tree + "/bin")

def verify(ctx):
    ctx.run("luarocks", ["--version"])

def install_pkg(ctx, name, version, **kwargs):
    if version:
        ctx.run("luarocks", ["install", name, version])
    else:
        ctx.run("luarocks", ["install", name])

def uninstall_pkg(ctx, name, version, **kwargs):
    if version:
        ctx.run("luarocks", ["remove", name, version])
    else:
        ctx.run("luarocks", ["remove", name])

def interrogate(ctx):
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
