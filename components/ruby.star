# components/ruby.star
#
# pm_name:  gem
# platform: all
# after:    ["mise"]
#
# PM kwargs: none
#
# Ruby gems are installed via `mise use --global gem:<name>`.
# mise's gem backend calls `gem install` and shims the binaries via
# ~/.local/share/mise/shims automatically.
#
# On Alpine Linux, precompiled Ruby binaries (glibc) don't work with musl libc.
# We install ruby from apk instead. On all other platforms we use mise with
# precompiled binaries (MISE_RUBY_COMPILE=false).
#
# interrogate: `mise ls --installed --json` → filter keys with "gem:" prefix.

after = ["@stdlib//components/mise"]
pm_name = "gem"

def install(ctx):
    p = platform()
    if p.os == "linux" and p.distro == "alpine":
        # Alpine uses musl libc; mise precompiled ruby (glibc) won't run.
        pkg(manager="apk", name="ruby")
        pkg(manager="apk", name="ruby-dev")
    else:
        # Use precompiled binaries to avoid ruby-build compile failures.
        ctx.run("mise", ["settings", "ruby.compile", "false"])
        pkg(manager="mise", name="ruby", version="latest")

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("ruby", ["--version"])

def _use_mise_gem(ctx):
    # On Alpine, ruby is installed from apk (musl); mise gem backend won't work
    # because there is no mise-managed ruby install dir to anchor the tool to.
    p = platform()
    return not (p.os == "linux" and (p.distro == "alpine" or p.distro_like == "alpine"))

def install_pkg(ctx, name, version, **kwargs):
    _activate_shims(ctx)
    if _use_mise_gem(ctx):
        if version:
            ctx.run("mise", ["use", "--global", "gem:%s@%s" % (name, version)])
        else:
            ctx.run("mise", ["use", "--global", "gem:%s" % name])
    else:
        # Alpine fallback: call gem directly (system ruby from apk).
        # Do not pass a version if it's empty or "latest" — gem rejects "latest" as a version spec.
        if version and version != "latest":
            ctx.run("gem", ["install", name, "-v", version])
        else:
            ctx.run("gem", ["install", name])

def uninstall_pkg(ctx, name, version, **kwargs):
    _activate_shims(ctx)
    if _use_mise_gem(ctx):
        ctx.run("mise", ["use", "--global", "--remove", "gem:%s" % name])
        if version:
            ctx.run("mise", ["uninstall", "gem:%s@%s" % (name, version)])
        else:
            ctx.run("mise", ["uninstall", "gem:%s" % name])
    else:
        if version:
            ctx.run("gem", ["uninstall", name, "-v", version])
        else:
            ctx.run("gem", ["uninstall", name, "--all-versions"])

def interrogate(ctx):
    _activate_shims(ctx)
    if _use_mise_gem(ctx):
        result = ctx.run("mise", ["ls", "--installed", "--json"])
        installed = json.decode(result.stdout)
        names = []
        for key in installed.keys():
            if key.startswith("gem:"):
                names.append(key[4:])
        return names
    else:
        # Alpine fallback: query gem directly.
        result = ctx.run("gem", ["list", "--local", "--no-versions"])
        names = []
        for line in result.stdout.splitlines():
            line = line.strip()
            if line and not line.startswith("***"):
                names.append(line)
        return names
