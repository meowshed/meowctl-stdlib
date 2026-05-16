# components/pandoc.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# pandoc universal document converter.
# Installed via mise (github backend, prebuilt binary).

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager="mise", name="pandoc", version="latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("pandoc", ["--version"])
