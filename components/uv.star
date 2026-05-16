# components/uv.star
#
# pm_name:  uv
# platform: all
# after:    ["mise"]
#
# PM kwargs: none
#
# uv is a fast Python package and project manager by Astral.
# install: installs uv via mise.
# install_pkg: `uv tool install <name>` (optionally with version constraint).
# uninstall_pkg: `uv tool uninstall <name>`.
# interrogate: `uv tool list` → lines of the form `<name> v<version>`; returns
#              the tool names.

after = ["mise"]
pm_name = "uv"

def install(ctx):
    pkg(manager="mise", name="uv", version="latest")
    # uv tool install puts binaries in $(uv tool dir)/bin; add to PATH so
    # subsequent ctx.run calls can find them without a shell restart.
    if ctx.which("uv"):
        result = ctx.run("uv", ["tool", "dir"])
        tool_dir = result.stdout.strip()
        if tool_dir:
            ctx.add_path(tool_dir + "/bin")

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("uv", ["--version"])
    # Also add $(uv tool dir)/bin so tools installed via `uv tool install`
    # are findable in subsequent verify hooks (e.g. test-uv checking ruff).
    if ctx.which("uv"):
        result = ctx.run("uv", ["tool", "dir"])
        tool_dir = result.stdout.strip()
        if tool_dir:
            ctx.add_path(tool_dir + "/bin")

def install_pkg(ctx, name, version, **kwargs):
    _activate_shims(ctx)
    if version:
        ctx.run("uv", ["tool", "install", "%s==%s" % (name, version)])
    else:
        ctx.run("uv", ["tool", "install", name])

def uninstall_pkg(ctx, name, version, **kwargs):
    _activate_shims(ctx)
    ctx.run("uv", ["tool", "uninstall", name])

def interrogate(ctx):
    _activate_shims(ctx)
    result = ctx.run("uv", ["tool", "list"])
    names = []
    for line in result.stdout.splitlines():
        line = line.strip()
        # Lines starting with "-" are entrypoints under the previous tool; skip.
        # Lines ending with ":" are headers (e.g. "Installed tools:"); skip.
        if line and not line.startswith("-") and not line.endswith(":"):
            # Format: "<name> v<version>"
            names.append(line.split(" ")[0])
    return names
