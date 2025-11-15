#!/usr/bin/env bash

set -eou pipefail

SUPPORTED_ENVS=(macbook-common macbook-personal macbook-work)

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
  echo "Usage: $0 <playbook.yml> <environment> [ansible_options]"
  echo "Or:    $0 <environment> [ansible_options]             # shorthand"
  echo "Or:    $0 <environment>.yml [ansible_options]         # shorthand"
  echo "Environments: macbook-personal | macbook-work"
  echo "Examples:"
  echo "  $0 macbook-personal -vv"
  echo "  $0 macbook-personal -K            # ask become password if your play/tasks use become: true"
}

if [ $# -lt 1 ]; then
  usage
  exit 1
fi

playbook=""
env_name=""
extra_opts=""

arg1="$1"
arg2="${2-}"
arg3="${3-}"

# If a trailing option is provided (e.g., -v/-vv/-vvv/-K), capture it but keep parsing other args.
if [[ -n "$arg3" && "$arg3" == -* ]]; then
  extra_opts="$arg3"
elif [[ -n "$arg2" && "$arg2" == -* ]]; then
  extra_opts="$arg2"
  arg2="" # clear so we can use shorthand with two args where 2nd is an option
fi

if [[ "$arg1" == *.yml ]]; then
  # First argument is a playbook filename
  playbook="$arg1"
  base="${arg1%.yml}"
  if [[ -n "$arg2" ]]; then
    env_name="$arg2"
  else
    # infer env from playbook basename if supported
    if is_supported_env "$base"; then
      env_name="$base"
    else
      echo "Cannot infer environment from playbook name: $arg1"
      usage
      exit 2
    fi
  fi
else
  # First argument is not a .yml file. If it's a supported env and no explicit env provided, use shorthand.
  if is_supported_env "$arg1" && [[ -z "$arg2" ]]; then
    env_name="$arg1"
    playbook="${env_name}.yml"
  else
    # Fallback to classic order: <playbook.yml> <environment>
    if [[ -z "$arg2" ]]; then
      usage
      exit 1
    fi
    playbook="$arg1"
    env_name="$arg2"
  fi
fi

# Validate environment
if ! is_supported_env "$env_name"; then
  echo "Unsupported environment: $env_name"
  echo "Allowed environments: ${SUPPORTED_ENVS[*]}"
  exit 3
fi

# Sanity check: if playbook looks like <name>.yml, and name doesn't equal env, warn
pb_base="${playbook%.yml}"
if [[ "$pb_base" != "$env_name" ]]; then
  echo "Warning: playbook ($playbook) does not match environment ($env_name)."
fi

# Ensure playbook exists under playbooks/
if [ ! -f "playbooks/${playbook}" ]; then
  echo "Playbook not found: playbooks/${playbook}"
  exit 4
fi

inventory_path="inventories/${env_name}/hosts.yml"
if [ ! -f "$inventory_path" ]; then
  echo "Inventory file not found: $inventory_path"
  echo "Expected one of: inventories/${SUPPORTED_ENVS[0]}|${SUPPORTED_ENVS[1]}|${SUPPORTED_ENVS[2]}/hosts.yml"
  exit 5
fi

echo "Using playbook: playbooks/${playbook}"
echo "Using environment: ${env_name} (inventory: $inventory_path)"

# Prefer running Ansible via uv to use the project's pinned Python deps from pyproject.toml/uv.lock
if command -v uv >/dev/null 2>&1; then
  echo "Running via uv (using project-managed dependencies)"
  uv run ansible-playbook -e target_user=$USER -i "$inventory_path" "playbooks/${playbook}" ${extra_opts}
else
  echo "uv not found; falling back to system ansible-playbook"
  ansible-playbook -e target_user=$USER -i "$inventory_path" "playbooks/${playbook}" ${extra_opts}
fi
