# components/forgit.star
#
# platform: all
# after:     ["@stdlib//components/fish", "@stdlib//components/fzf"]
#
# forgit — interactive git commands powered by fzf.
# Installed as a fisher plugin (fish shell).

after = [
    "@stdlib//components/fish",
    "@stdlib//components/fzf",
]

def install(ctx):
    pkg(manager = "fisher", name = "wfxr/forgit")

def verify(ctx):
    ctx.run("fish", ["-c", "fisher list | grep forgit"])

def upgrade(ctx):
    uppkg(manager = "fisher", name = "wfxr/forgit")

def uninstall(ctx):
    unpkg(manager = "fisher", name = "wfxr/forgit")
