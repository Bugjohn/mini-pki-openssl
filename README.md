# 🔐 Mini PKI with OpenSSL

> A lightweight and educational Public Key Infrastructure (PKI) implementation using OpenSSL  
> Designed for security labs, real-world use cases, and infrastructure understanding.

🌍 Languages: 🇬🇧 English (default) | 🇫🇷 [French version](README.fr.md)

---

## 🚀 Quick Demo

make init-ca
make user USER=bob

## ⚙️ Prerequisites

### Install OpenSSL (recommended)

Make sure OpenSSL is installed on your system.

#### Linux

sudo apt install openssl

### Powershell

winget install ShiningLight.OpenSSL

### macOS

brew install openssl

## 🎯 Overview

This project provides a complete PKI workflow:

- Root Certificate Authority (CA)
- User certificate generation (key + CSR)
- Certificate signing
- PKCS#12 export (.p12)
- Certificate revocation
- CRL (Certificate Revocation List)

👉 Built to demonstrate real PKI concepts without unnecessary complexity.

---

## 🧠 Real-World Scenario

Imagine a company that wants to:

- secure internal communications
- ensure email authenticity
- implement certificate-based authentication

### Example workflow:

1. 🔐 IT team creates a Root CA
2. 👤 User certificate is generated
3. ✍️ Certificate is signed by the CA
4. 📦 User imports `.p12` into Outlook / Thunderbird
5. 📧 Emails are now:
   - signed (integrity + identity)
   - encrypted (confidentiality)
6. 🚫 If a user leaves → certificate is revoked
7. 📋 CRL is updated and distributed

👉 This is exactly how enterprise PKI works (simplified).

---

## 🏗️ Architecture

            +-------------------+
            |     Root CA       |
            | (private key 🔐)  |
            +---------+---------+
                      |
                      | signs
                      ↓
    +-----------------------------+
    |      User Certificate       |
    |  (key + CSR → signed cert) |
    +-------------+---------------+
                  |
                  | export
                  ↓
         +------------------+
         |     PKCS#12      |
         | (.p12 / .pfx)    |
         +------------------+
                  |
                  ↓
    +-----------------------------+
    | Email / Browser / API Auth |
    +-----------------------------+

## 📸 Demo (example)

### Generated user structure:

pki/users/bob/
├── bob.key
├── bob.csr
├── bob.crt
└── bob.p12

### Usage:

- Import `.p12` into Outlook / Thunderbird
- Send signed/encrypted emails
- Use certificate for authentication

---

## ⚙️ Requirements

### OpenSSL

#### Linux

sudo apt install openssl

#### macOS

brew install openssl

#### Windows

winget install ShiningLight.OpenSSL

---

## 🚀 Quick Start

### 1. Create Root CA

./scripts/linux/01-create-root-ca.sh

---

### 2. Generate User

./scripts/linux/02-create-user-key-csr.sh bob

---

### 3. Sign Certificate

./scripts/linux/03-sign-user-cert.sh bob

---

### 4. Export PKCS#12

./scripts/linux/04-export-p12.sh bob

---

### 5. Revoke Certificate

./scripts/linux/05-revoke-user-cert.sh bob

---

### 6. Generate CRL

./scripts/linux/06-generate-crl.sh

---

## 🔐 How it Works

Root CA
│
├── signs → User certificates
│
└── manages → Revocation + CRL

---

## ⚠️ Security Notes

- ❌ Never commit:
  - private keys (`*.key`)
  - PKCS#12 files (`*.p12`)
- ✔️ Protect the CA private key
- ✔️ Use strong passphrases
- ✔️ Store CA offline (best practice)

---

## 💡 Design Choices

- Minimal but realistic PKI
- Separation of CA config and certificate profiles
- Cross-platform support
- Script-based automation

---

## 🚀 Future Improvements

- Intermediate CA support
- REST API (certificate lifecycle)
- Web UI
- Full automation (one-command provisioning)

---

## 👨‍💻 Author

Jean-Marc : BugJohn

---

## ⭐ Why this project matters

PKI is at the core of modern security:

- TLS / HTTPS
- Email security (S/MIME)
- Identity & authentication
- Zero Trust architectures

👉 This project bridges theory and real-world implementation.

## 🧓 Legacy Version Available

A Legacy version of this project is also available in the repository: Mini-PKI-LEGACY.

It reproduces a typical early 2000s implementation, based on .bat scripts and direct OpenSSL usage, without automation or abstraction.

## 👉 This version is:

fully functional and ready-to-use
intentionally not maintained
intended for educational purposes only

It provides a hands-on understanding of PKI fundamentals, without modern layers (ACME, APIs, automation).

## ⚠️ Do not use in production: no revocation management, no governance, and no modern security mechanisms.

➡️ A great way to realize that, in the end… nothing really changed 😉
