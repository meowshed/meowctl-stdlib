# components/mcfly.star
#
# platform: all
# after:     ["@stdlib//components/brew"]
#
# mcfly — fly through your shell history.
# macOS: Homebrew. Linux: native package manager or cargo.

after = ["@stdlib//components/brew"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "mcfly")
    elif p.os == "linux":
        if p.distro_like == "debian":
            pkg(manager = "apt", name = "mcfly")
        elif p.distro_like == "fedora":
            pkg(manager = "dnf", name = "mcfly")
        elif p.distro_like == "arch":
            pkg(manager = "pacman", name = "mcfly")
        else:
            ctx.run("bash", ["-c", "curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sh -s -- --git cantino/mcfly"])

def verify(ctx):
    ctx.run("mcfly", ["--version"])
