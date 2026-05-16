# components/node.star
#
# pm_name:  npm
# platform: all
# after:    ["mise"]
#
# PM kwargs: none
#
# npm packages are installed globally via `mise use --global npm:<name>`.
# This delegates installation and PATH management entirely to mise, so all
# binaries appear in ~/.local/share/mise/shims automatically.
#
# interrogate: `mise ls --installed --json` → filter keys with "npm:" prefix;
#              strip the prefix to return bare package names.

after = ["mise"]
pm_name = "npm"

def install(ctx):
    # On Alpine (musl), mise builds node from source — needs python3, make, g++.
    p = platform()
    if p.os == "linux" and (p.distro == "alpine" or p.distro_like == "alpine"):
        pkg(manager="apk", name="python3")
        pkg(manager="apk", name="make")
        pkg(manager="apk", name="g++")
    pkg(manager="mise", name="node", version="lts")

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("node", ["--version"])

def install_pkg(ctx, name, version, **kwargs):
    _activate_shims(ctx)
    if version:
        spec = "npm:%s@%s" % (name, version)
    else:
        spec = "npm:%s" % name
    ctx.run("mise", ["use", "--global", spec])

def uninstall_pkg(ctx, name, version, **kwargs):
    _activate_shims(ctx)
    ctx.run("mise", ["use", "--global", "--remove", "npm:%s" % name])
    if version:
        ctx.run("mise", ["uninstall", "npm:%s@%s" % (name, version)])
    else:
        ctx.run("mise", ["uninstall", "npm:%s" % name])

def interrogate(ctx):
    _activate_shims(ctx)
    result = ctx.run("mise", ["ls", "--installed", "--json"])
    installed = json.decode(result.stdout)
    names = []
    for key in installed.keys():
        if key.startswith("npm:"):
            names.append(key[4:])
    return names
