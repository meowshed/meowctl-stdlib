# components/eza.star
#
# platform: all
# after:     ["@stdlib//components/rust"]
#
# eza modern ls replacement.
# No mise aqua backend; brew on macOS, cargo on Debian/Ubuntu, native PM elsewhere.

after = ["@stdlib//components/rust"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "eza")
    elif p.os == "linux":
        if p.distro == "ubuntu" or p.distro == "debian" or p.distro_like == "debian":
            # eza not in official apt repos; install via cargo
            _activate_shims(ctx)
            pkg(manager = "cargo", name = "eza")
        elif p.distro == "fedora" or p.distro == "rhel" or p.distro_like == "fedora" or p.distro_like == "rhel":
            pkg(manager = "dnf", name = "eza")
        elif p.distro == "arch" or p.distro_like == "arch":
            pkg(manager = "pacman", name = "eza")
        elif p.distro == "alpine" or p.distro_like == "alpine":
            pkg(manager = "apk", name = "eza")
        else:
            _activate_shims(ctx)
            pkg(manager = "cargo", name = "eza")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("eza", ["--version"])
