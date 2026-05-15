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

def install(ctx):
    # mise handles all github: installs; nothing to bootstrap here.
    pass

def verify(ctx):
    # mise is already verified by its own component; nothing to check here.
    pass

def install_pkg(ctx, name, version, **kwargs):
    # name: "owner/repo"
    pkg(manager="mise", name="github:%s" % name, version=version)

def uninstall_pkg(ctx, name, version, **kwargs):
    unpkg(manager="mise", name="github:%s" % name, version=version or "")

def interrogate(ctx):
    # query_pm("mise") returns all mise-managed tool names; filter for github: prefix.
    all_tools = query_pm("mise")
    names = []
    for key in all_tools:
        if key.startswith("github:"):
            names.append(key[len("github:"):])
    return names
