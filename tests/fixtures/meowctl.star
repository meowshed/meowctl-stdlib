# tests/fixtures/meowctl.star
#
# Test fixture config declaring all stdlib PM components and one test-pkg
# component per PM. Used by the platform integration test runner.
#
# Each test-pkg component installs a safe, fast package through its PM
# and declares after = ["<pm>"] so the PM is guaranteed to be installed first.

# --- distro-native PMs ---
component(name = "apt")
component(name = "dnf")
component(name = "pacman")
component(name = "apk")
component(name = "brew")
component(name = "snap")
component(name = "flatpak")

# --- tool PMs (mise-based or self-managed) ---
component(name = "mise",     after = ["brew", "apt", "dnf", "pacman", "apk"])
component(name = "node",     after = ["mise"])
component(name = "ruby",     after = ["mise"])
component(name = "rust",     after = ["mise"])
component(name = "go",       after = ["mise"])
component(name = "uv",       after = ["mise"])
component(name = "pipx",     after = ["mise"])
component(name = "luarocks", after = ["mise"])
component(name = "vscode",   after = ["mise"])
component(name = "fish",     after = ["brew", "apt", "dnf", "pacman", "apk"])
component(name = "github_release", after = ["mise"])

# --- test-pkg components (one per PM under test) ---
component(name = "test-apt",           after = ["apt"])
component(name = "test-dnf",           after = ["dnf"])
component(name = "test-pacman",        after = ["pacman"])
component(name = "test-apk",           after = ["apk"])
component(name = "test-brew",          after = ["brew"])
component(name = "test-mise",          after = ["mise"])
component(name = "test-npm",           after = ["node"])
component(name = "test-pipx",          after = ["pipx"])
component(name = "test-gem",           after = ["ruby"])
component(name = "test-cargo",         after = ["rust"])
component(name = "test-go",            after = ["go"])
component(name = "test-uv",            after = ["uv"])
component(name = "test-luarocks",      after = ["luarocks"])
component(name = "test-github-release", after = ["github_release"])
