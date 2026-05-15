# components/mise.star
#
# pm_name:  mise
# platform: all
# after:    ["brew", "apt", "dnf", "pacman", "apk"]
#
# PM kwargs: none
#
# Installs mise via the native package manager for the current platform.
# On macOS: brew only (brew is the canonical macOS package manager for mise).
# On Linux: distro-native PM with repo setup where required; falls back to
# the official curl installer for unrecognised distros.
#
# Version format: <name>@<version> passed verbatim to `mise use --global`.
# interrogate: `mise ls --installed --json` → JSON object; keys are tool names.
# Each key is accepted verbatim by install_pkg as the `name` argument.

pm_name = "mise"
after = ["brew", "apt", "dnf", "pacman", "apk"]

def _curl_install(ctx):
    # Official curl installer. Guarded by ctx.which for idempotency.
    if not ctx.which("mise"):
        ctx.run("curl", ["-fsSL", "https://mise.run", "-o", "/tmp/mise-install.sh"])
        ctx.run("sh", ["/tmp/mise-install.sh"])
        ctx.delete_file("/tmp/mise-install.sh")

def _activate_shims(ctx):
    # Registers mise shim dirs into the current process PATH so that tools
    # installed by mise are findable by subsequent ctx.run calls.
    # Called after install and again during verify so PATH stays current
    # across all phases in a multi-phase run.
    result = ctx.run("mise", ["bin-paths"])
    for path in result.stdout.splitlines():
        path = path.strip()
        if path:
            ctx.add_path(path)

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager="brew", name="mise")
    elif p.os == "linux":
        if p.distro == "ubuntu" or p.distro == "debian" or p.distro_like == "debian":
            if not ctx.which("mise"):
                repo(
                    manager="apt",
                    key_url="https://mise.jdx.dev/gpg-key.pub",
                    repo_line="deb [signed-by=/etc/apt/keyrings/gpg-key.asc] https://mise.jdx.dev/deb stable main",
                )
                pkg(manager="apt", name="mise")
        elif p.distro == "fedora" or p.distro == "rhel" or p.distro_like == "fedora" or p.distro_like == "rhel":
            if not ctx.which("mise"):
                repo(manager="dnf", copr="jdxcode/mise")
                pkg(manager="dnf", name="mise")
        elif p.distro == "arch":
            pkg(manager="pacman", name="mise")
        elif p.distro == "alpine":
            pkg(manager="apk", name="mise")
        else:
            _curl_install(ctx)
    else:
        _curl_install(ctx)
    _activate_shims(ctx)

def verify(ctx):
    ctx.run("mise", ["--version"])
    _activate_shims(ctx)

def shell(ctx):
    ctx.emit("eval \"$(mise activate %s)\"" % ctx.shell)

def install_pkg(ctx, name, version, **kwargs):
    # name: mise tool name (e.g. "node", "python", "rust")
    # version: version string; if provided, passed as <name>@<version>
    if version:
        spec = "%s@%s" % (name, version)
    else:
        spec = name
    # `mise use --global` installs the tool and registers it in
    # ~/.config/mise/config.toml, activating it for all future shells.
    # This is the correct model for a user-environment setup tool.
    ctx.run("mise", ["use", "--global", spec])
    # Re-activate shims so the new tool is findable in the current process.
    _activate_shims(ctx)

def uninstall_pkg(ctx, name, version, **kwargs):
    if version:
        spec = "%s@%s" % (name, version)
    else:
        spec = name
    # Remove from global config first, then uninstall the binary.
    ctx.run("mise", ["use", "--global", "--remove", name])
    ctx.run("mise", ["uninstall", spec])

def interrogate(ctx):
    result = ctx.run("mise", ["ls", "--installed", "--json"])
    installed = json.decode(result.stdout)
    return list(installed.keys())
