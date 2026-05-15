# tests/fixtures/components/test-apk.star
# Installs jq via apk. Safe, fast, no interaction required.
after = ["@stdlib//components/apk.star"]

pkg(manager = "apk", name = "jq")

def verify(ctx):
    ctx.run("jq", ["--version"])
