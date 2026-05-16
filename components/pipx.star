# components/pipx.star
#
# pm_name:  pipx
# platform: all
# after:    ["mise"]
#
# PM kwargs: none
#
# pipx tools are installed via `mise use --global pipx:<name>`.
# mise's pipx backend uses uv when available, falling back to pipx.
# All binaries appear in ~/.local/share/mise/shims automatically.
#
# interrogate: `mise ls --installed --json` → filter keys with "pipx:" prefix.

after = ["mise"]
pm_name = "pipx"

def install(ctx):
    pkg(manager="mise", name="pipx", version="latest")

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("pipx", ["--version"])

def install_pkg(ctx, name, version, **kwargs):
    _activate_shims(ctx)
    if version:
        spec = "pipx:%s@%s" % (name, version)
    else:
        spec = "pipx:%s" % name
    ctx.run("mise", ["use", "--global", spec])

def uninstall_pkg(ctx, name, version, **kwargs):
    _activate_shims(ctx)
    ctx.run("mise", ["use", "--global", "--remove", "pipx:%s" % name])
    if version:
        ctx.run("mise", ["uninstall", "pipx:%s@%s" % (name, version)])
    else:
        ctx.run("mise", ["uninstall", "pipx:%s" % name])

def interrogate(ctx):
    _activate_shims(ctx)
    result = ctx.run("mise", ["ls", "--installed", "--json"])
    installed = json.decode(result.stdout)
    names = []
    for key in installed.keys():
        if key.startswith("pipx:"):
            names.append(key[5:])
    return names
