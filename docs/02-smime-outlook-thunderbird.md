# 📧 S/MIME — Secure Email with Outlook & Thunderbird

> Practical guide to using S/MIME certificates for signing and encrypting emails  
> Based on certificates generated with this project

---

## 🎯 Objective

This guide explains how to:

- import a user certificate (.p12)
- configure S/MIME in email clients
- sign emails
- encrypt emails

👉 Using certificates generated from this PKI project.

---

## 🔐 What is S/MIME?

**S/MIME (Secure/Multipurpose Internet Mail Extensions)** allows:

- ✍️ **Email signing** → proves sender identity
- 🔒 **Email encryption** → ensures confidentiality

---

## 📦 Prerequisites

You must have generated a user certificate:
pki/users/jean-marc/jean-marc.p12


👉 This file contains:

- private key
- user certificate
- CA certificate

---

## 📥 Import Certificate

### 🪟 Windows (System Certificate Store)

1. Double-click `.p12` file
2. Select:
   - "Current User"
3. Enter the export password
4. Enable:
   - ✔️ "Mark this key as exportable" (optional)
5. Finish import

👉 Certificate is now available for Outlook

---

## 📧 Microsoft Outlook

### Configure S/MIME

1. Open Outlook
2. Go to:

File → Options → Trust Center → Trust Center Settings

3. Select:

Email Security

4. Under "Encrypted email":
- Click **Settings**
- Choose your certificate

---

### Send Signed Email

1. Create a new email
2. Click:

Options → Sign

3. Send email

👉 Recipient sees:
- verified sender identity
- integrity check

---

### Send Encrypted Email

⚠️ Requirement: recipient must have sent you a signed email first

1. Open recipient’s signed email
2. Add certificate to contacts
3. Compose new email
4. Click:

Options → Encrypt


👉 Only recipient can read it

---

## 🐦 Mozilla Thunderbird

### Import Certificate

1. Open Thunderbird
2. Go to:

Settings → Privacy & Security

3. Scroll to:

Certificates → Manage Certificates

4. Import `.p12`

---

### Configure S/MIME

1. Go to:

Account Settings → End-to-End Encryption

2. Select your certificate:
- signing certificate
- encryption certificate

---

### Send Signed Email

1. Compose message
2. Enable:
- ✔️ Sign

---

### Send Encrypted Email

1. Ensure recipient certificate is known
2. Enable:
- ✔️ Encrypt

---

## 🔍 Verification

### Signed Email

Recipient can verify:

- sender identity
- message integrity

---

### Encrypted Email

Only recipient can:

- decrypt message
- read content

---

## ⚠️ Common Issues

### ❌ Cannot encrypt email

👉 Cause:
- recipient certificate not available

✔️ Solution:
- ask recipient to send a signed email first

---

### ❌ Certificate not visible

👉 Cause:
- wrong certificate store
- import failed

✔️ Solution:
- re-import `.p12`

---

### ❌ Signature invalid

👉 Cause:
- untrusted CA

✔️ Solution:
- install CA certificate (`root-ca.crt`) as trusted

---

## 🔐 Security Notes

- Never share your `.p12`
- Protect with strong password
- Revoke certificate if compromised

---

## 🧠 What You Just Did

You implemented:

- identity verification
- secure communication
- real-world PKI usage

👉 This is how enterprise email security works.

---

## 🚀 Next Step

You can now explore:

- certificate revocation impact
- CRL validation
- client certificate authentication (HTTPS / APIs)

👉 See next guide: `03-authentification-http-client-cert.md`