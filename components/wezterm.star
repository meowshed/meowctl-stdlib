# components/wezterm.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/flatpak"]
#
# WezTerm GPU-accelerated terminal emulator.
# macOS: Homebrew cask. Linux: official apt/dnf repo or Flatpak.

after = ["@stdlib//components/brew", "@stdlib//components/flatpak"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "wezterm", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            ctx.run("bash", ["-c", "curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg"])
            ctx.run("bash", ["-c", "echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list"])
            ctx.run("apt-get", ["update"])
            pkg(manager = "apt", name = "wezterm")
        elif p.distro_like == "fedora":
            ctx.run("bash", ["-c", "dnf copr enable -y wez/wezterm"])
            pkg(manager = "dnf", name = "wezterm")
        elif p.distro_like == "arch":
            pkg(manager = "pacman", name = "wezterm")
        else:
            pkg(manager = "flatpak", name = "org.wezfurlong.wezterm")

def verify(ctx):
    p = platform()
    if p.os == "macos":
        ctx.run("open", ["-a", "WezTerm"])
    else:
        ctx.run("wezterm", ["--version"])
