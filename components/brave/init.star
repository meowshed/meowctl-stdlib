# components/brave.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/flatpak"]
#
# Brave browser.
# macOS: Homebrew cask. Linux: official Brave apt/dnf/pacman repo or Flatpak.

after = ["@stdlib//components/brew", "@stdlib//components/flatpak"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "brave-browser", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            ctx.run("bash", ["-c", "curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg"])
            ctx.run("bash", ["-c", "echo 'deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main' > /etc/apt/sources.list.d/brave-browser-release.list"])
            ctx.run("apt-get", ["update"])
            pkg(manager = "apt", name = "brave-browser")
        elif p.distro_like == "fedora":
            ctx.run("bash", ["-c", "dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo"])
            pkg(manager = "dnf", name = "brave-browser")
        elif p.distro_like == "arch":
            pkg(manager = "pacman", name = "brave-bin")
        else:
            pkg(manager = "flatpak", name = "com.brave.Browser")

def verify(ctx):
    p = platform()
    if p.os == "macos":
        ctx.run("open", ["-a", "Brave Browser"])
    else:
        ctx.run("brave-browser", ["--version"])

def upgrade(ctx):
    p = platform()
    if p.os == "macos":
        uppkg(manager = "brew", name = "brave-browser", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            uppkg(manager = "apt", name = "brave-browser")
        elif p.distro_like == "fedora":
            uppkg(manager = "dnf", name = "brave-browser")
        elif p.distro_like == "arch":
            uppkg(manager = "pacman", name = "brave-bin")
        else:
            uppkg(manager = "flatpak", name = "com.brave.Browser")

def uninstall(ctx):
    p = platform()
    if p.os == "macos":
        unpkg(manager = "brew", name = "brave-browser", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            unpkg(manager = "apt", name = "brave-browser")
        elif p.distro_like == "fedora":
            unpkg(manager = "dnf", name = "brave-browser")
        elif p.distro_like == "arch":
            unpkg(manager = "pacman", name = "brave-bin")
        else:
            unpkg(manager = "flatpak", name = "com.brave.Browser")
