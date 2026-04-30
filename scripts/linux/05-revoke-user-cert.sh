#!/usr/bin/env bash
set -euo pipefail

USERNAME="${1:-}"

if [ -z "$USERNAME" ]; then
  echo "Usage: ./05-revoke-user-cert.sh NOM_UTILISATEUR"
  exit 1
fi

OPENSSL_CONFIG="config/openssl.cnf"
USER_CERT="pki/users/$USERNAME/$USERNAME.crt"

if [ ! -f "$USER_CERT" ]; then
  echo "ERREUR : certificat introuvable : $USER_CERT"
  exit 1
fi

echo "Révocation du certificat utilisateur : $USER_CERT"

openssl ca \
  -config "$OPENSSL_CONFIG" \
  -revoke "$USER_CERT"

echo
echo "Certificat révoqué."
echo "Pense à régénérer la CRL avec :"
echo "./scripts/linux/06-generate-crl.sh"