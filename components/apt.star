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
#
# add_repo kwargs:
#   key_url=  URL of the ASCII-armored gpg key to add to /etc/apt/keyrings/.
#             The key file is named by extracting the last path segment of the URL
#             (e.g. "https://example.com/gpg-key.pub" → "gpg-key.asc").
#   repo_line= Full deb line to add to /etc/apt/sources.list.d/<slug>.list.
#              The filename is derived from the first word after "deb " in repo_line.
#              Example: "deb [signed-by=...] https://mise.jdx.dev/deb stable main"

platforms = ["linux"]
pm_name = "apt"

def install(ctx):
    # apt is a system PM — always present on supported distros; nothing to install.
    pass

def verify(ctx):
    ctx.run("apt-get", ["--version"])

def add_repo(ctx, **kwargs):
    key_url = kwargs.get("key_url", "")
    repo_line = kwargs.get("repo_line", "")

    if key_url:
        # Derive keyring filename from the last URL segment, force .asc extension.
        parts = key_url.split("/")
        key_file = parts[-1] if parts[-1] else "repo-key.asc"
        # Strip any existing extension and append .asc
        dot = key_file.rfind(".")
        if dot != -1:
            key_file = key_file[:dot]
        key_file = key_file + ".asc"
        keyring_path = "/etc/apt/keyrings/" + key_file

        ctx.run("sudo", ["apt-get", "install", "-y", "curl", "ca-certificates"])
        ctx.run("sudo", ["install", "-dm", "755", "/etc/apt/keyrings"])
        ctx.run("sh", ["-c", "curl -fsSL %s | sudo tee %s > /dev/null" % (key_url, keyring_path)])

    if repo_line:
        # Derive list filename from domain portion of the URL in repo_line.
        # repo_line is like: deb [signed-by=...] https://mise.jdx.dev/deb stable main
        # Extract host from the https:// URL token.
        list_name = "repo"
        for token in repo_line.split():
            if token.startswith("https://") or token.startswith("http://"):
                # Strip scheme and use host as filename base
                host = token.split("//", 1)[1].split("/")[0]
                # Replace dots with dashes for a safe filename
                list_name = host.replace(".", "-")
                break
        list_path = "/etc/apt/sources.list.d/" + list_name + ".list"
        ctx.run("sh", ["-c", "echo '%s' | sudo tee %s" % (repo_line, list_path)])
        ctx.run("sudo", ["apt-get", "update", "-y"])

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
