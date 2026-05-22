# components/fish_autopair.star
#
# platform: all
# after:     ["@stdlib//components/fish"]
#
# autopair.fish — auto-close brackets and quotes in fish.
# Installed via fisher (fish plugin manager).

after = ["@stdlib//components/fish"]

def install(ctx):
    pkg(manager = "fisher", name = "jorgebucaran/autopair.fish")

def verify(ctx):
    ctx.run("grep", ["-qF", "autopair.fish", ctx.home + "/.config/fish/fish_plugins"])

def upgrade(ctx):
    uppkg(manager = "fisher", name = "jorgebucaran/autopair.fish")

def uninstall(ctx):
    unpkg(manager = "fisher", name = "jorgebucaran/autopair.fish")
