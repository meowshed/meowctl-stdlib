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
    ctx.run("fish", ["-c", "fisher list | grep bass"])
