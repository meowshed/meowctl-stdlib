# bundles/go-development.star
#
# platform: all
# after:    (see below)
#
# Go development toolchain.
# Compiler, language server and the aggregate linter runner.

after = [
    "@stdlib//components/go",
    "@stdlib//components/gopls",
    "@stdlib//components/golangci_lint",
]
