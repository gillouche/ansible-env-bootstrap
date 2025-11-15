This repository is now macOS-only.

Highlights by role (macOS MacBook):

- kotlin: installs kotlin via Homebrew.
- docker: installs colima and Docker CLI components via Homebrew.
- kubernetes: installs kubectl, minikube, helm, k9s via Homebrew; Rancher Desktop via Homebrew Cask.
- zed: installs Zed via Homebrew Cask.
- firefox: installs Firefox via Homebrew Cask.
- vlc: installs VLC via Homebrew Cask.
- calibre: installs Calibre via Homebrew Cask.
- terminal: installs iTerm2 via Homebrew Cask.
- utils: installs common CLI tools via Homebrew (bpytop, glances, nmap, curl, wget, speedtest-cli, ncdu, jq, coreutils, appcleaner, ffmpeg, the-unarchiver).
- proton-privacy: installs Proton apps via Homebrew Cask (Drive, Mail, Pass, VPN) when available.
- discord: installs Discord via Homebrew Cask.
- signal: installs Signal via Homebrew Cask.
- caprine: installs Caprine via Homebrew Cask.
- scala: installs Coursier (cs) via Homebrew.
- apache-spark: installs Apache Spark via Homebrew.
- llm: installs Ollama and Gemini CLI via Homebrew; ChatGPT via Homebrew Cask when available.
- java: installs OpenJDK, OpenJDK@21, Maven, Gradle, and jenv via Homebrew and configures shell; system JDK symlinks are optional.

Policy: Roles install software using Homebrew or Homebrew Cask and do not attempt to detect manual app installations under /Applications. This keeps roles deterministic and idempotent.

Dependency model

- To keep roles small and clean, prerequisite checks happen once in dedicated roles and are reused via role dependencies:
  - homebrew role: verifies Homebrew exists on macOS MacBooks and fails early if missing (no installation performed).
  - Application roles (e.g., jetbrains, python) depend on these prerequisite roles and therefore do not perform ad-hoc shell checks for Homebrew themselves.