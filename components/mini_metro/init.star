# components/mini_metro.star
#
# platforms: ["macos"]
# after:     ["@stdlib//components/mas"]
#
# Mini Metro+ — Mac App Store.
# Installed via mas (Mac App Store CLI).
#
# Apple Arcade title: mas cannot install or even look it up — the App Store CLI
# only handles purchasable apps, and `mas info <id>` answers "No apps found in
# the App Store for ADAM ID". Installing it means opening the App Store by hand
# with an active Arcade subscription; this component is declarative only.

platforms = ["macos"]
after = ["@stdlib//components/mas"]

def install(ctx):
    # No pkg() call: mas cannot install this, so asking it to would fail on
    # every apply. Report whether it is there and leave it at that.
    r = ctx.run("sh", ["-c", "mas list | grep -q '^ *1550663539 ' && echo yes || echo no"])
    if r.stdout.strip() == "yes":
        ctx.log("Mini Metro+: installed")
    else:
        ctx.log("Mini Metro+: NOT installed — open the App Store and get it through Arcade")

def verify(ctx):
    ctx.run("sh", ["-c", "mas list | grep -q '^ *1550663539 ' || echo 'Mini Metro+: not installed'"])

def upgrade(ctx):
    install(ctx)

def uninstall(ctx):
    ctx.log("Mini Metro+: remove it from Applications by hand; mas cannot uninstall")
