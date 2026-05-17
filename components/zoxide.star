# components/zoxide.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# Zoxide smart cd replacement.
# Installed via mise (aqua backend, prebuilt binary).

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "zoxide", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("zoxide", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "zoxide")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "zoxide")

def shell(ctx):
    if ctx.shell in ("fish", "bash", "zsh"):
        ctx.emit("eval \"$(zoxide init %s)\"" % ctx.shell)
