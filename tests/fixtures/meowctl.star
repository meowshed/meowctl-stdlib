# tests/fixtures/meowctl.star
#
# Declares only the test-pkg components. All stdlib PM dependencies
# (@stdlib//components/apt, mise, etc.) are auto-discovered at runtime by
# reading each test component's after= globals — no need to pre-declare them here.

component(name = "test-apt")
component(name = "test-dnf")
component(name = "test-pacman")
component(name = "test-apk")
component(name = "test-brew")
component(name = "test-mise")
component(name = "test-npm")
component(name = "test-python")
component(name = "test-gem")
component(name = "test-cargo")
component(name = "test-go")
component(name = "test-luarocks")
component(name = "test-github")
component(name = "test-fish")
component(name = "test-flatpak")
component(name = "test-mas")
component(name = "test-vscode")
