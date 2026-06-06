after = ["@stdlib//components/mise"]

def install(ctx):
    pkg(manager = "mise", name = "aqua:github/copilot-language-server-release", version = "latest")

def verify(ctx):
    ctx.run("copilot-language-server", ["--version"])

def upgrade(ctx):
    uppkg(manager = "mise", name = "aqua:github/copilot-language-server-release")

def uninstall(ctx):
    unpkg(manager = "mise", name = "aqua:github/copilot-language-server-release")
