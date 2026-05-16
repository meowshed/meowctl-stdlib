# components/postman.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/flatpak"]
#
# Postman API client.
# macOS: Homebrew cask. Linux: Flatpak.

after = ["@stdlib//components/brew", "@stdlib//components/flatpak"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "postman", cask = True)
    elif p.os == "linux":
        pkg(manager = "flatpak", name = "com.getpostman.Postman")

def verify(ctx):
    p = platform()
    if p.os == "macos":
        ctx.run("open", ["-a", "Postman"])
    else:
        ctx.run("flatpak", ["run", "com.getpostman.Postman", "--version"])
