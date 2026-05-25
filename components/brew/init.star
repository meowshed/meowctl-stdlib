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
    # Guard with ctx.which so we don't run the slow curl installer on every
    # meowctl install invocation when brew is already present.
    if ctx.which("brew"):
        return
    ctx.run("curl", ["-fsSL", "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh", "-o", "/tmp/brew-install.sh"])
    ctx.run("bash", ["/tmp/brew-install.sh"])
    ctx.delete_file("/tmp/brew-install.sh")

def install(ctx):
    p = platform()
    if p.os != "macos":
        return
    _brew_install_self(ctx)

def update(ctx):
    p = platform()
    if p.os != "macos":
        return
    ctx.run("brew", ["update"])

def upgrade(ctx):
    # brew self-upgrades as part of upgrade_update (brew update); nothing to do here.
    pass

def uninstall(ctx):
    p = platform()
    if p.os != "macos":
        return
    ctx.run("curl", ["-fsSL", "https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh", "-o", "/tmp/brew-uninstall.sh"])
    ctx.run("bash", ["/tmp/brew-uninstall.sh", "--force"])
    ctx.delete_file("/tmp/brew-uninstall.sh")

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
    elif version and version != "latest":
        ctx.run("brew", ["install", "%s@%s" % (name, version)])
    else:
        ctx.run("brew", ["install", name])

def uninstall_pkg(ctx, name, version, **kwargs):
    # tap= is intentionally ignored on uninstall — brew resolves the formula
    # by name without needing the tap to be re-added, and removing the tap
    # here would be a side-effect the caller didn't request.
    cask = kwargs.get("cask", False)
    if cask:
        ctx.run("brew", ["uninstall", "--cask", name])
    else:
        ctx.run("brew", ["uninstall", name])

def shell(ctx):
    p = platform()
    if p.os != "macos":
        return

    # Prepend /opt/homebrew/bin so that brew-installed tools (e.g. bash 5,
    # gnu coreutils) shadow the macOS BSD versions picked up from /usr/bin.
    # fish_add_path -m prepends and deduplicates.
    if ctx.shell == "fish":
        ctx.emit("fish_add_path -m /opt/homebrew/bin /opt/homebrew/sbin")
    elif ctx.shell in ("bash", "zsh"):
        ctx.emit('export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"')

def interrogate(ctx):
    formula_result = ctx.run("brew", ["list", "--formula", "--full-name"])
    cask_result = ctx.run("brew", ["list", "--cask"])
    names = []
    for line in formula_result.stdout.splitlines():
        line = line.strip()
        if not line:
            continue

        # `brew list --full-name` prefixes only formulae from third-party taps
        # (e.g. "owner/tap/formula"). Core formulae are emitted bare (e.g. "git").
        # Strip any tap prefix so the name matches what a pkg() declaration uses.
        parts = line.split("/")
        names.append(parts[-1])
    for line in cask_result.stdout.splitlines():
        line = line.strip()
        if line:
            names.append("cask:" + line)
    return names
