# components/sd.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# sd — intuitive find-and-replace (sed alternative).
# Installed via mise (aqua backend, prebuilt binary).

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "sd", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("sd", ["--version"])
