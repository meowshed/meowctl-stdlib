# components/rust.star
#
# pm_name:  cargo
# platform: all
# after:    ["mise"]
#
# PM kwargs: none
#
# Pinning: cargo does not lock installed binaries; `cargo install --list`
# shows the current version but meowctl cannot guarantee exact version on
# reinstall when no explicit version is given.
# interrogate: `cargo install --list` → lines ending in `:` are `<name> v<ver>:`;
#              extract the name (first word before the space).

after = ["mise"]
pm_name = "cargo"

def install(ctx):
    # Ensure a C linker is available for `cargo install` (compiling crates).
    p = platform()
    if p.os == "linux":
        if p.distro == "arch" or p.distro_like == "arch":
            pkg(manager="pacman", name="base-devel")
        elif p.distro == "alpine" or p.distro_like == "alpine":
            pkg(manager="apk", name="build-base")
    pkg(manager="mise", name="rust", version="latest")

def _activate_shims(ctx):
    if ctx.which("mise"):
        result = ctx.run("mise", ["bin-paths"])
        for path in result.stdout.splitlines():
            path = path.strip()
            if path:
                ctx.add_path(path)

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("cargo", ["--version"])

def install_pkg(ctx, name, version, **kwargs):
    _activate_shims(ctx)
    if version:
        ctx.run("cargo", ["install", name, "--version", version])
    else:
        ctx.run("cargo", ["install", name])

def uninstall_pkg(ctx, name, version, **kwargs):
    _activate_shims(ctx)
    ctx.run("cargo", ["uninstall", name])

def interrogate(ctx):
    _activate_shims(ctx)
    result = ctx.run("cargo", ["install", "--list"])
    names = []
    for line in result.stdout.splitlines():
        # Lines for installed crates end with `:`, e.g. `ripgrep v13.0.0:`
        if line.endswith(":") and not line.startswith(" "):
            names.append(line.split(" ")[0])
    return names
