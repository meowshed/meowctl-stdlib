# components/lua_language_server.star
#
# platform: all
# after:     ["@stdlib//components/mise"]
#
# lua-language-server — Lua language server protocol implementation.
# Used by Neovim LSP for Lua development (e.g. meowvim users).
# Installed via mise (aqua backend, prebuilt binary).

after = ["@stdlib//components/mise"]

def _activate_shims(ctx):
    home = ctx.env("HOME")
    if home:
        ctx.add_path(home + "/.local/share/mise/shims")

def install(ctx):
    _activate_shims(ctx)
    pkg(manager = "mise", name = "lua-language-server", version = "latest")

def verify(ctx):
    _activate_shims(ctx)
    ctx.run("lua-language-server", ["--version"])

def upgrade(ctx):
    _activate_shims(ctx)
    uppkg(manager = "mise", name = "lua-language-server")

def uninstall(ctx):
    _activate_shims(ctx)
    unpkg(manager = "mise", name = "lua-language-server")
