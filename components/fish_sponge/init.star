# components/fish_sponge.star
#
# platform: all
# after:     ["@stdlib//components/fish"]
#
# sponge — clean fish history of failed and irrelevant commands.
# Installed via fisher (fish plugin manager).

after = ["@stdlib//components/fish"]

def install(ctx):
    pkg(manager = "fisher", name = "meaningful-ooo/sponge")

def verify(ctx):
    ctx.run("fish", ["-c", "fisher list | grep sponge"])

def upgrade(ctx):
    uppkg(manager = "fisher", name = "meaningful-ooo/sponge")

def uninstall(ctx):
    unpkg(manager = "fisher", name = "meaningful-ooo/sponge")
