#!/usr/bin/env bash
set -euo pipefail

USERNAME="${1:-}"

if [ -z "$USERNAME" ]; then
  echo "Usage: ./02-create-user-key-csr.sh NOM_UTILISATEUR"
  exit 1
fi

OPENSSL_CONFIG="config/openssl.cnf"
USER_DIR="pki/users/$USERNAME"

mkdir -p "$USER_DIR"

echo "Création de la clé privée utilisateur..."
openssl genrsa -out "$USER_DIR/$USERNAME.key" 2048

echo "Création de la CSR utilisateur..."
openssl req -new \
  -config "$OPENSSL_CONFIG" \
  -key "$USER_DIR/$USERNAME.key" \
  -out "$USER_DIR/$USERNAME.csr"

echo
echo "CSR générée : $USER_DIR/$USERNAME.csr"