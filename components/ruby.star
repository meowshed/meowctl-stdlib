# components/ruby.star
#
# pm_name:  gem
# platform: all
# after:    ["mise"]
#
# PM kwargs: none
#
# Requires the ruby mise tool to be installed first (system ruby on macOS is
# sandboxed; system gem cannot install into writable locations).
# interrogate: `gem list --local --no-versions` → one gem name per line.

after = ["mise"]
pm_name = "gem"

def install(ctx):
    pkg(manager="mise", name="ruby", version="latest")

def verify(ctx):
    ctx.run("ruby", ["--version"])

def install_pkg(ctx, name, version, **kwargs):
    if version:
        ctx.run("gem", ["install", name, "-v", version])
    else:
        ctx.run("gem", ["install", name])

def uninstall_pkg(ctx, name, version, **kwargs):
    ctx.run("gem", ["uninstall", name, "--all-versions"])

def interrogate(ctx):
    result = ctx.run("gem", ["list", "--local", "--no-versions"])
    names = []
    for line in result.stdout.splitlines():
        line = line.strip()
        if line and not line.startswith("***"):
            names.append(line)
    return names
