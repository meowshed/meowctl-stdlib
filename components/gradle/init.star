# components/gradle.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# Gradle build tool for JVM projects.
# https://gradle.org
# Installed via mise.

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "gradle", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("gradle", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "gradle")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "gradle")
