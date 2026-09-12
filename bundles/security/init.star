# bundles/security.star
#
# platform: all
# after:    (see below)
#
# Security and supply-chain scanning.
# Secret detection, vulnerability scanning, SBOM generation and encrypted secrets.

after = [
    "@stdlib//components/gitleaks",
    "@stdlib//components/trivy",
    "@stdlib//components/syft",
    "@stdlib//components/grype",
    "@stdlib//components/sops",
]
