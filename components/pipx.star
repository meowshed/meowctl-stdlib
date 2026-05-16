# components/pipx.star
#
# pm_name:  pipx
# platform: all
# after:    ["mise"]
#
# PM kwargs: none
#
# pipx installs Python CLI tools in isolated virtual environments.
# install: installs pipx via mise.
# install_pkg: `pipx install <name>` (optionally with version specifier).
# uninstall_pkg: `pipx uninstall <name>`.
# interrogate: `pipx list --json` → parse JSON; venvs keys are package names.

after = ["mise"]
pm_name = "pipx"

def install(ctx):
    pkg(manager="mise", name="pipx", version="latest")

def _activate_shims(ctx):
    if ctx.which("mise"):
        result = ctx.run("mise", ["bin-paths"])
        for path in result.stdout.splitlines():
            path = path.strip()
            if path:
                ctx.add_path(path)

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("pipx", ["--version"])

def install_pkg(ctx, name, version, **kwargs):
    if version:
        ctx.run("pipx", ["install", "%s==%s" % (name, version)])
    else:
        ctx.run("pipx", ["install", name])

def uninstall_pkg(ctx, name, version, **kwargs):
    _activate_shims(ctx)
    ctx.run("pipx", ["uninstall", name])

def interrogate(ctx):
    _activate_shims(ctx)
    result = ctx.run("pipx", ["list", "--json"])
    data = json.decode(result.stdout)
    return list(data["venvs"].keys())
