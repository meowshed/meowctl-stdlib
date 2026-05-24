# meowctl-stdlib

Standard library for [meowctl](https://github.com/meowshed/meowctl) — the Starlark-based dotfiles manager.

## What it provides

Package manager components and curated tool bundles for macOS and Linux.

### Package managers

| Component | Platform | Description |
|-----------|----------|-------------|
| `brew` | macOS | Homebrew formula/cask installer |
| `mas` | macOS | Mac App Store |
| `apt` | Linux (Debian/Ubuntu) | `.deb` packages |
| `dnf` | Linux (Fedora/RHEL) | RPM packages |
| `pacman` | Linux (Arch) | Arch packages |
| `apk` | Linux (Alpine) | Alpine packages |
| `mise` | All | Tool version manager (aqua backend) |
| `npm` | All | Node packages |
| `pip` | All | Python packages |
| `cargo` | All | Rust crates |
| `go_install` | All | `go install` binaries |
| `fisher` | All | Fish shell plugin manager |

### Bundles

| Bundle | Components |
|--------|-----------|
| `modern-shell` | fish, starship, zoxide, atuin, fzf, bat, eza, ripgrep, fd, zellij, neovim, jq, yq, btop, dust, duf, sd, dasel, miller, glow, tealdeer, navi, watchexec, gum, direnv, age, gpg, openssl, mkcert, openssh |
| `modern-macos` | ghostty, fonts, keka, maccy, caffeine, mole |
| `github` | git, lazygit, delta, forgit, gh, git_lfs, act |

### Individual components

Browse `components/` for 60+ individual tool components: vscode, docker_cli, hammerspoon, imagemagick, ffmpeg, vhs, typora, obsidian, and more.

## Usage

In your `init.star`:

```python
component("@stdlib//bundles/modern-shell")
component("@stdlib//components/vscode")
```

## License

MIT
