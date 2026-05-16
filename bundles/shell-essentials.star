# bundles/shell-essentials.star
#
# platform: all
# after:    (see below)
#
# Core modern shell environment.
# Installs a curated set of CLI tools that replace or enhance standard
# Unix utilities with faster, friendlier, and more featureful alternatives.

after = [
    # shell + prompt
    "@stdlib//components/zsh",
    "@stdlib//components/fish",
    "@stdlib//components/starship",
    "@stdlib//components/zoxide",
    # fuzzy / search
    "@stdlib//components/fzf",
    "@stdlib//components/ripgrep",
    "@stdlib//components/fd",
    # file viewing
    "@stdlib//components/bat",
    "@stdlib//components/eza",
    "@stdlib//components/delta",
    "@stdlib//components/glow",
    # disk utils
    "@stdlib//components/dust",
    "@stdlib//components/duf",
    # process / system
    "@stdlib//components/btop",
    # data
    "@stdlib//components/jq",
    "@stdlib//components/yq",
    # scripting
    "@stdlib//components/gum",
    "@stdlib//components/direnv",
    "@stdlib//components/tealdeer",
    # multiplexer
    "@stdlib//components/zellij",
    # git
    "@stdlib//bundles/git-tools",
]
