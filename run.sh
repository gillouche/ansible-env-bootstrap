#!/usr/bin/env bash

set -eou pipefail

SUPPORTED_ENVS=(macbook-personal macbook-work)

is_supported_env() {
  local e="$1"
  for s in "${SUPPORTED_ENVS[@]}"; do
    if [[ "$s" == "$e" ]]; then
      return 0
    fi
  done
  return 1
}

usage() {
  echo "Usage: $0 <environment> [ansible_options]"
  echo "Environments: ${SUPPORTED_ENVS[*]}"
  echo "Examples:"
  echo "  $0 macbook-personal -vv"
  echo "  $0 macbook-personal -K -vvvv    # ask become password and verbose"
}

if [ $# -lt 1 ]; then
  usage
  exit 1
fi

env_name="$1"
shift || true
extra_args=("$@")

# Validate environment
if ! is_supported_env "$env_name"; then
  echo "Unsupported environment: $env_name"
  echo "Allowed environments: ${SUPPORTED_ENVS[*]}"
  exit 3
fi

playbook="${env_name}.yml"

# Ensure playbook exists under playbooks/
if [ ! -f "playbooks/${playbook}" ]; then
  echo "Playbook not found: playbooks/${playbook}"
  exit 4
fi

inventory_path="inventories/${env_name}/hosts.yml"
if [ ! -f "$inventory_path" ]; then
  echo "Inventory file not found: $inventory_path"
  echo "Expected one of: inventories/${SUPPORTED_ENVS[*]/%/\/hosts.yml}"
  exit 5
fi

echo "Using playbook: playbooks/${playbook}"
echo "Using environment: ${env_name} (inventory: $inventory_path)"

# Prefer running Ansible via uv to use the project's pinned Python deps from pyproject.toml/uv.lock
if command -v uv >/dev/null 2>&1; then
  echo "Running via uv (using project-managed dependencies)"
  uv run ansible-playbook -e target_user=$USER -i "$inventory_path" "playbooks/${playbook}" "${extra_args[@]}"
else
  echo "uv not found; falling back to system ansible-playbook"
  ansible-playbook -e target_user=$USER -i "$inventory_path" "playbooks/${playbook}" "${extra_args[@]}"
fi
