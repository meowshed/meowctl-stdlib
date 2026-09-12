# bundles/rust-development.star
#
# platform: all
# after:    (see below)
#
# Rust development toolchain.
# Toolchain plus the official language server.

after = [
    "@stdlib//components/rust",
    "@stdlib//components/rust_analyzer",
]
