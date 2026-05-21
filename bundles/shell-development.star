# bundles/shell-development.star
#
# platform: all
# after:    (see below)
#
# Shell script development toolchain.
# Static analysis and formatting for POSIX sh, bash, and fish scripts.

after = [
    "@stdlib//components/shellcheck",
    "@stdlib//components/shfmt",
]
