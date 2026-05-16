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
#
# On Alpine Linux, precompiled Ruby binaries (glibc) don't work with musl libc.
# We install ruby from apk instead. On all other platforms we use mise with
# precompiled binaries (MISE_RUBY_COMPILE=false) to avoid build-dep requirements.
#
# interrogate: `gem list --local --no-versions` → one gem name per line.

after = ["mise"]
pm_name = "gem"

def install(ctx):
    p = platform()
    if p.os == "linux" and p.distro == "alpine":
        # Alpine uses musl libc; mise precompiled ruby (glibc) won't run.
        # Compile-from-source requires many build deps not present in CI.
        # Use apk ruby instead.
        pkg(manager="apk", name="ruby")
        pkg(manager="apk", name="ruby-dev")
    else:
        # Use precompiled binaries to avoid ruby-build compile failures.
        # mise settings ruby.compile=false: try precompiled first, fall back to
        # source only if no precompiled binary is available for the platform.
        ctx.run("mise", ["settings", "ruby.compile", "false"])
        pkg(manager="mise", name="ruby", version="latest")

def verify(ctx):
    ctx.run("ruby", ["--version"])

def install_pkg(ctx, name, version, **kwargs):
    if version:
        ctx.run("gem", ["install", name, "-v", version])
    else:
        ctx.run("gem", ["install", name])

def uninstall_pkg(ctx, name, version, **kwargs):
    if version:
        ctx.run("gem", ["uninstall", name, "-v", version])
    else:
        ctx.run("gem", ["uninstall", name, "--all-versions"])

def interrogate(ctx):
    result = ctx.run("gem", ["list", "--local", "--no-versions"])
    names = []
    for line in result.stdout.splitlines():
        line = line.strip()
        if line and not line.startswith("***"):
            names.append(line)
    return names
