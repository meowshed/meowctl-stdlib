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
    pkg(manager="mise", name="node", version="lts")

def verify(ctx):
    ctx.run("node", ["--version"])

def install_pkg(ctx, name, version, **kwargs):
    if version:
        ctx.run("npm", ["install", "-g", "%s@%s" % (name, version)])
    else:
        ctx.run("npm", ["install", "-g", name])

def uninstall_pkg(ctx, name, version, **kwargs):
    ctx.run("npm", ["uninstall", "-g", name])

def interrogate(ctx):
    result = ctx.run("npm", ["list", "-g", "--depth=0", "--parseable"])
    names = []
    for line in result.stdout.splitlines():
        if "node_modules/" in line:
            names.append(line.split("node_modules/")[-1])
    return names
