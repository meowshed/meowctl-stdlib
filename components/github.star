# components/github.star
#
# pm_name:  github
# platform: all
# after:    ["mise"]
#
# PM kwargs: none
#
# Delegates to mise's github: backend (stable since mise v2025.9.19).
# name format: "owner/repo" (e.g. "cli/cli", "junegunn/fzf")
# uninstall_pkg: ctx.run("mise", ["use", "--global", "--remove", "github:owner/repo"])
# interrogate: mise ls --installed --json → filter keys starting with "github:"; strip prefix.

after = ["@stdlib//components/mise"]
pm_name = "github"

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    # Enable experimental backends required for github: tool installs.
    ctx.run("mise", ["settings", "experimental", "true"])

def verify(ctx):
    _activate_shims(ctx)
    # Confirm mise is reachable. Note: checking whether `experimental` is
    # enabled via `mise settings` is unreliable because the command exits 0
    # regardless of the value. We verify mise is installed; the github:
    # backend will fail at install_pkg time with a clear error if experimental
    # is not set.
    ctx.run("mise", ["--version"])

def install_pkg(ctx, name, version, **kwargs):
    # name: "owner/repo"
    _activate_shims(ctx)
    spec = "github:%s@%s" % (name, version) if version else "github:%s" % name
    ctx.run("mise", ["use", "--global", spec])

def uninstall_pkg(ctx, name, version, **kwargs):
    _activate_shims(ctx)
    spec = "github:%s" % name
    # mise use --remove takes the unversioned spec; mise uninstall takes the versioned one.
    uninstall_spec = "%s@%s" % (spec, version) if version else spec
    ctx.run("mise", ["use", "--global", "--remove", spec])
    ctx.run("mise", ["uninstall", uninstall_spec])

def interrogate(ctx):
    _activate_shims(ctx)
    result = ctx.run("mise", ["ls", "--installed", "--json"])
    installed = json.decode(result.stdout)
    return [k[len("github:"):] for k in installed.keys() if k.startswith("github:")]
