# components/brew.star
#
# pm_name:  brew
# platform: macos (install is no-op on Linux)
# after:    []
#
# PM kwargs:
#   cask=True        — install as a Homebrew cask (GUI app)
#   tap="owner/repo" — tap to add before installing the formula/cask
#
# Homebrew has no upstream package manager to install it from on a fresh macOS
# system; the official curl installer is the only supported bootstrap path.
# install_pkg / uninstall_pkg delegate to `brew install` / `brew uninstall`.
# interrogate: `brew list --formula --full-name` + `brew list --cask` →
#              formula names returned verbatim; cask names prefixed with "cask:".

pm_name = "brew"

def _brew_install_self(ctx):
    # Official non-interactive Homebrew installer — only path available on
    # a fresh macOS system with no package manager present.
    ctx.run("curl", ["-fsSL", "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh", "-o", "/tmp/brew-install.sh"])
    ctx.run("bash", ["/tmp/brew-install.sh"])
    ctx.delete_file("/tmp/brew-install.sh")

def install(ctx):
    p = platform()
    if p.os != "macos":
        return
    _brew_install_self(ctx)

def verify(ctx):
    p = platform()
    if p.os != "macos":
        return
    ctx.run("brew", ["--version"])

def add_repo(ctx, **kwargs):
    # brew uses `brew tap` for third-party repos; no generic add_repo needed.
    # Taps are handled via the tap= kwarg in install_pkg instead.
    pass

def install_pkg(ctx, name, version, **kwargs):
    tap = kwargs.get("tap", "")
    cask = kwargs.get("cask", False)

    if tap:
        ctx.run("brew", ["tap", tap])

    if cask:
        if version:
            # Homebrew casks do not support pinned versions via `brew install`.
            # Install the current cask and log the version expectation.
            ctx.log("brew cask: version pinning not supported; installing latest %s" % name)
        ctx.run("brew", ["install", "--cask", name])
    else:
        if version:
            ctx.run("brew", ["install", "%s@%s" % (name, version)])
        else:
            ctx.run("brew", ["install", name])

def uninstall_pkg(ctx, name, version, **kwargs):
    cask = kwargs.get("cask", False)
    if cask:
        ctx.run("brew", ["uninstall", "--cask", name])
    else:
        ctx.run("brew", ["uninstall", name])

def interrogate(ctx):
    formula_result = ctx.run("brew", ["list", "--formula", "--full-name"])
    cask_result = ctx.run("brew", ["list", "--cask"])
    names = []
    for line in formula_result.stdout.splitlines():
        line = line.strip()
        if line:
            names.append(line)
    for line in cask_result.stdout.splitlines():
        line = line.strip()
        if line:
            names.append("cask:" + line)
    return names
