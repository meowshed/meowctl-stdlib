# tests/fixtures/components/test-pipx.star
# Installs yt-dlp via pipx. Widely available, fast to install.
after = ["@stdlib//components/pipx"]

pkg(manager = "pipx", name = "yt-dlp")

def _activate_shims(ctx):
    # Add mise shims dir (covers pipx itself) and PIPX_BIN_DIR (covers yt-dlp).
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")
    if ctx.which("pipx"):
        result = ctx.run("pipx", ["environment"])
        for line in result.stdout.splitlines():
            line = line.strip()
            if line.startswith("PIPX_BIN_DIR="):
                bin_dir = line.split("=", 1)[1].strip()
                if bin_dir:
                    ctx.add_path(bin_dir)

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("yt-dlp", ["--version"])
