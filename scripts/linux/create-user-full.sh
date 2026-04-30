#!/usr/bin/env bash
set -euo pipefail

USERNAME="${1:-}"

if [ -z "$USERNAME" ]; then
  echo "Usage: ./create-user-full.sh NOM_UTILISATEUR"
  exit 1
fi

./scripts/linux/02-create-user-key-csr.sh "$USERNAME"
./scripts/linux/03-sign-user-cert.sh "$USERNAME"
./scripts/linux/04-export-p12.sh "$USERNAME"

echo
echo "Utilisateur complet généré : pki/users/$USERNAME"