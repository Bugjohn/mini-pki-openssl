#!/usr/bin/env bash
set -euo pipefail

USERNAME="${1:-}"

if [ -z "$USERNAME" ]; then
  echo "Usage: ./03-sign-user-cert.sh NOM_UTILISATEUR"
  exit 1
fi

OPENSSL_CONFIG="config/openssl.cnf"
SMIME_PROFILE="config/profiles/email-smime.cnf"
CA_CERT="pki/root/certs/root-ca.crt"
USER_DIR="pki/users/$USERNAME"

USER_CSR="$USER_DIR/$USERNAME.csr"
USER_CERT="$USER_DIR/$USERNAME.crt"

if [ ! -f "$USER_CSR" ]; then
  echo "ERREUR : CSR introuvable : $USER_CSR"
  exit 1
fi

if [ ! -f "$SMIME_PROFILE" ]; then
  echo "ERREUR : profil S/MIME introuvable : $SMIME_PROFILE"
  exit 1
fi

echo "Signature du certificat utilisateur..."
openssl ca \
  -config "$OPENSSL_CONFIG" \
  -extfile "$SMIME_PROFILE" \
  -extensions email_smime \
  -out "$USER_CERT" \
  -batch \
  -infiles "$USER_CSR"

echo
echo "Vérification du certificat..."
openssl verify \
  -CAfile "$CA_CERT" \
  "$USER_CERT"

echo
echo "Certificat signé : $USER_CERT"