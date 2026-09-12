# bundles/kubernetes.star
#
# platform: all
# after:    (see below)
#
# Kubernetes toolchain.
# Cluster client, context switching, log tailing, packaging and a terminal UI.

after = [
    "@stdlib//components/kubectl",
    "@stdlib//components/kubectx",
    "@stdlib//components/stern",
    "@stdlib//components/helm",
    "@stdlib//components/k9s",
]
