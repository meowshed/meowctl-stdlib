# components/vscode.star
#
# pm_name:  vscode
# platform: all
# after:    ["mise"]
#
# PM kwargs: none
#
# Installs VS Code via mise. On macOS this also registers the `code` CLI.
# install_pkg / uninstall_pkg manage VS Code extensions via the `code` CLI.
# Extension name format: publisher.extensionName (e.g. "ms-python.python").
# Version is ignored — VS Code extensions self-update via the marketplace.
#
# interrogate: `code --list-extensions` → one extension ID per line.

pm_name = "vscode"
after = ["mise"]

def install(ctx):
    pkg(manager="mise", name="vscode")

def verify(ctx):
    ctx.run("code", ["--version"])

def install_pkg(ctx, name, version, **kwargs):
    # version is ignored — VS Code extension marketplace does not support
    # pinning via the CLI installer.
    ctx.run("code", ["--install-extension", name, "--force"])

def uninstall_pkg(ctx, name, version, **kwargs):
    ctx.run("code", ["--uninstall-extension", name])

def interrogate(ctx):
    result = ctx.run("code", ["--list-extensions"])
    names = []
    for line in result.stdout.splitlines():
        line = line.strip()
        if line:
            names.append(line)
    return names
