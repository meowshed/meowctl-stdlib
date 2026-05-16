# components/rust.star
#
# pm_name:  cargo
# platform: all
# after:    ["mise"]
#
# PM kwargs: none
#
# Rust crates are installed via `mise use --global cargo:<name>`.
# mise's cargo backend calls `cargo install` and shims the binaries via
# ~/.local/share/mise/shims automatically.
#
# Pinning: cargo does not lock installed binaries; pass an explicit version
# for reproducible installs.
#
# interrogate: `mise ls --installed --json` → filter keys with "cargo:" prefix.

after = ["@stdlib//components/mise"]
pm_name = "cargo"

def install(ctx):
    # Ensure a C linker is available for `cargo install` (compiling crates).
    p = platform()
    if p.os == "linux":
        if p.distro == "ubuntu" or p.distro == "debian" or p.distro_like == "debian":
            pkg(manager="apt", name="build-essential")
        elif p.distro == "fedora" or p.distro == "rhel" or p.distro_like == "fedora" or p.distro_like == "rhel":
            pkg(manager="dnf", name="gcc")
        elif p.distro == "arch" or p.distro_like == "arch":
            pkg(manager="pacman", name="base-devel")
        elif p.distro == "alpine" or p.distro_like == "alpine":
            pkg(manager="apk", name="build-base")
    pkg(manager="mise", name="rust", version="latest")

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("cargo", ["--version"])

def install_pkg(ctx, name, version, **kwargs):
    _activate_shims(ctx)
    if version:
        spec = "cargo:%s@%s" % (name, version)
    else:
        spec = "cargo:%s" % name
    ctx.run("mise", ["use", "--global", spec])

def uninstall_pkg(ctx, name, version, **kwargs):
    _activate_shims(ctx)
    ctx.run("mise", ["use", "--global", "--remove", "cargo:%s" % name])
    if version:
        ctx.run("mise", ["uninstall", "cargo:%s@%s" % (name, version)])
    else:
        ctx.run("mise", ["uninstall", "cargo:%s" % name])

def interrogate(ctx):
    _activate_shims(ctx)
    result = ctx.run("mise", ["ls", "--installed", "--json"])
    installed = json.decode(result.stdout)
    names = []
    for key in installed.keys():
        if key.startswith("cargo:"):
            names.append(key[6:])
    return names
