# components/mas.star
#
# pm_name:  mas
# platform: ["macos"]
# after:    ["mise"]
#
# PM kwargs: none
#
# Package names are numeric App Store IDs (e.g. "1333542190").
# Guard: MEOW_ENABLE_MAS=true environment variable must be set; mas requires
#        the user to be signed in to the App Store.
# uninstall: mas cannot auto-uninstall by ID; logs a warning and returns.
# interrogate: `mas list` → space-padded `<id>  <name> (<version>)` per line;
#              returns the numeric ID strings (first space-delimited field).

platforms = ["macos"]
after = ["mise"]
pm_name = "mas"

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager="mise", name="mas")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("mas", ["version"])

def install_pkg(ctx, name, version, **kwargs):
    # name: numeric App Store ID string, e.g. "1333542190"
    if ctx.env("MEOW_ENABLE_MAS") != "true":
        ctx.log("mas: skipping install of %s — set MEOW_ENABLE_MAS=true to enable" % name)
        return
    _activate_shims(ctx)
    ctx.run("mas", ["install", name])

def uninstall_pkg(ctx, name, version, **kwargs):
    # mas cannot uninstall by name/ID — manual removal required.
    ctx.log("warning: mas cannot auto-uninstall; remove %s manually via App Store or `mas uninstall <id>`" % name)

def interrogate(ctx):
    _activate_shims(ctx)
    result = ctx.run("mas", ["list"])
    ids = []
    for line in result.stdout.splitlines():
        line = line.strip()
        if line:
            ids.append(line.split(" ")[0])
    return ids
