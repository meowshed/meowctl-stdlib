# components/go.star
#
# pm_name:  go_install
# platform: all
# after:    ["mise"]
#
# PM kwargs: none
#
# Install: `go install <import-path>@<version>` — @version is mandatory;
#          use "latest" when no version is specified.
# Uninstall: remove the binary from $(go env GOPATH)/bin; the basename is
#            the last path component of the import path.
# interrogate: list files in $(go env GOPATH)/bin — each file is a binary
#              name. We return full import paths only when they are known;
#              here we return basenames matching the installed binaries.
#              Note: go install does not record the source import path after
#              install, so interrogate returns binary basenames only.
# Pinning: @latest is non-reproducible; use explicit version tags for
#          reproducible installs.

after = ["mise"]
pm_name = "go_install"

def install(ctx):
    pkg(manager="mise", name="go", version="latest")

def verify(ctx):
    ctx.run("go", ["version"])

def install_pkg(ctx, name, version, **kwargs):
    # name: full import path, e.g. "golang.org/x/tools/cmd/goimports"
    if version:
        spec = "%s@%s" % (name, version)
    else:
        spec = "%s@latest" % name
    ctx.run("go", ["install", spec])

def uninstall_pkg(ctx, name, version, **kwargs):
    # Derive binary name from the last component of the import path.
    binary = name.split("/")[-1]
    gopath_result = ctx.run("go", ["env", "GOPATH"])
    gopath = gopath_result.stdout.strip()
    ctx.delete_file("%s/bin/%s" % (gopath, binary))

def interrogate(ctx):
    gopath_result = ctx.run("go", ["env", "GOPATH"])
    gopath = gopath_result.stdout.strip()
    result = ctx.list_dir("%s/bin" % gopath)
    return [entry for entry in result]
