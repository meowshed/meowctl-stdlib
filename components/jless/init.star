# components/jless.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# jless — command-line JSON viewer with vim-like navigation.
# https://github.com/PaulJuliusMartinez/jless
# Installed via mise (aqua backend, prebuilt binary).

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "jless", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("jless", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "jless")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "jless")
