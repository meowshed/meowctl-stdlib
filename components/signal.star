# components/signal.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/flatpak"]
#
# Signal encrypted messenger.
# macOS: Homebrew cask. Linux: official apt repo or Flatpak.

after = ["@stdlib//components/brew", "@stdlib//components/flatpak"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "signal", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            ctx.run("bash", ["-c", "wget -qO- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > /usr/share/keyrings/signal-desktop-keyring.gpg"])
            ctx.run("bash", ["-c", "echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' > /etc/apt/sources.list.d/signal-xenial.list"])
            ctx.run("apt-get", ["update"])
            pkg(manager = "apt", name = "signal-desktop")
        elif p.distro_like == "fedora":
            pkg(manager = "flatpak", name = "org.signal.Signal")
        elif p.distro_like == "arch":
            pkg(manager = "pacman", name = "signal-desktop")
        else:
            pkg(manager = "flatpak", name = "org.signal.Signal")

def verify(ctx):
    p = platform()
    if p.os == "macos":
        ctx.run("open", ["-a", "Signal"])
    else:
        ctx.run("signal-desktop", ["--version"])

def upgrade(ctx):
    p = platform()
    if p.os == "macos":
        uppkg(manager = "brew", name = "signal", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            uppkg(manager = "apt", name = "signal-desktop")
        elif p.distro_like == "fedora":
            uppkg(manager = "flatpak", name = "org.signal.Signal")
        elif p.distro_like == "arch":
            uppkg(manager = "pacman", name = "signal-desktop")
        else:
            uppkg(manager = "flatpak", name = "org.signal.Signal")

def uninstall(ctx):
    p = platform()
    if p.os == "macos":
        unpkg(manager = "brew", name = "signal", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            unpkg(manager = "apt", name = "signal-desktop")
        elif p.distro_like == "fedora":
            unpkg(manager = "flatpak", name = "org.signal.Signal")
        elif p.distro_like == "arch":
            unpkg(manager = "pacman", name = "signal-desktop")
        else:
            unpkg(manager = "flatpak", name = "org.signal.Signal")
