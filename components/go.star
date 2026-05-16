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
# interrogate: go install does not record the source import path after
#              installation; GOPATH/bin contains only binaries with no mapping
#              back to import paths. interrogate therefore returns an empty list.
#              Reconciliation must rely on the meowctl lock file, not runtime
#              inspection.
# Pinning: @latest is non-reproducible; use explicit version tags for
#          reproducible installs.

after = ["mise"]
pm_name = "go_install"

def install(ctx):
    pkg(manager="mise", name="go", version="latest")

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("go", ["version"])

def install_pkg(ctx, name, version, **kwargs):
    _activate_shims(ctx)
    # name: full import path, e.g. "golang.org/x/tools/cmd/goimports"
    if version:
        spec = "%s@%s" % (name, version)
    else:
        spec = "%s@latest" % name
    ctx.run("go", ["install", spec])

def uninstall_pkg(ctx, name, version, **kwargs):
    _activate_shims(ctx)
    # Derive binary name from the last component of the import path.
    binary = name.split("/")[-1]
    gopath_result = ctx.run("go", ["env", "GOPATH"])
    gopath = gopath_result.stdout.strip()
    ctx.delete_file("%s/bin/%s" % (gopath, binary))

def interrogate(ctx):
    # go install does not record import paths after installation — GOPATH/bin
    # holds only binary names with no reverse mapping. Return empty list;
    # meowctl reconciles via the lock file.
    return []
