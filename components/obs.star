# components/obs.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/flatpak"]
#
# OBS Studio screen recorder and streamer.
# macOS: Homebrew cask. Linux: official OBS repo or Flatpak.

after = ["@stdlib//components/brew", "@stdlib//components/flatpak"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "obs", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            ctx.run("bash", ["-c", "wget -qO- https://obsproject.com/obs-blog-apt-public.gpg.key | gpg --dearmor > /usr/share/keyrings/obs-studio-archive-keyring.gpg"])
            ctx.run("bash", ["-c", "echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/obs-studio-archive-keyring.gpg] https://ppa.launchpadcontent.net/obsproject/obs-studio/ubuntu noble main' > /etc/apt/sources.list.d/obs-studio.list"])
            ctx.run("apt-get", ["update"])
            pkg(manager = "apt", name = "obs-studio")
        elif p.distro_like == "fedora":
            pkg(manager = "dnf", name = "obs-studio")
        elif p.distro_like == "arch":
            pkg(manager = "pacman", name = "obs-studio")
        else:
            pkg(manager = "flatpak", name = "com.obsproject.Studio")

def verify(ctx):
    p = platform()
    if p.os == "macos":
        ctx.run("open", ["-a", "OBS"])
    else:
        ctx.run("obs", ["--version"])

def upgrade(ctx):
    p = platform()
    if p.os == "macos":
        uppkg(manager = "brew", name = "obs", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            ctx.run("bash", ["-c", "wget -qO- https://obsproject.com/obs-blog-apt-public.gpg.key | gpg --dearmor > /usr/share/keyrings/obs-studio-archive-keyring.gpg"])
            ctx.run("bash", ["-c", "echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/obs-studio-archive-keyring.gpg] https://ppa.launchpadcontent.net/obsproject/obs-studio/ubuntu noble main' > /etc/apt/sources.list.d/obs-studio.list"])
            ctx.run("apt-get", ["update"])
            uppkg(manager = "apt", name = "obs-studio")
        elif p.distro_like == "fedora":
            uppkg(manager = "dnf", name = "obs-studio")
        elif p.distro_like == "arch":
            uppkg(manager = "pacman", name = "obs-studio")
        else:
            uppkg(manager = "flatpak", name = "com.obsproject.Studio")

def uninstall(ctx):
    p = platform()
    if p.os == "macos":
        unpkg(manager = "brew", name = "obs", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            unpkg(manager = "apt", name = "obs-studio")
        elif p.distro_like == "fedora":
            unpkg(manager = "dnf", name = "obs-studio")
        elif p.distro_like == "arch":
            unpkg(manager = "pacman", name = "obs-studio")
        else:
            unpkg(manager = "flatpak", name = "com.obsproject.Studio")
