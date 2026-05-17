# components/discord.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/flatpak"]
#
# Discord voice and text chat.
# macOS: Homebrew cask. Linux: official .deb or Flatpak.

after = ["@stdlib//components/brew", "@stdlib//components/flatpak"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "discord", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            ctx.run("bash", ["-c", "wget -qO /tmp/discord.deb 'https://discord.com/api/download?platform=linux&format=deb' && apt-get install -y /tmp/discord.deb"])
        elif p.distro_like == "fedora":
            ctx.run("bash", ["-c", "wget -qO /tmp/discord.rpm 'https://discord.com/api/download?platform=linux&format=rpm' && dnf install -y /tmp/discord.rpm"])
        elif p.distro_like == "arch":
            pkg(manager = "pacman", name = "discord")
        else:
            pkg(manager = "flatpak", name = "com.discordapp.Discord")

def verify(ctx):
    p = platform()
    if p.os == "macos":
        ctx.run("open", ["-a", "Discord"])
    else:
        ctx.run("discord", ["--version"])

def upgrade(ctx):
    p = platform()
    if p.os == "macos":
        uppkg(manager = "brew", name = "discord", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            ctx.run("bash", ["-c", "wget -qO /tmp/discord.deb 'https://discord.com/api/download?platform=linux&format=deb' && apt-get install -y /tmp/discord.deb"])
        elif p.distro_like == "fedora":
            ctx.run("bash", ["-c", "wget -qO /tmp/discord.rpm 'https://discord.com/api/download?platform=linux&format=rpm' && dnf install -y /tmp/discord.rpm"])
        elif p.distro_like == "arch":
            uppkg(manager = "pacman", name = "discord")
        else:
            uppkg(manager = "flatpak", name = "com.discordapp.Discord")

def uninstall(ctx):
    p = platform()
    if p.os == "macos":
        unpkg(manager = "brew", name = "discord", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            unpkg(manager = "apt", name = "discord")
        elif p.distro_like == "fedora":
            unpkg(manager = "dnf", name = "discord")
        elif p.distro_like == "arch":
            unpkg(manager = "pacman", name = "discord")
        else:
            unpkg(manager = "flatpak", name = "com.discordapp.Discord")
