#!/usr/bin/env bash
set -euo pipefail

OPENSSL_CONFIG="config/openssl.cnf"
CRL_OUTPUT="pki/root/crl/root-ca.crl"

mkdir -p "pki/root/crl"

echo "Génération de la CRL..."

openssl ca \
  -config "$OPENSSL_CONFIG" \
  -gencrl \
  -out "$CRL_OUTPUT"

echo
echo "CRL générée : $CRL_OUTPUT"

echo
echo "Vérification de la CRL :"
openssl crl \
  -in "$CRL_OUTPUT" \
  -noout \
  -text