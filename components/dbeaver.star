# components/dbeaver.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/flatpak"]
#
# DBeaver community database tool.
# macOS: Homebrew cask. Linux: official .deb/.rpm or Flatpak.

after = ["@stdlib//components/brew", "@stdlib//components/flatpak"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "dbeaver-community", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            ctx.run("bash", ["-c", "wget -qO /tmp/dbeaver.deb https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb && apt-get install -y /tmp/dbeaver.deb"])
        elif p.distro_like == "fedora":
            ctx.run("bash", ["-c", "wget -qO /tmp/dbeaver.rpm https://dbeaver.io/files/dbeaver-ce-latest-stable.x86_64.rpm && dnf install -y /tmp/dbeaver.rpm"])
        elif p.distro_like == "arch":
            pkg(manager = "pacman", name = "dbeaver")
        else:
            pkg(manager = "flatpak", name = "io.dbeaver.DBeaverCommunity")

def verify(ctx):
    p = platform()
    if p.os == "macos":
        ctx.run("open", ["-a", "DBeaver"])
    else:
        ctx.run("dbeaver", ["-version"])

def upgrade(ctx):
    p = platform()
    if p.os == "macos":
        uppkg(manager = "brew", name = "dbeaver-community", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            ctx.run("bash", ["-c", "wget -qO /tmp/dbeaver.deb https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb && apt-get install -y /tmp/dbeaver.deb"])
        elif p.distro_like == "fedora":
            ctx.run("bash", ["-c", "wget -qO /tmp/dbeaver.rpm https://dbeaver.io/files/dbeaver-ce-latest-stable.x86_64.rpm && dnf install -y /tmp/dbeaver.rpm"])
        elif p.distro_like == "arch":
            uppkg(manager = "pacman", name = "dbeaver")
        else:
            uppkg(manager = "flatpak", name = "io.dbeaver.DBeaverCommunity")

def uninstall(ctx):
    p = platform()
    if p.os == "macos":
        unpkg(manager = "brew", name = "dbeaver-community", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            unpkg(manager = "apt", name = "dbeaver-ce")
        elif p.distro_like == "fedora":
            unpkg(manager = "dnf", name = "dbeaver-ce")
        elif p.distro_like == "arch":
            unpkg(manager = "pacman", name = "dbeaver")
        else:
            unpkg(manager = "flatpak", name = "io.dbeaver.DBeaverCommunity")
