# components/trivy.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# trivy — vulnerability and misconfiguration scanner.
# https://trivy.dev
# Installed via mise.

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "trivy", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("trivy", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "trivy")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "trivy")
