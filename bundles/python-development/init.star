# bundles/python-development.star
#
# platform: all
# after:    (see below)
#
# Python development toolchain.
# Interpreter, uv package manager, ruff linter and pyright type checker.

after = [
    "@stdlib//components/python",
    "@stdlib//components/uv",
    "@stdlib//components/ruff",
    "@stdlib//components/pyright",
]
