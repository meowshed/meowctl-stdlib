# components/docker_cli.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# Docker CLI (client only, no daemon).
# Installed via mise (aqua backend, prebuilt binary).

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "docker-cli", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("docker", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "docker-cli")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "docker-cli")
