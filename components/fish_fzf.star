# components/fish_fzf.star
#
# platform: all
# after:     ["@stdlib//components/fish"]
#
# fzf.fish — fzf key bindings and completions for fish.
# Installed via fisher (fish plugin manager).

after = ["@stdlib//components/fish"]

def install(ctx):
    pkg(manager = "fisher", name = "patrickf1/fzf.fish")

def verify(ctx):
    # fish_plugins is the source of truth — fisher list requires universal
    # variables which are unavailable in --no-config mode.
    ctx.run("grep", ["-qF", "fzf.fish", ctx.home + "/.config/fish/fish_plugins"])

def upgrade(ctx):
    uppkg(manager = "fisher", name = "patrickf1/fzf.fish")

def uninstall(ctx):
    unpkg(manager = "fisher", name = "patrickf1/fzf.fish")
