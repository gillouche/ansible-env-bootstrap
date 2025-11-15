# ansible-env-bootstrap

Ansible project to setup Macbook laptop (personal and work) with common dev tools and configurations.

This projects uses Nix and homebrew which are expected to be installed.

## Development environment

This repository provides a Nix Flake dev shell with Python 3.14.

How to use:
- With direnv: run `direnv allow` once in the repo; the environment will auto-activate on cd.
- Without direnv: run `nix develop` to enter the shell.
- Verify with `python3 --version` (should report Python 3.14.x).

Zsh configuration inside the dev shell:
- The dev shell will source your `~/.zshrc` if you're using zsh. To disable this behavior, set `DISABLE_NIX_ZSHRC=1` before entering the shell.

All dependencies are defined in pyproject.toml and locked in uv.lock.
