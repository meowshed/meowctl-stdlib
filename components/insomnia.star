# components/insomnia.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/flatpak"]
#
# Insomnia API client.
# macOS: Homebrew cask. Linux: official .deb or Flatpak.

after = ["@stdlib//components/brew", "@stdlib//components/flatpak"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "insomnia", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            ctx.run("bash", ["-c", "wget -qO /tmp/insomnia.deb $(curl -s https://api.github.com/repos/Kong/insomnia/releases/latest | grep 'browser_download_url.*amd64.deb' | cut -d '\"' -f 4) && apt-get install -y /tmp/insomnia.deb"])
        elif p.distro_like == "arch":
            pkg(manager = "pacman", name = "insomnia-bin")
        else:
            pkg(manager = "flatpak", name = "rest.insomnia.Insomnia")

def verify(ctx):
    p = platform()
    if p.os == "macos":
        ctx.run("open", ["-a", "Insomnia"])
    else:
        ctx.run("insomnia", ["--version"])
