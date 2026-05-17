# components/zoom.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/flatpak"]
#
# Zoom video conferencing.
# macOS: Homebrew cask. Linux: official .deb/.rpm or Flatpak.

after = ["@stdlib//components/brew", "@stdlib//components/flatpak"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "zoom", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            ctx.run("bash", ["-c", "wget -qO /tmp/zoom.deb https://zoom.us/client/latest/zoom_amd64.deb && apt-get install -y /tmp/zoom.deb"])
        elif p.distro_like == "fedora":
            ctx.run("bash", ["-c", "wget -qO /tmp/zoom.rpm https://zoom.us/client/latest/zoom_x86_64.rpm && dnf install -y /tmp/zoom.rpm"])
        elif p.distro_like == "arch":
            pkg(manager = "pacman", name = "zoom")
        else:
            pkg(manager = "flatpak", name = "us.zoom.Zoom")

def verify(ctx):
    p = platform()
    if p.os == "macos":
        ctx.run("open", ["-a", "zoom.us"])
    else:
        ctx.run("zoom", ["--version"])

def upgrade(ctx):
    p = platform()
    if p.os == "macos":
        uppkg(manager = "brew", name = "zoom", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            ctx.run("bash", ["-c", "wget -qO /tmp/zoom.deb https://zoom.us/client/latest/zoom_amd64.deb && apt-get install -y /tmp/zoom.deb"])
        elif p.distro_like == "fedora":
            ctx.run("bash", ["-c", "wget -qO /tmp/zoom.rpm https://zoom.us/client/latest/zoom_x86_64.rpm && dnf install -y /tmp/zoom.rpm"])
        elif p.distro_like == "arch":
            uppkg(manager = "pacman", name = "zoom")
        else:
            uppkg(manager = "flatpak", name = "us.zoom.Zoom")

def uninstall(ctx):
    p = platform()
    if p.os == "macos":
        unpkg(manager = "brew", name = "zoom", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            unpkg(manager = "apt", name = "zoom")
        elif p.distro_like == "fedora":
            unpkg(manager = "dnf", name = "zoom")
        elif p.distro_like == "arch":
            unpkg(manager = "pacman", name = "zoom")
        else:
            unpkg(manager = "flatpak", name = "us.zoom.Zoom")