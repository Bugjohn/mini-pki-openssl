#!/usr/bin/env bash
set -euo pipefail

USERNAME="${1:-}"

if [ -z "$USERNAME" ]; then
  echo "Usage: ./04-export-p12.sh NOM_UTILISATEUR"
  exit 1
fi

CA_CERT="pki/root/certs/root-ca.crt"
USER_DIR="pki/users/$USERNAME"

USER_KEY="$USER_DIR/$USERNAME.key"
USER_CERT="$USER_DIR/$USERNAME.crt"
USER_P12="$USER_DIR/$USERNAME.p12"

if [ ! -f "$USER_KEY" ]; then
  echo "ERREUR : clé privée introuvable : $USER_KEY"
  exit 1
fi

if [ ! -f "$USER_CERT" ]; then
  echo "ERREUR : certificat introuvable : $USER_CERT"
  exit 1
fi

echo "Export PKCS#12..."
openssl pkcs12 -export \
  -in "$USER_CERT" \
  -inkey "$USER_KEY" \
  -certfile "$CA_CERT" \
  -name "$USERNAME" \
  -caname "Mini PKI Root CA" \
  -out "$USER_P12"

echo
echo "Certificat PKCS#12 généré : $USER_P12"