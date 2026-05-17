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
# interrogate: non-Alpine: `mise ls --installed --json` → filter keys with "pipx:" prefix;
#              strip prefix to return bare names.
#              Alpine: `pipx list --short` → first field of each "name version" line.

after = ["@stdlib//components/mise"]
pm_name = "python"

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def _activate_pipx_bin(ctx):
    # On Alpine, pipx is installed via pip3 into the user scheme; its own binary
    # and any tools it installs land in ~/.local/bin, which is not in $PATH by
    # default in container environments.
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/bin")

def _is_alpine(p):
    return p.os == "linux" and (p.distro == "alpine" or p.distro_like == "alpine")

def install(ctx):
    # On Alpine (musl), mise compiles python from source (slow, complex deps).
    # Use the Alpine system packages instead — mise can still manage pipx:
    # backend packages on top of the system python.
    p = platform()
    if _is_alpine(p):
        pkg(manager = "apk", name = "python3")
        pkg(manager = "apk", name = "py3-pip")

        # On Alpine there is no mise-managed python; install pipx via pip3.
        ctx.run("pip3", ["install", "--break-system-packages", "pipx"])
    else:
        pkg(manager = "mise", name = "python", version = "latest")

        # mise's pipx backend requires pipx to be installed first.
        _activate_shims(ctx)
        ctx.run("mise", ["use", "--global", "pipx@latest"])

def upgrade(ctx):
    p = platform()
    if _is_alpine(p):
        uppkg(manager = "apk", name = "python3")
        uppkg(manager = "apk", name = "py3-pip")
    else:
        uppkg(manager = "mise", name = "python")

def uninstall(ctx):
    p = platform()
    if _is_alpine(p):
        unpkg(manager = "apk", name = "python3")
        unpkg(manager = "apk", name = "py3-pip")
    else:
        unpkg(manager = "mise", name = "python")

def verify(ctx):
    # On Alpine, python3 comes from apk — no mise shims needed.
    # Add ~/.local/bin so pipx-installed tool binaries are visible.
    p = platform()
    if _is_alpine(p):
        _activate_pipx_bin(ctx)
    else:
        _activate_shims(ctx)
    ctx.run("python3", ["--version"])

def install_pkg(ctx, name, version, **kwargs):
    p = platform()
    if _is_alpine(p):
        # On Alpine there is no mise-managed python; use pipx directly.
        # pipx and its installed tool binaries live in ~/.local/bin.
        _activate_pipx_bin(ctx)
        if version and version != "latest":
            ctx.run("pipx", ["install", "%s==%s" % (name, version)])
        else:
            ctx.run("pipx", ["install", name])
    else:
        _activate_shims(ctx)
        if version and version != "latest":
            spec = "pipx:%s@%s" % (name, version)
        else:
            spec = "pipx:%s" % name
        ctx.run("mise", ["use", "--global", spec])

def uninstall_pkg(ctx, name, version, **kwargs):
    p = platform()
    if _is_alpine(p):
        _activate_pipx_bin(ctx)
        ctx.run("pipx", ["uninstall", name])
    else:
        _activate_shims(ctx)
        ctx.run("mise", ["use", "--global", "--remove", "pipx:%s" % name])
        if version:
            ctx.run("mise", ["uninstall", "pipx:%s@%s" % (name, version)])
        else:
            ctx.run("mise", ["uninstall", "pipx:%s" % name])

def interrogate(ctx):
    p = platform()
    if _is_alpine(p):
        # On Alpine, pipx is not managed by mise; query pipx directly.
        _activate_pipx_bin(ctx)
        result = ctx.run("pipx", ["list", "--short"])
        names = []
        for line in result.stdout.splitlines():
            line = line.strip()
            if line:
                # `pipx list --short` emits "name version" pairs; take the first field.
                names.append(line.split()[0])
        return names
    _activate_shims(ctx)
    result = ctx.run("mise", ["ls", "--installed", "--json"])
    installed = json.decode(result.stdout)
    names = []
    for key in installed.keys():
        if key.startswith("pipx:"):
            names.append(key[5:])
    return names
