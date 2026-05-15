# components/apt.star
#
# pm_name:  apt
# platform: ["linux"]
# distro:   ubuntu, debian, and debian-like
# after:    —
#
# PM kwargs: none
#
# Bootstrap PM. apt is a system-level package manager; no higher-level PM
# can install it. install() is a no-op — apt is always present on supported
# distros.
#
# Package names are standard apt package names (e.g. "curl", "git").
# install_pkg: runs `sudo apt-get install -y <name>`.
# uninstall_pkg: runs `sudo apt-get remove -y <name>`.
# interrogate: `dpkg-query -f '${Package}\n' -W` → list of installed package names.

platforms = ["linux"]
pm_name = "apt"

def install(ctx):
    # apt is a system PM — always present on supported distros; nothing to install.
    pass

def verify(ctx):
    ctx.run("apt-get", ["--version"])

def install_pkg(ctx, name, version, **kwargs):
    if version:
        ctx.run("sudo", ["apt-get", "install", "-y", "%s=%s" % (name, version)])
    else:
        ctx.run("sudo", ["apt-get", "install", "-y", name])

def uninstall_pkg(ctx, name, version, **kwargs):
    ctx.run("sudo", ["apt-get", "remove", "-y", name])

def interrogate(ctx):
    result = ctx.run("dpkg-query", ["-f", "${Package}\n", "-W"])
    pkgs = []
    for line in result.stdout.splitlines():
        line = line.strip()
        if line:
            pkgs.append(line)
    return pkgs
