# tests/fixtures/components/test-pipx.star
# Installs yt-dlp via pipx. Widely available, fast to install.
after = ["@stdlib//components/pipx.star"]

pkg(manager = "pipx", name = "yt-dlp")

def verify(ctx):
    ctx.run("yt-dlp", ["--version"])
