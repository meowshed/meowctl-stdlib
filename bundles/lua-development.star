# bundles/lua-development.star
#
# platform: all
# after:    (see below)
#
# Lua development toolchain.
# Language server and formatter for Neovim configuration and Lua projects.

after = [
    "@stdlib//components/lua_language_server",
    "@stdlib//components/stylua",
    "@stdlib//components/luarocks",
]
