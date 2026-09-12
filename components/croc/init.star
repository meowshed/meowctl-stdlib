# components/croc.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# croc — securely send files and folders between computers.
# https://github.com/schollz/croc
# Installed via mise (aqua backend, prebuilt binary).

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "croc", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("croc", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "croc")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "croc")
