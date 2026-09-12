# components/syft.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# syft — SBOM generator for container images and filesystems.
# https://github.com/anchore/syft
# Installed via mise.

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "syft", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("syft", ["version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "syft")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "syft")
