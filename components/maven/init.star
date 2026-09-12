# components/maven.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# Apache Maven build tool for JVM projects.
# https://maven.apache.org
# Installed via mise.

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "maven", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("mvn", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "maven")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "maven")
