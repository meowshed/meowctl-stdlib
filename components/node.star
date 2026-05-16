# components/node.star
#
# pm_name:  npm
# platform: all
# after:    ["mise"]
#
# PM kwargs: none
#
# npm packages are always installed globally (-g).
# interrogate: `npm list -g --depth=0 --parseable` → one path per line;
#              strip the `<prefix>/node_modules/` prefix to get the package name.
# Scoped packages (@scope/name) are returned verbatim including the leading @.

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
    # npm global packages land in `mise where node`/bin; this dir is NOT always
    # listed by `mise bin-paths`, so add it explicitly so downstream verify
    # hooks (e.g. test-npm checking cowsay) can find npm-installed binaries.
    if ctx.which("mise"):
        result = ctx.run("mise", ["where", "node"])
        node_dir = result.stdout.strip()
        if node_dir:
            ctx.add_path(node_dir + "/bin")

def install_pkg(ctx, name, version, **kwargs):
    _activate_shims(ctx)
    if version:
        ctx.run("npm", ["install", "-g", "%s@%s" % (name, version)])
    else:
        ctx.run("npm", ["install", "-g", name])

def uninstall_pkg(ctx, name, version, **kwargs):
    _activate_shims(ctx)
    ctx.run("npm", ["uninstall", "-g", name])

def interrogate(ctx):
    _activate_shims(ctx)
    result = ctx.run("npm", ["list", "-g", "--depth=0", "--parseable"])
    names = []
    for line in result.stdout.splitlines():
        if "node_modules/" in line:
            names.append(line.split("node_modules/")[-1])
    return names
