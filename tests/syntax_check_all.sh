#!/usr/bin/env bash
set -euo pipefail

# Syntax-check every role using a tiny generated playbook so we validate task files parse cleanly.
# We avoid running tasks by not executing the playbook, only --syntax-check.

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
ROLES_DIR="$ROOT_DIR/roles"
TMP_DIR="${TMPDIR:-/tmp}/ansible-role-syntax"
mkdir -p "$TMP_DIR"

rc=0

for role_path in "$ROLES_DIR"/*; do
  [ -d "$role_path" ] || continue
  role_name="$(basename "$role_path")"

  # Skip hidden/system dirs just in case
  [[ "$role_name" =~ ^\.|^_ ]] && continue

  playbook="$TMP_DIR/${role_name}_syntax.yml"

  cat > "$playbook" <<EOF
---
- name: Syntax check role $role_name
  hosts: localhost
  gather_facts: false
  connection: local
  vars:
    # Some roles expect these variables to exist. Provide safe defaults.
    target_user: testuser
    device_type: macbook
    distro: archlinux
    role_execution_flag: "${role_name}_executed"
  roles:
    - role: ${role_name}
      vars:
        # Ensure roles that short-circuit on this flag keep consistent structure
        ${role_name}_executed: false
EOF

  echo "[syntax-check] $role_name"
  if ! ansible-playbook -i 'localhost,' -c local --syntax-check "$playbook"; then
    echo "Syntax check failed for role: $role_name" >&2
    rc=1
  fi
done

exit $rc
