# components/fish_bass.star
#
# platform: all
# after:     ["@stdlib//components/fish"]
#
# bass — run bash scripts/utilities in fish shell.
# Installed via fisher (fish plugin manager).

after = ["@stdlib//components/fish"]

def install(ctx):
    pkg(manager = "fisher", name = "edc/bass")

def verify(ctx):
    ctx.run("grep", ["-qF", "edc/bass", ctx.home + "/.config/fish/fish_plugins"])

def upgrade(ctx):
    uppkg(manager = "fisher", name = "edc/bass")

def uninstall(ctx):
    unpkg(manager = "fisher", name = "edc/bass")
