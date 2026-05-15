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
# install_pkg: pkg(manager="mise", name="github:owner/repo", version=version)
# uninstall_pkg: delegates to mise uninstall via pkg()
# interrogate: `mise ls --installed --json` → filter keys starting with
#              "github:"; strip prefix to return "owner/repo" strings.

after = ["mise"]
pm_name = "github-release"

def install(ctx):
    # mise handles all github: installs; nothing to bootstrap here.
    pass

def verify(ctx):
    ctx.run("mise", ["--version"])

def install_pkg(ctx, name, version, **kwargs):
    # name: "owner/repo"
    pkg(manager="mise", name="github:%s" % name, version=version)

def uninstall_pkg(ctx, name, version, **kwargs):
    # mise uninstall is not exposed via pkg(); call mise directly as the PM itself.
    if version:
        spec = "github:%s@%s" % (name, version)
    else:
        spec = "github:%s" % name
    ctx.run("mise", ["uninstall", spec])

def interrogate(ctx):
    result = ctx.run("mise", ["ls", "--installed", "--json"])
    installed = json.decode(result.stdout)
    names = []
    for key in installed.keys():
        if key.startswith("github:"):
            names.append(key[len("github:"):])
    return names
