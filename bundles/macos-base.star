# bundles/macos-base.star
#
# platform: ["macos"]
# after:    (see below)
#
# Base macOS environment.
# Installs the core utilities and apps that make a Mac feel like home.

after = [
    # terminal
    "@stdlib//components/ghostty",
    "@stdlib//components/fonts",
    # file management
    "@stdlib//components/keka",
    # clipboard
    "@stdlib//components/maccy",
    # utility
    "@stdlib//components/caffeine",
    "@stdlib//components/mole",
    # iWork
    "@stdlib//components/keynote",
    "@stdlib//components/numbers",
    "@stdlib//components/pages",
]
