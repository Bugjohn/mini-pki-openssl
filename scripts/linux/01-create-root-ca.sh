#!/usr/bin/env bash
set -euo pipefail

OPENSSL_CONFIG="config/openssl.cnf"
CA_DIR="pki/root"

mkdir -p "$CA_DIR/private" "$CA_DIR/certs" "$CA_DIR/db" "$CA_DIR/newcerts" "$CA_DIR/crl"

touch "$CA_DIR/db/index.txt"
[ -f "$CA_DIR/db/serial" ] || echo 1000 > "$CA_DIR/db/serial"
[ -f "$CA_DIR/db/crlnumber" ] || echo 1000 > "$CA_DIR/db/crlnumber"

echo "Création de la clé privée de la CA..."
openssl genrsa -aes256 -out "$CA_DIR/private/root-ca.key" 4096

echo "Création du certificat racine autosigné..."
openssl req -new -x509 \
  -config "$OPENSSL_CONFIG" \
  -key "$CA_DIR/private/root-ca.key" \
  -sha256 \
  -days 3650 \
  -out "$CA_DIR/certs/root-ca.crt"

echo
echo "CA créée :"
echo "- Clé  : $CA_DIR/private/root-ca.key"
echo "- Cert : $CA_DIR/certs/root-ca.crt"