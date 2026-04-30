# ===============================
# Mini PKI OpenSSL - Makefile
# ===============================

USER ?= demo-user

.PHONY: help init-ca key csr sign p12 user revoke crl clean

help:
	@echo "Mini PKI OpenSSL"
	@echo ""
	@echo "Usage:"
	@echo "  make init-ca"
	@echo "  make user USER=jean-marc"
	@echo "  make revoke USER=jean-marc"
	@echo "  make crl"
	@echo "  make clean"
	@echo ""
	@echo "Advanced:"
	@echo "  make key USER=jean-marc"
	@echo "  make sign USER=jean-marc"
	@echo "  make p12 USER=jean-marc"

init-ca:
	./scripts/linux/01-create-root-ca.sh

key:
	./scripts/linux/02-create-user-key-csr.sh $(USER)

csr: key

sign:
	./scripts/linux/03-sign-user-cert.sh $(USER)

p12:
	./scripts/linux/04-export-p12.sh $(USER)

user:
	./scripts/linux/02-create-user-key-csr.sh $(USER)
	./scripts/linux/03-sign-user-cert.sh $(USER)
	./scripts/linux/04-export-p12.sh $(USER)

revoke:
	./scripts/linux/05-revoke-user-cert.sh $(USER)

crl:
	./scripts/linux/06-generate-crl.sh

clean:
	@echo "WARNING: this will remove generated PKI users and root CA content."
	@echo "Use manually if needed:"
	@echo "  rm -rf pki/users/*"
	@echo "  rm -rf pki/root/certs/* pki/root/private/* pki/root/newcerts/* pki/root/crl/*"
	@echo "  rm -f pki/root/db/index.txt pki/root/db/serial pki/root/db/crlnumber"