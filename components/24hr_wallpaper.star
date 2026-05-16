# components/24hr_wallpaper.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/mas"]
#
# 24 Hour Wallpaper — Mac App Store.
# Installed via mas (Mac App Store CLI).

platforms = ["macos"]
after = ["@stdlib//components/mas"]

def install(ctx):
    pkg(manager = "mas", name = "24 Hour Wallpaper", version = "1226087575")

def verify(ctx):
    ctx.run("mas", ["list"])
