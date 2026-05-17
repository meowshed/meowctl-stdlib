# components/dungeon_crawl_stone_soup.star
#
# platform: all
# after:     ["@stdlib//components/brew", "@stdlib//components/flatpak"]
#
# Dungeon Crawl Stone Soup (tiles) — roguelike dungeon exploration game.
# macOS: Homebrew formula (tiles build). Linux: native packages or Flatpak.

after = ["@stdlib//components/brew", "@stdlib//components/flatpak"]

def install(ctx):
    p = platform()
    if p.os == "macos":
        pkg(manager = "brew", name = "dungeon-crawl-stone-soup-tiles")
    elif p.os == "linux":
        if p.distro_like == "debian":
            pkg(manager = "apt", name = "crawl-tiles")
        elif p.distro_like == "arch":
            pkg(manager = "pacman", name = "stone-soup")
        else:
            pkg(manager = "flatpak", name = "org.develz.Crawl")

def verify(ctx):
    p = platform()
    if p.os == "macos":
        ctx.run("open", ["-a", "Dungeon Crawl Stone Soup - Tiles"])
    else:
        ctx.run("crawl-tiles", ["--version"])

def upgrade(ctx):
    p = platform()
    if p.os == "macos":
        uppkg(manager = "brew", name = "dungeon-crawl-stone-soup-tiles")
    elif p.os == "linux":
        if p.distro_like == "debian":
            uppkg(manager = "apt", name = "crawl-tiles")
        elif p.distro_like == "arch":
            uppkg(manager = "pacman", name = "stone-soup")
        else:
            uppkg(manager = "flatpak", name = "org.develz.Crawl")

def uninstall(ctx):
    p = platform()
    if p.os == "macos":
        unpkg(manager = "brew", name = "dungeon-crawl-stone-soup-tiles")
    elif p.os == "linux":
        if p.distro_like == "debian":
            unpkg(manager = "apt", name = "crawl-tiles")
        elif p.distro_like == "arch":
            unpkg(manager = "pacman", name = "stone-soup")
        else:
            unpkg(manager = "flatpak", name = "org.develz.Crawl")
