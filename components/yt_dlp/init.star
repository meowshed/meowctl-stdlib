# components/yt_dlp.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# yt-dlp — media downloader for YouTube and many other sites.
# https://github.com/yt-dlp/yt-dlp
# Installed via mise.

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "yt-dlp", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("yt-dlp", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "yt-dlp")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "yt-dlp")
