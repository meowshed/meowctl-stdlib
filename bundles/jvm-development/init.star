# bundles/jvm-development.star
#
# platform: all
# after:    (see below)
#
# JVM development toolchain.
# Java runtime plus the Kotlin compiler and both mainstream build tools.

after = [
    "@stdlib//components/java",
    "@stdlib//components/kotlin",
    "@stdlib//components/gradle",
    "@stdlib//components/maven",
]
