# bundles/git.star
#
# platform: all
# after:    (see below)
#
# Git tooling bundle.
# Installs a curated set of git-related CLI tools beyond the base git install.

after = [
    "@stdlib//components/lazygit",
    "@stdlib//components/tig",
    "@stdlib//components/delta",
    "@stdlib//components/forgit",
]
