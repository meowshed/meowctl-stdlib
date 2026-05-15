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
    pkg(manager="mise", name="rust", version="latest")

def verify(ctx):
    ctx.run("cargo", ["--version"])

def install_pkg(ctx, name, version, **kwargs):
    if version:
        ctx.run("cargo", ["install", name, "--version", version])
    else:
        ctx.run("cargo", ["install", name])

def uninstall_pkg(ctx, name, version, **kwargs):
    ctx.run("cargo", ["uninstall", name])

def interrogate(ctx):
    result = ctx.run("cargo", ["install", "--list"])
    names = []
    for line in result.stdout.splitlines():
        # Lines for installed crates end with `:`, e.g. `ripgrep v13.0.0:`
        if line.endswith(":") and not line.startswith(" "):
            names.append(line.split(" ")[0])
    return names
