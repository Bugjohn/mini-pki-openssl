### 🇬🇧 English Version

### 📜 Introduction

This folder contains a legacy implementation of a mini PKI based on OpenSSL, as it was commonly done in the early 2000s.

👉 Back when:
no ACME
no automation
no APIs
definitely no DevSecOps
Everything was done manually, using .bat scripts, an OpenSSL binary, and a lot of coffee ☕.
And guess what?

➡️ It still works.

### ⚙️ How it works (the 4 magical steps)

The process is simple and raw:
Generate a private key
Create a CSR (Certificate Signing Request)
Sign it with a CA
Export to PKCS#12 (.p12)
👉 Yes, that’s exactly what modern tools still do… just hidden behind APIs.

### 🎲 The .rnd file (the weird thing nobody remembers)

Older versions of OpenSSL used a .rnd file to provide entropy.

👉 In simple terms:
OpenSSL needed a randomness seed
Some systems (especially Windows) lacked sufficient entropy
.rnd acted as a randomness pool

Today:
modern OS provide strong entropy sources
OpenSSL relies directly on them

➡️ The .rnd file is no longer required
It is kept here for historical and compatibility reasons.

### 🧠 Why it worked

Because PKI fundamentals never changed:
private key
public key
signature
trust chain
👉 No magic. Just math and standards.

### ⚠️ Why we don’t do this anymore

Because this model has serious limitations:
❌ No revocation management (CRL / OCSP)
❌ No certificate rotation
❌ No auditing
❌ No logging
❌ Manual CA distribution (error-prone)
❌ High risk of misconfiguration
👉 In short: it works… until it breaks

### 🚫 IMPORTANT — DO NOT USE IN PRODUCTION

This project is provided:
👉 for educational and experimental purposes only
Do NOT use in production because:
no centralized trust management
no reliable revocation mechanisms
no modern security controls
no compliance guarantees
➡️ Using this in production is like building a castle… without a gate.

### 📦 Project status

✅ Functional
✅ Ready to use
❌ Not maintained
❌ Binary versions not updated
👉 This folder is intentionally frozen.

### 🧪 Recommended usage

lab environments
PKI learning
demonstrations
nostalgia (optional 😄)
