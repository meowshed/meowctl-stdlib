# tests/fixtures/components/test-flatpak.star
# Installs flatpak and verifies it runs.
# Does not install any app — Flathub remote setup and app installs require
# a running user session or system dbus, which is unavailable in CI containers.
after = ["@stdlib//components/flatpak"]

def verify(ctx):
    ctx.run("flatpak", ["--version"])
