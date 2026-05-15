# components/mise.star
#
# pm_name:  mise
# platform: all
# after:    ["brew", "apt", "dnf", "pacman", "apk"]
#
# PM kwargs: none
#
# Installs mise via the native package manager for the current platform.
# Falls back to the official curl installer on platforms without a known
# native package manager component.
#
# Version format: <name>@<version> passed verbatim to `mise install`.
# interrogate: `mise ls --installed --json` → JSON object; keys are tool names.
# Each key is accepted verbatim by install_pkg as the `name` argument.

pm_name = "mise"
after = ["brew", "apt", "dnf", "pacman", "apk"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager="brew", name="mise")
    elif p.os == "linux":
        if p.distro == "ubuntu" or p.distro == "debian" or "debian" in p.distro_like:
            pkg(manager="apt", name="mise")
        elif p.distro == "fedora" or p.distro == "rhel" or "fedora" in p.distro_like:
            pkg(manager="dnf", name="mise")
        elif p.distro == "arch":
            pkg(manager="pacman", name="mise")
        elif p.distro == "alpine":
            pkg(manager="apk", name="mise")
        else:
            # Fallback: official curl installer for unrecognised Linux distros.
            # Guard: skip if mise is already on PATH (idempotency).
            if not ctx.which("mise"):
                ctx.run("curl", ["-fsSL", "https://mise.run", "-o", "/tmp/mise-install.sh"])
                ctx.run("sh", ["/tmp/mise-install.sh"])
                ctx.delete_file("/tmp/mise-install.sh")
    else:
        # Fallback for non-macOS, non-Linux platforms.
        if not ctx.which("mise"):
            ctx.run("curl", ["-fsSL", "https://mise.run", "-o", "/tmp/mise-install.sh"])
            ctx.run("sh", ["/tmp/mise-install.sh"])
            ctx.delete_file("/tmp/mise-install.sh")

def verify(ctx):
    ctx.run("mise", ["--version"])

def shell(ctx):
    ctx.emit("eval \"$(mise activate %s)\"" % ctx.shell)

def install_pkg(ctx, name, version, **kwargs):
    # name: mise tool name (e.g. "node", "python", "rust")
    # version: version string; if provided, passed as <name>@<version>
    if version:
        spec = "%s@%s" % (name, version)
    else:
        spec = name
    ctx.run("mise", ["install", spec])

def uninstall_pkg(ctx, name, version, **kwargs):
    if version:
        spec = "%s@%s" % (name, version)
    else:
        spec = name
    ctx.run("mise", ["uninstall", spec])

def interrogate(ctx):
    result = ctx.run("mise", ["ls", "--installed", "--json"])
    installed = json.decode(result.stdout)
    return list(installed.keys())
