# components/tpm.star
#
# platform: all
# after:     ["@stdlib//components/git", "@stdlib//components/tmux"]
#
# tpm — tmux plugin manager.
# https://github.com/tmux-plugins/tpm
# Installed by cloning into ~/.tmux/plugins/tpm, the path tmux.conf expects.

after = [
    "@stdlib//components/git",
    "@stdlib//components/tmux",
]

def _tpm_dir(ctx):
    # Resolve HOME explicitly: ctx.run passes argv straight to exec, so a
    # literal "~" would never be expanded by a shell.
    home = ctx.env("HOME")
    if not home:
        return ""
    return home + "/.tmux/plugins/tpm"

def install(ctx):
    dst = _tpm_dir(ctx)
    if dst:
        # git_clone is idempotent: it skips when the destination exists.
        ctx.git_clone("https://github.com/tmux-plugins/tpm", dst)

def verify(ctx):
    dst = _tpm_dir(ctx)
    if dst:
        ctx.run("test", ["-x", dst + "/tpm"])

def upgrade(ctx):
    dst = _tpm_dir(ctx)
    if dst:
        ctx.run("git", ["-C", dst, "pull", "--ff-only"])

def uninstall(ctx):
    dst = _tpm_dir(ctx)
    if dst:
        ctx.run("rm", ["-rf", dst])
