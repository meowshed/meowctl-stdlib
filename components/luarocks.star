# components/luarocks.star
#
# pm_name:  luarocks
# platform: all
# after:    ["mise"]
#
# PM kwargs: none
#
# Installs luarocks via mise (mise install luarocks), which also brings a
# managed Lua runtime. This avoids relying on distro-packaged luarocks versions
# which are often outdated.
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
    pkg(manager="mise", name="luarocks")
    # luarocks installs rock executables into ~/.luarocks/bin; add to PATH.
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
