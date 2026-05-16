# components/adaptive_keyboard_layouts.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/hammerspoon"]
#
# Adaptive Keyboard Layouts Hammerspoon spoon.
# Installed by cloning the repo into ~/.hammerspoon/Spoons/.

platforms = ["macos"]
after = ["@stdlib//components/hammerspoon"]

def install(ctx):
    home = ctx.env("HOME")
    if home:
        spoons_dir = home + "/.hammerspoon/Spoons"
        ctx.run("mkdir", ["-p", spoons_dir])
        ctx.run("git", ["clone", "https://github.com/meowshed/adaptive-keyboard-layouts.git",
                        spoons_dir + "/AdaptiveKeyboardLayouts.spoon"])

def verify(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.run("test", ["-d", home + "/.hammerspoon/Spoons/AdaptiveKeyboardLayouts.spoon"])
