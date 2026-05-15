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
# interrogate: `pipx list --short` → lines of the form `<name> <version>`;
#              returns the tool names.

after = ["mise"]
pm_name = "pipx"

def install(ctx):
    pkg(manager="mise", name="pipx", version="latest")

def verify(ctx):
    ctx.run("pipx", ["--version"])

def install_pkg(ctx, name, version, **kwargs):
    if version:
        ctx.run("pipx", ["install", "%s==%s" % (name, version)])
    else:
        ctx.run("pipx", ["install", name])

def uninstall_pkg(ctx, name, version, **kwargs):
    ctx.run("pipx", ["uninstall", name])

def interrogate(ctx):
    result = ctx.run("pipx", ["list", "--short"])
    names = []
    for line in result.stdout.splitlines():
        line = line.strip()
        if line:
            # Format: "package version, ..."  — first word is the package name
            names.append(line.split(" ")[0])
    return names
