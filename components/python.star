# components/python.star
#
# pm_name:  python
# platform: all
# after:    ["mise"]
#
# PM kwargs: none
#
# Installs Python via mise and manages Python CLI tools via the mise pipx
# backend (`mise use --global pipx:<name>`). mise auto-selects uv when
# available for faster installs; no need to expose uv or pipx as separate
# components.
#
# On Alpine, mise compiles python from source (slow, complex deps). Use the
# Alpine system packages instead. pipx is then installed via pip3 directly
# rather than through mise, since there is no mise-managed python to anchor to.
#
# interrogate: `mise ls --installed --json` → filter keys with "pipx:" prefix;
#              strip the prefix to return bare package names.

after = ["@stdlib//components/mise"]
pm_name = "python"

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    # On Alpine (musl), mise compiles python from source (slow, complex deps).
    # Use the Alpine system packages instead — mise can still manage pipx:
    # backend packages on top of the system python.
    p = platform()
    if p.os == "linux" and (p.distro == "alpine" or p.distro_like == "alpine"):
        pkg(manager="apk", name="python3")
        pkg(manager="apk", name="py3-pip")
        # On Alpine there is no mise-managed python; install pipx via pip3.
        ctx.run("pip3", ["install", "--break-system-packages", "pipx"])
    else:
        pkg(manager="mise", name="python", version="latest")
        # mise's pipx backend requires pipx to be installed first.
        _activate_shims(ctx)
        ctx.run("mise", ["use", "--global", "pipx@latest"])

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("python3", ["--version"])

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
