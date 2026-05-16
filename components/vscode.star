# components/vscode.star
#
# pm_name:  vscode
# platform: all
# after:    ["brew", "apt", "dnf", "pacman", "apk"]
#
# PM kwargs: none
#
# Installs VS Code via native package managers:
#   - macOS:   brew install --cask visual-studio-code
#   - Ubuntu/Debian: Microsoft apt repo (signed, official)
#   - Fedora/RHEL:   Microsoft rpm repo (signed, official)
#   - Arch:    AUR not supported in CI; use snap or manual install
#   - Alpine:  not supported (glibc dependency)
#
# install_pkg / uninstall_pkg manage VS Code extensions via the `code` CLI.
# Extension name format: publisher.extensionName (e.g. "ms-python.python").
# Version is ignored — VS Code extensions self-update via the marketplace.
#
# interrogate: `code --list-extensions` → one extension ID per line.

pm_name = "vscode"
after = ["@stdlib//components/brew", "@stdlib//components/apt", "@stdlib//components/dnf", "@stdlib//components/pacman"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager="brew", name="visual-studio-code", cask=True)
    elif p.os == "linux":
        if p.distro == "ubuntu" or p.distro == "debian" or p.distro_like == "debian":
            # Add Microsoft apt repo and install
            ctx.run("bash", ["-c", "wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/microsoft.gpg"])
            ctx.run("bash", ["-c", "install -o root -g root -m 644 /tmp/microsoft.gpg /etc/apt/trusted.gpg.d/"])
            ctx.run("bash", ["-c", "echo 'deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main' > /etc/apt/sources.list.d/vscode.list"])
            ctx.run("apt-get", ["update"])
            pkg(manager="apt", name="code")
        elif p.distro == "fedora" or p.distro == "rhel" or p.distro_like == "fedora" or p.distro_like == "rhel":
            ctx.run("rpm", ["--import", "https://packages.microsoft.com/keys/microsoft.asc"])
            ctx.run("bash", ["-c", "echo -e '[code]\\nname=Visual Studio Code\\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\\nenabled=1\\ngpgcheck=1\\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc' > /etc/yum.repos.d/vscode.repo"])
            pkg(manager="dnf", name="code")
        elif p.distro == "arch":
            ctx.log("vscode: Arch AUR not supported in automated installs; install via `yay -S visual-studio-code-bin` manually")
        elif p.distro == "alpine":
            ctx.log("vscode: VS Code is not supported on Alpine (glibc dependency)")
        else:
            ctx.log("vscode: unsupported distro %r — install VS Code manually" % p.distro)
    else:
        ctx.log("vscode: unsupported OS %r" % p.os)

def verify(ctx):
    ctx.run("code", ["--version"])

def install_pkg(ctx, name, version, **kwargs):
    # version is ignored — VS Code extension marketplace does not support
    # pinning via the CLI installer.
    ctx.run("code", ["--install-extension", name, "--force"])

def uninstall_pkg(ctx, name, version, **kwargs):
    ctx.run("code", ["--uninstall-extension", name])

def interrogate(ctx):
    result = ctx.run("code", ["--list-extensions"])
    names = []
    for line in result.stdout.splitlines():
        line = line.strip()
        if line:
            names.append(line)
    return names
