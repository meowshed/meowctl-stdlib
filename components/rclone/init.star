# components/rclone.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# rclone — sync files to and from cloud storage providers.
# https://rclone.org
# Installed via mise.

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "rclone", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("rclone", ["version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "rclone")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "rclone")
