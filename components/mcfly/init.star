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

def upgrade(ctx):
    p = platform()
    if p.os == "macos":
        uppkg(manager = "brew", name = "mcfly")
    elif p.os == "linux":
        if p.distro_like == "debian":
            uppkg(manager = "apt", name = "mcfly")
        elif p.distro_like == "fedora":
            uppkg(manager = "dnf", name = "mcfly")
        elif p.distro_like == "arch":
            uppkg(manager = "pacman", name = "mcfly")
        else:
            ctx.log("mcfly: cannot auto-upgrade on distro %r — upgrade manually" % p.distro)

def uninstall(ctx):
    p = platform()
    if p.os == "macos":
        unpkg(manager = "brew", name = "mcfly")
    elif p.os == "linux":
        if p.distro_like == "debian":
            unpkg(manager = "apt", name = "mcfly")
        elif p.distro_like == "fedora":
            unpkg(manager = "dnf", name = "mcfly")
        elif p.distro_like == "arch":
            unpkg(manager = "pacman", name = "mcfly")
        else:
            ctx.log("mcfly: cannot auto-uninstall on distro %r — remove manually" % p.distro)
