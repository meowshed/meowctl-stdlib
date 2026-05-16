# components/fzf.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# fzf fuzzy finder.
# Installed via mise (aqua backend, prebuilt binary).

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "fzf", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("fzf", ["--version"])
