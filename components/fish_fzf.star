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
    ctx.run("fish", ["--no-config", "-c", "source ~/.config/fish/functions/fisher.fish; fisher list | grep -F fzf.fish"])

def upgrade(ctx):
    uppkg(manager = "fisher", name = "patrickf1/fzf.fish")

def uninstall(ctx):
    unpkg(manager = "fisher", name = "patrickf1/fzf.fish")
