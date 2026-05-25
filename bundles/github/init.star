# bundles/github.star
#
# platform: all
# after:    (see below)
#
# GitHub tooling bundle.
# Installs tools for working with GitHub: CLI, LFS, and local Actions runner.

after = [
    "@stdlib//bundles/git",
    "@stdlib//components/gh",
    "@stdlib//components/git_lfs",
    "@stdlib//components/act",
]
