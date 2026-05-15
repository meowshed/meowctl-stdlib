# components/fish.star
#
# pm_name:  fisher
# platform: all
# after:    ["mise"]
#
# PM kwargs: none
#
# Installs the fish shell via mise, then bootstraps fisher (the fish plugin
# manager) via its official curl installer — fisher has no upstream package and
# is only distributed this way.
#
# shell hook: emits nothing — fish reads ~/.config/fish/config.fish directly;
#             no eval-based activation is needed. The hook is present so that
#             meowctl registers fish as a managed shell.
#
# install_pkg / uninstall_pkg manage fish plugins via `fisher install` /
# `fisher remove`, both run inside fish.
#
# Plugin name format: GitHub slug (e.g. "jorgebucaran/autopair.fish") or any
# name accepted by fisher. Version is ignored — fisher pins via its lock file.
#
# interrogate: `fish -c "fisher list"` → one plugin slug per line.

pm_name = "fisher"
after = ["mise"]

def _install_fisher(ctx):
    # Bootstrap fisher using the official curl installer, run inside fish.
    # This is the only supported distribution path for fisher.
    ctx.run("fish", ["-c", "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"])

def install(ctx):
    pkg(manager="mise", name="fish")
    _install_fisher(ctx)

def verify(ctx):
    ctx.run("fish", ["--version"])

def shell(ctx):
    # fish does not require eval-based activation; the hook is intentionally
    # empty so meowctl recognises fish as a managed shell without emitting noise.
    pass

def install_pkg(ctx, name, version, **kwargs):
    # version is ignored — fisher manages versions via its lock file.
    ctx.run("fish", ["-c", "fisher install %s" % name])

def uninstall_pkg(ctx, name, version, **kwargs):
    ctx.run("fish", ["-c", "fisher remove %s" % name])

def interrogate(ctx):
    result = ctx.run("fish", ["-c", "fisher list"])
    names = []
    for line in result.stdout.splitlines():
        line = line.strip()
        if line:
            names.append(line)
    return names
