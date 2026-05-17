# components/chrome.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/flatpak"]
#
# Google Chrome browser.
# macOS: Homebrew cask. Linux: official Google apt/dnf repo or Flatpak.

after = ["@stdlib//components/brew", "@stdlib//components/flatpak"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "google-chrome", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            ctx.run("bash", ["-c", "wget -qO- https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /usr/share/keyrings/google-chrome.gpg"])
            ctx.run("bash", ["-c", "echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google-chrome.list"])
            ctx.run("apt-get", ["update"])
            pkg(manager = "apt", name = "google-chrome-stable")
        elif p.distro_like == "fedora":
            ctx.run("bash", ["-c", "dnf install -y https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm"])
        elif p.distro_like == "arch":
            pkg(manager = "pacman", name = "chromium")
        else:
            pkg(manager = "flatpak", name = "com.google.Chrome")

def verify(ctx):
    p = platform()
    if p.os == "macos":
        ctx.run("open", ["-a", "Google Chrome"])
    else:
        ctx.run("google-chrome", ["--version"])

def upgrade(ctx):
    p = platform()
    if p.os == "macos":
        uppkg(manager = "brew", name = "google-chrome", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            uppkg(manager = "apt", name = "google-chrome-stable")
        elif p.distro_like == "fedora":
            uppkg(manager = "dnf", name = "google-chrome-stable")
        elif p.distro_like == "arch":
            uppkg(manager = "pacman", name = "chromium")
        else:
            uppkg(manager = "flatpak", name = "com.google.Chrome")

def uninstall(ctx):
    p = platform()
    if p.os == "macos":
        unpkg(manager = "brew", name = "google-chrome", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            unpkg(manager = "apt", name = "google-chrome-stable")
        elif p.distro_like == "fedora":
            unpkg(manager = "dnf", name = "google-chrome-stable")
        elif p.distro_like == "arch":
            unpkg(manager = "pacman", name = "chromium")
        else:
            unpkg(manager = "flatpak", name = "com.google.Chrome")
