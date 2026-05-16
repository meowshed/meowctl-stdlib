# tests/fixtures/components/test-pipx.star
# Installs yt-dlp via pipx (mise pipx backend). Widely available, fast to install.
after = ["@stdlib//components/pipx"]

pkg(manager = "pipx", name = "yt-dlp")

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("yt-dlp", ["--version"])
