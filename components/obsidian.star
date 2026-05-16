# components/obsidian.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/flatpak"]
#
# Obsidian knowledge base.
# macOS: Homebrew cask. Linux: official .deb or Flatpak.

after = ["@stdlib//components/brew", "@stdlib//components/flatpak"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "obsidian", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            ctx.run("bash", ["-c", "wget -qO /tmp/obsidian.deb $(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | grep 'browser_download_url.*amd64.deb' | cut -d '\"' -f 4) && apt-get install -y /tmp/obsidian.deb"])
        elif p.distro_like == "fedora":
            ctx.run("bash", ["-c", "wget -qO /tmp/obsidian.rpm $(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | grep 'browser_download_url.*x86_64.rpm' | cut -d '\"' -f 4) && dnf install -y /tmp/obsidian.rpm"])
        elif p.distro_like == "arch":
            pkg(manager = "pacman", name = "obsidian")
        else:
            pkg(manager = "flatpak", name = "md.obsidian.Obsidian")

def verify(ctx):
    p = platform()
    if p.os == "macos":
        ctx.run("open", ["-a", "Obsidian"])
    else:
        ctx.run("obsidian", ["--version"])
