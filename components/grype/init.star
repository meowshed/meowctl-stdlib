# components/grype.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# grype — vulnerability scanner for images and SBOMs.
# https://github.com/anchore/grype
# Installed via mise.

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "grype", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("grype", ["version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "grype")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "grype")
