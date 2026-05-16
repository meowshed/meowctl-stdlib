# components/forgit.star
#
# platform: all
# after:     ["@stdlib//components/fzf"]
#
# forgit interactive git commands via fzf.
# No mise backend; brew on macOS, pacman on Arch, git clone elsewhere.

after = ["@stdlib//components/fzf"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager="brew", name="forgit")
    elif p.os == "linux":
        if p.distro == "arch" or p.distro_like == "arch":
            pkg(manager="pacman", name="forgit")
        else:
            # No package available; clone to ~/.forgit
            home = ctx.env("HOME")
            if home:
                ctx.run("git", ["clone", "https://github.com/wfxr/forgit.git", home + "/.forgit"])
                ctx.append_file(home + "/.bashrc", "source ~/.forgit/forgit.plugin.sh\n")

def verify(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.run("test", ["-d", home + "/.forgit"])
    else:
        ctx.run("brew", ["list", "--formula", "forgit"])
