# ansible-env-bootstrap

Ansible project to setup new Macbook laptop.

This projects uses Nix and homebrew which are expected to be installed.

## Development environment

This repository provides a Nix Flake dev shell with Python 3.14.

How to use:
- With direnv: run `direnv allow` once in the repo; the environment will auto-activate on cd.
- Without direnv: run `nix develop` to enter the shell.
- Verify with `python3 --version` (should report Python 3.14.x).

Zsh configuration inside the dev shell:
- The dev shell will source your `~/.zshrc` if you're using zsh. To disable this behavior, set `DISABLE_NIX_ZSHRC=1` before entering the shell.

Notes about packaging tools on Python 3.14:
- We intentionally do not include the python "pip" package from nixpkgs in the dev shell because it can pull in Sphinx → html5lib, which currently fails to build with Python 3.14 upstream.
- Instead, the shell includes `uv`, a fast Python package and project manager. Use uv's native workflow — no pip:
  - Initialize/refresh the environment: `uv sync`
  - Run tools from project deps: `uv run ansible-playbook -i <inventory> playbooks/<pb>.yml`
  - Add a dependency: `uv add <package>` (or `uv add -E dev <package>` for dev-only)
  - Update deps: `uv lock --upgrade`
  - Lint examples: `uv run ansible-lint` and `uv run yamllint .`

All dependencies are defined in pyproject.toml and locked in uv.lock.



