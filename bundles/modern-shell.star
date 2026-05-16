# bundles/modern-shell.star
#
# platform: all
# after:    (see below)
#
# Modern shell environment.
# Installs a curated set of CLI tools that replace or enhance standard
# Unix utilities with faster, friendlier, and more featureful alternatives.

after = [
    # shell + prompt
    "@stdlib//components/bash",
    "@stdlib//components/fish",
    "@stdlib//components/fish_bass",
    "@stdlib//components/fish_fzf",
    "@stdlib//components/fish_autopair",
    "@stdlib//components/fish_sponge",
    "@stdlib//components/starship",
    "@stdlib//components/zoxide",
    # fuzzy / search
    "@stdlib//components/fzf",
    "@stdlib//components/ripgrep",
    "@stdlib//components/fd",
    # file viewing
    "@stdlib//components/bat",
    "@stdlib//components/eza",
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
    # git tooling
    "@stdlib//bundles/git",
]
