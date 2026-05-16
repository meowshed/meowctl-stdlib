# components/github_release.star
#
# pm_name:  github-release
# platform: all
# after:    ["mise"]
#
# PM kwargs: none
#
# Delegates to mise's github: backend (stable since mise v2025.9.19).
# name format: "owner/repo" (e.g. "cli/cli", "junegunn/fzf")
# uninstall_pkg: unpkg(manager="mise", name="github:owner/repo", version=version)
# interrogate: query_pm("mise") → filter keys starting with "github:"; strip prefix.

after = ["mise"]
pm_name = "github-release"

def _activate_shims(ctx):
    # Re-add mise-managed bin dirs to PATH so mise-installed github release
    # tools are findable in verify.
    if ctx.which("mise"):
        result = ctx.run("mise", ["bin-paths"])
        for path in result.stdout.splitlines():
            path = path.strip()
            if path:
                ctx.add_path(path)

def install(ctx):
    # mise handles all github: installs; nothing to bootstrap here.
    pass

def verify(ctx):
    _activate_shims(ctx)

def install_pkg(ctx, name, version, **kwargs):
    # name: "owner/repo"
    pkg(manager="mise", name="github:%s" % name, version=version)

def uninstall_pkg(ctx, name, version, **kwargs):
    # Call mise directly to avoid PMRegistry dispatch — more reliable than
    # routing through unpkg(manager="mise", ...) which requires the mise handler
    # to be available in the current phase's registry context.
    spec = "github:%s" % name
    if version:
        versioned_spec = "%s@%s" % (spec, version)
    else:
        versioned_spec = spec
    ctx.run("mise", ["use", "--global", "--remove", spec])
    ctx.run("mise", ["uninstall", versioned_spec])

def interrogate(ctx):
    # query_pm("mise") returns all mise-managed tool names; filter for github: prefix.
    all_tools = query_pm("mise")
    names = []
    for key in all_tools:
        if key.startswith("github:"):
            names.append(key[len("github:"):])
    return names
