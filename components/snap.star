# components/snap.star
#
# pm_name:  snap
# platform: linux only (no-op on macOS)
# after:    ["apt", "dnf"]
#
# PM kwargs:
#   classic=True   — install with --classic confinement
#   channel="edge" — snap channel (default: stable)
#
# snapd is installed via the native package manager on supported distros.
# On distros where snapd is pre-installed (e.g. Ubuntu) the install hook is
# effectively idempotent — `apt install snapd` is a no-op if already present.
# snapd is not available in Arch official repos (AUR-only); unsupported here.
#
# interrogate: `snap list` → lines of "<name> <version> ..."; skip header line.
# Returns snap names (first field of each data line).

pm_name = "snap"
after = ["@stdlib//components/apt", "@stdlib//components/dnf"]

def install(ctx):
    p = platform()
    if p.os != "linux":
        return
    if p.distro == "ubuntu" or p.distro == "debian" or p.distro_like == "debian":
        pkg(manager="apt", name="snapd")
    elif p.distro == "fedora" or p.distro == "rhel" or p.distro_like == "fedora" or p.distro_like == "rhel":
        pkg(manager="dnf", name="snapd")
    else:
        ctx.log("snap: snapd not available for distro %r — install snapd manually then re-run" % p.distro)

def verify(ctx):
    p = platform()
    if p.os != "linux":
        return
    ctx.run("snap", ["--version"])

def install_pkg(ctx, name, version, **kwargs):
    p = platform()
    if p.os != "linux":
        return
    classic = kwargs.get("classic", False)
    channel = kwargs.get("channel", "")
    snap_args = ["install", name]
    if classic:
        snap_args.append("--classic")
    if channel:
        snap_args = snap_args + ["--channel", channel]
    ctx.run("snap", snap_args)

def uninstall_pkg(ctx, name, version, **kwargs):
    p = platform()
    if p.os != "linux":
        return
    ctx.run("snap", ["remove", name])

def interrogate(ctx):
    p = platform()
    if p.os != "linux":
        return []
    result = ctx.run("snap", ["list"])
    names = []
    for line in result.stdout.splitlines():
        line = line.strip()
        # Skip the header row ("Name ...") by content rather than position,
        # consistent with the flatpak interrogate approach.
        if not line or line.lower().startswith("name ") or line.lower() == "name":
            continue
        names.append(line.split()[0])
    return names
