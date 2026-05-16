# components/go.star
#
# pm_name:  go_install
# platform: all
# after:    ["mise"]
#
# PM kwargs: none
#
# Go tools are installed via `mise use --global go:<import-path>`.
# mise's go backend calls `go install <import-path>@<version>` and places
# the binary in its own tool dir, shimmed via ~/.local/share/mise/shims.
#
# Version format: passed as <name>@<version>; use "latest" when unspecified.
#
# interrogate: `mise ls --installed --json` → filter keys with "go:" prefix;
#              strip the prefix to return the full import path.

after = ["@stdlib//components/mise"]
pm_name = "go_install"

def install(ctx):
    # Enable experimental backends required for go: tool installs.
    ctx.run("mise", ["settings", "experimental", "true"])
    pkg(manager="mise", name="go", version="latest")

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("go", ["version"])

def install_pkg(ctx, name, version, **kwargs):
    _activate_shims(ctx)
    if version:
        spec = "go:%s@%s" % (name, version)
    else:
        spec = "go:%s@latest" % name
    ctx.run("mise", ["use", "--global", spec])

def uninstall_pkg(ctx, name, version, **kwargs):
    _activate_shims(ctx)
    ctx.run("mise", ["use", "--global", "--remove", "go:%s" % name])
    if version:
        ctx.run("mise", ["uninstall", "go:%s@%s" % (name, version)])
    else:
        ctx.run("mise", ["uninstall", "go:%s" % name])

def interrogate(ctx):
    _activate_shims(ctx)
    result = ctx.run("mise", ["ls", "--installed", "--json"])
    installed = json.decode(result.stdout)
    names = []
    for key in installed.keys():
        if key.startswith("go:"):
            names.append(key[3:])
    return names
