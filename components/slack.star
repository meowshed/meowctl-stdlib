# components/slack.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/flatpak"]
#
# Slack messaging.
# macOS: Homebrew cask. Linux: official .deb/.rpm or Flatpak.

after = ["@stdlib//components/brew", "@stdlib//components/flatpak"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "slack", cask = True)
    elif p.os == "linux":
        if p.distro_like == "debian":
            ctx.run("bash", ["-c", "wget -qO /tmp/slack.deb 'https://downloads.slack-edge.com/releases/linux/4.36.140/prod/x64/slack-desktop-4.36.140-amd64.deb' && apt-get install -y /tmp/slack.deb"])
        elif p.distro_like == "fedora":
            ctx.run("bash", ["-c", "wget -qO /tmp/slack.rpm 'https://downloads.slack-edge.com/releases/linux/4.36.140/prod/x64/slack-4.36.140-0.1.el8.x86_64.rpm' && dnf install -y /tmp/slack.rpm"])
        elif p.distro_like == "arch":
            pkg(manager = "pacman", name = "slack-desktop")
        else:
            pkg(manager = "flatpak", name = "com.slack.Slack")

def verify(ctx):
    p = platform()
    if p.os == "macos":
        ctx.run("open", ["-a", "Slack"])
    else:
        ctx.run("slack", ["--version"])
