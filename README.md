
- kotlin: ensures the Kotlin programming language is installed.
  - On macOS MacBooks: installs `kotlin` via Homebrew using the module `community.general.homebrew`; runs unprivileged.
  - On Arch Linux: installs `kotlin` via pacman using the module `community.general.pacman`; uses `become: true` for the package install.
  - The role relies on dependencies and does not re-check for Homebrew/yay internally. It declares conditional dependencies: homebrew on macOS, aur-helper on Arch.

- docker: ensures container tooling is installed.
  - On macOS MacBooks: installs `colima` and Docker CLI components (`docker`, `docker-compose`) via Homebrew using `community.general.homebrew`; runs unprivileged. Rancher Desktop is no longer installed here.
  - On Arch Linux: installs `docker` and `docker-compose` via pacman using `community.general.pacman` (uses `become: true`).
  - The role relies on dependencies and does not re-check for Homebrew/yay internally. It declares conditional dependencies: homebrew on macOS, aur-helper on Arch.

- kubernetes: ensures local Kubernetes tooling is installed.
  - On macOS MacBooks: installs `kubectl` and `minikube` via Homebrew using `community.general.homebrew`, and installs Rancher Desktop via Homebrew Cask using `community.general.homebrew_cask` (cask: `rancher`); runs unprivileged.
  - On Arch Linux: installs `kubectl` and `minikube` via pacman using `community.general.pacman` (uses `become: true`), and installs Rancher Desktop from AUR using `yay` when not already present.
  - The role relies on dependencies and does not re-check for Homebrew/yay internally. It declares conditional dependencies: homebrew on macOS, aur-helper on Arch.

- zed: ensures the Zed text editor is installed.
  - On macOS MacBooks: installs Zed via Homebrew Cask using `community.general.homebrew_cask`; runs unprivileged.
  - On Arch Linux: installs Zed via `community.general.pacman` (package `zed`); uses `become: true` for package install. If not available in the repo, it falls back to installing from AUR using `yay` with the package name `zed` and then `zed-editor` as a secondary fallback.
  - The role relies on dependencies and does not re-check for Homebrew/yay internally. It declares conditional dependencies: homebrew on macOS, aur-helper on Arch.

- firefox: ensures the Firefox browser is installed.
  - On macOS MacBooks: installs Firefox via Homebrew Cask using `community.general.homebrew_cask`; runs unprivileged.
  - On Arch Linux: installs Firefox via `community.general.pacman` (package `firefox`); uses `become: true` for the package install.
  - The role relies on dependencies and does not re-check for Homebrew/yay internally. It declares conditional dependencies: homebrew on macOS, aur-helper on Arch.

- vlc: ensures the VLC media player is installed.
  - On macOS MacBooks: installs VLC via Homebrew Cask using `community.general.homebrew_cask`; runs unprivileged.
  - On Arch Linux: installs VLC via `community.general.pacman` (package `vlc`); uses `become: true` for the package install.
  - The role relies on dependencies and does not re-check for Homebrew/yay internally. It declares conditional dependencies: homebrew on macOS, aur-helper on Arch.

- calibre: ensures the Calibre e-book manager is installed.
  - On macOS MacBooks: installs Calibre via Homebrew Cask using `community.general.homebrew_cask`; runs unprivileged.
  - On Arch Linux: installs Calibre via `community.general.pacman` (package `calibre`); uses `become: true` for the package install.
  - The role relies on dependencies and does not re-check for Homebrew/yay internally. It declares conditional dependencies: homebrew on macOS, aur-helper on Arch.

- terminal: installs terminal tooling as requested.
  - On macOS MacBooks: installs iTerm2 via Homebrew Cask using `community.general.homebrew_cask` (cask: `iterm2`); runs unprivileged.
  - On Arch Linux: no action is taken (no-op).
  - The role relies on dependencies and does not re-check for Homebrew/yay internally. It declares conditional dependencies: homebrew on macOS, aur-helper on Arch.

- utils: ensures common utility tools are installed (bpytop, glances, nmap, curl, wget, speedtest-cli, ncdu).
  - On macOS MacBooks: installs all tools via Homebrew using `community.general.homebrew`; runs unprivileged. Additionally installs: jq, coreutils, appcleaner, ffmpeg, the-unarchiver.
  - On Arch Linux: installs glances, nmap, curl, wget, speedtest-cli, ncdu via `community.general.pacman` (uses `become: true`). Installs `bpytop` via pacman when available, otherwise falls back to AUR using `yay` with idempotent checks.
  - The role relies on dependencies and does not re-check for Homebrew/yay internally. It declares conditional dependencies: homebrew on macOS, aur-helper on Arch.

- proton-privacy: ensures Proton apps (Drive, Mail, Pass, VPN) are installed.
  - On macOS MacBooks: installs the casks `proton-drive`, `proton-mail`, `proton-pass`, and `protonvpn` via Homebrew using `community.general.homebrew_cask`; runs unprivileged.
  - On Arch Linux: installs the AUR packages `proton-drive`, `proton-mail`, `proton-pass`, and `protonvpn` using `yay` (non-privileged). The role gathers package facts and installs each only when missing. It depends on the `aur-helper` role to ensure `yay` is available.
  - As with other roles, it relies on conditional dependencies: `homebrew` on macOS, `aur-helper` on Arch. It does not re-check prerequisites internally.

- discord: ensures the Discord desktop app is installed.
  - On macOS MacBooks: installs via Homebrew Cask using `community.general.homebrew_cask`; runs unprivileged.
  - On Arch Linux: installs via `community.general.pacman` (package `discord`); uses `become: true`.
  - Declares conditional dependencies: homebrew on macOS, aur-helper on Arch.

- whatsapp: ensures the WhatsApp desktop app is installed.
  - On macOS MacBooks: installs via Homebrew Cask using `community.general.homebrew_cask`; runs unprivileged.
  - On Arch Linux: attempts `community.general.pacman` (package `whatsapp`, typically unavailable), and falls back to AUR using `yay` with package `whatsapp-for-linux` when missing; uses package facts for idempotency. Pacman tasks use `become: true`.
  - Declares conditional dependencies: homebrew on macOS, aur-helper on Arch.

- signal: ensures the Signal Desktop app is installed.
  - On macOS MacBooks: installs via Homebrew Cask using `community.general.homebrew_cask`; runs unprivileged.
  - On Arch Linux: installs via `community.general.pacman` (package `signal-desktop`); uses `become: true`.
  - Declares conditional dependencies: homebrew on macOS, aur-helper on Arch.

- caprine: ensures the Caprine (Messenger) app is installed.
  - On macOS MacBooks: installs via Homebrew Cask using `community.general.homebrew_cask`; runs unprivileged.
  - On Arch Linux: attempts `community.general.pacman` (package `caprine`), and falls back to AUR using `yay` with package `caprine-bin` when missing; uses package facts for idempotency. Pacman tasks use `become: true`.
  - Declares conditional dependencies: homebrew on macOS, aur-helper on Arch.

Policy: Roles only use package managers (modules or, where needed, yay) and do not attempt to detect or honor manual app installations under /Applications. This keeps roles deterministic and idempotent.

Dependency model

- To keep roles small and clean, prerequisite checks happen once in dedicated roles and are reused via role dependencies:
  - homebrew role: verifies Homebrew exists on macOS MacBooks and fails early if missing (no installation performed).
  - aur-helper role: verifies an AUR helper (yay) exists on Arch Linux and fails early if missing (no installation performed).
- Application roles (e.g., jetbrains, python) depend on these prerequisite roles and therefore do not perform ad-hoc shell checks for Homebrew/yay themselves.


- scala: ensures the Scala language is installed.
  - On macOS MacBooks: installs `scala` via Homebrew using `community.general.homebrew`; runs unprivileged.
  - On Arch Linux: installs `scala` via pacman using `community.general.pacman`; uses `become: true` for the package install.
  - The role relies on dependencies and does not re-check for Homebrew/yay internally. It declares conditional dependencies: homebrew on macOS, aur-helper on Arch.

- apache-spark: ensures Apache Spark is installed.
  - On macOS MacBooks: installs `apache-spark` via Homebrew using `community.general.homebrew`; runs unprivileged.
  - On Arch Linux: installs `apache-spark` via pacman using `community.general.pacman` when available (uses `become: true`); if not available, falls back to AUR install using `yay` with idempotent checks based on `package_facts`.
  - The role relies on dependencies and does not re-check for Homebrew/yay internally. It declares conditional dependencies: homebrew on macOS, aur-helper on Arch.

- llm: ensures local LLM tooling is installed (Ollama, Gemini CLI, ChatGPT desktop).
  - On macOS MacBooks: installs `ollama` and `gemini-cli` via Homebrew using `community.general.homebrew`, and installs ChatGPT desktop via Homebrew Cask using `community.general.homebrew_cask` (cask: `chatgpt`); runs unprivileged. Note: if `gemini-cli` is not available in Homebrew on your system, the task is skipped without failing.
  - On Arch Linux: installs `ollama`, `chatgpt-desktop-bin`, and `google-gemini-cli` via AUR using `yay` when not available in pacman. The role gathers package facts and installs each only when missing. Pacman tasks (when attempted) use `become: true`.
  - Declares conditional dependencies: `homebrew` on macOS, `aur-helper` on Arch.

- java: installs Java tooling and configures your shell.
  - On macOS MacBooks: installs `openjdk`, `openjdk@21`, `maven`, `gradle`, and `jenv` via Homebrew. It also configures `~/.zshrc` with:
    - JAVA_HOME and PATH additions for OpenJDK (including shims for both `openjdk` and `openjdk@21`).
    - jenv initialization lines: adds `$HOME/.jenv/bin` to PATH and `eval "$(jenv init -)"`.
    - Creates system symlinks for Homebrew JDKs under `/Library/Java/JavaVirtualMachines/` (e.g., `openjdk.jdk`, `openjdk-21.jdk`) so tools can discover them. This step requires sudo once; run with `-K` the first time: `./run.sh macbook-personal -K`.
    - Adds detected JDK homes to jenv (idempotent) so you can manage versions with `jenv versions`.
  - On Arch Linux: installs `jdk-openjdk`, `jdk21-openjdk`, `maven`, and `gradle` via pacman and configures `JAVA_HOME` and PATH in `~/.zshrc`.
  - The role relies on dependencies and does not re-check for Homebrew/yay internally. It declares conditional dependencies: homebrew on macOS, aur-helper on Arch.