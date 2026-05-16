# components/flatpak.star
#
# pm_name:  flatpak
# platform: linux only (no-op on macOS)
# after:    ["apt", "dnf", "pacman"]
#
# PM kwargs:
#   remote="flathub" — flatpak remote name (default: "flathub")
#   system=True      — install system-wide instead of --user (default: False = user)
#
# flatpak is installed via the native package manager. The Flathub remote is
# added automatically on first install if not already present.
#
# App name format: reverse-DNS application ID (e.g. "org.mozilla.firefox").
# Version is ignored — flatpak tracks the latest ref on the given remote.
#
# interrogate: `flatpak list --app --columns=application` →
#              one application ID per line (skip header).

pm_name = "flatpak"
after = ["@stdlib//components/apt", "@stdlib//components/dnf", "@stdlib//components/pacman"]

def _ensure_flathub(ctx, system):
    scope_args = [] if system else ["--user"]
    ctx.run("flatpak", scope_args + ["remote-add", "--if-not-exists", "flathub", "https://dl.flathub.org/repo/flathub.flatpakrepo"])

def install(ctx):
    p = platform()
    if p.os != "linux":
        return
    if p.distro == "ubuntu" or p.distro == "debian" or p.distro_like == "debian":
        pkg(manager="apt", name="flatpak")
    elif p.distro == "fedora" or p.distro == "rhel" or p.distro_like == "fedora" or p.distro_like == "rhel":
        pkg(manager="dnf", name="flatpak")
    elif p.distro == "arch":
        pkg(manager="pacman", name="flatpak")
    else:
        ctx.log("flatpak: unsupported distro %r — install flatpak manually then re-run" % p.distro)
        return
    _ensure_flathub(ctx, False)

def verify(ctx):
    p = platform()
    if p.os != "linux":
        return
    ctx.run("flatpak", ["--version"])

def install_pkg(ctx, name, version, **kwargs):
    p = platform()
    if p.os != "linux":
        return
    remote = kwargs.get("remote", "flathub")
    system = kwargs.get("system", False)
    scope_args = [] if system else ["--user"]
    ctx.run("flatpak", scope_args + ["install", "-y", remote, name])

def uninstall_pkg(ctx, name, version, **kwargs):
    p = platform()
    if p.os != "linux":
        return
    system = kwargs.get("system", False)
    scope_args = [] if system else ["--user"]
    ctx.run("flatpak", scope_args + ["uninstall", "-y", name])

def interrogate(ctx):
    p = platform()
    if p.os != "linux":
        return []
    result = ctx.run("flatpak", ["list", "--app", "--columns=application"])
    names = []
    for line in result.stdout.splitlines():
        line = line.strip()
        # Skip the header row emitted by some flatpak versions ("Application").
        # Use a content check rather than a positional first-line skip so that
        # flatpak builds that omit the header don't silently drop the first app.
        if not line or line.lower() == "application":
            continue
        names.append(line)
    return names
