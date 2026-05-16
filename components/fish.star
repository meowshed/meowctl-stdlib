# components/fish.star
#
# pm_name:  fisher
# platform: all
# after:    ["brew", "apt", "dnf", "pacman", "apk"]
#
# PM kwargs: none
#
# Installs the fish shell via the native package manager. mise does not carry
# fish in its standard registry; native PMs are preferred so fish lands in the
# system path (/usr/bin/fish or /usr/local/bin/fish) where chsh and /etc/shells
# expect it.
#
# After installing fish, the install hook:
#   1. Adds fish to /etc/shells if not already present.
#   2. Sets fish as the default shell for the current user via chsh.
#   3. Bootstraps fisher (the fish plugin manager) via its official curl
#      installer — fisher is not packaged anywhere else.
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
after = ["@stdlib//components/brew", "@stdlib//components/apt", "@stdlib//components/dnf", "@stdlib//components/pacman", "@stdlib//components/apk"]

def _fish_bin(ctx):
    found = ctx.which("fish")
    if found:
        return found
    p = platform()
    if p.os == "macos":
        return "/usr/local/bin/fish"
    return "/usr/bin/fish"

def _install_fisher(ctx):
    # Bootstrap fisher using the official curl installer, run inside fish.
    # Fisher is not packaged anywhere; this is the only supported path.
    ctx.run("fish", ["-c", "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"])

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager="brew", name="fish")
    elif p.os == "linux":
        if p.distro == "ubuntu" or p.distro == "debian" or p.distro_like == "debian":
            pkg(manager="apt", name="fish")
        elif p.distro == "fedora" or p.distro == "rhel" or p.distro_like == "fedora" or p.distro_like == "rhel":
            pkg(manager="dnf", name="fish")
        elif p.distro == "arch":
            pkg(manager="pacman", name="fish")
        elif p.distro == "alpine":
            pkg(manager="apk", name="fish")
        else:
            ctx.log("fish: unsupported distro %r — install fish manually then re-run" % p.distro)
            return

    fish = _fish_bin(ctx)

    # Add fish to /etc/shells if not already listed (required for chsh).
    shells = ctx.read_file("/etc/shells")
    if fish not in shells:
        ctx.append_file("/etc/shells", fish + "\n")

    # Set fish as the default shell for the current user.
    ctx.run("chsh", ["-s", fish])

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
