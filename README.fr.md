# 🔐 Mini PKI avec OpenSSL

> Implémentation simple et pédagogique d’une infrastructure à clé publique (PKI) avec OpenSSL  
> Conçue pour les labs sécurité, les cas d’usage réels et la compréhension des mécanismes d’authentification.

🌍 Langues : 🇬🇧 [English](README.md) | 🇫🇷 Français (par défaut ici)

---

## 🚀 Quick Demo

```bash
make init-ca
make user USER=bob


## 🎯 Objectif

Ce projet propose une chaîne PKI complète :

- création d’une autorité de certification (CA)
- génération de certificats utilisateurs (clé + CSR)
- signature des certificats
- export au format PKCS#12 (.p12)
- révocation de certificats
- génération d’une CRL (Certificate Revocation List)

👉 Le tout avec une approche simple, reproductible et compréhensible.

---

## 🧠 Cas d’usage réel

Imagine une entreprise souhaitant :

- sécuriser ses communications internes
- garantir l’identité des utilisateurs
- chiffrer les emails sensibles
- mettre en place une authentification par certificat

### Workflow typique :

1. 🔐 L’équipe IT crée une autorité de certification
2. 👤 Un certificat utilisateur est généré
3. ✍️ Le certificat est signé par la CA
4. 📦 L’utilisateur importe son fichier `.p12` dans Outlook / Thunderbird
5. 📧 Les emails deviennent :
   - signés (intégrité + identité)
   - chiffrés (confidentialité)
6. 🚫 Un utilisateur quitte l’entreprise → son certificat est révoqué
7. 📋 La CRL est mise à jour

👉 C’est exactement le fonctionnement d’une PKI en entreprise (version simplifiée).

---

## 🏗️ Architecture

            +-------------------+
            |   Autorité CA     |
            | (clé privée 🔐)   |
            +---------+---------+
                      |
                      | signe
                      ↓
    +-----------------------------+
    |   Certificat utilisateur    |
    |  (clé + CSR → certificat)   |
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
 +------------------------------------+
 | Email / Navigateur / Auth API     |
 +------------------------------------+

## 📸 Exemple

Structure générée :


pki/users/bob/
├── bob.key
├── bob.csr
├── bob.crt
└── bob.p12


Utilisation :

- import dans Outlook / Thunderbird
- signature et chiffrement des emails
- authentification par certificat

---

## ⚙️ Prérequis

### OpenSSL

#### Linux

sudo apt install openssl


#### macOS

brew install openssl


#### Windows

winget install ShiningLight.OpenSSL


---

## 🚀 Démarrage rapide

### 1. Créer la CA


./scripts/linux/01-create-root-ca.sh


---

### 2. Créer un utilisateur


./scripts/linux/02-create-user-key-csr.sh bob


---

### 3. Signer le certificat


./scripts/linux/03-sign-user-cert.sh bob


---

### 4. Export PKCS#12


./scripts/linux/04-export-p12.sh bob


---

### 5. Révoquer un certificat


./scripts/linux/05-revoke-user-cert.sh bob


---

### 6. Générer la CRL


./scripts/linux/06-generate-crl.sh


---

## 🔐 Fonctionnement


Autorité CA
│
├── signe → Certificats utilisateurs
│
└── gère → Révocation + CRL


---

## ⚠️ Bonnes pratiques de sécurité

- ❌ Ne jamais versionner :
  - les clés privées (`*.key`)
  - les fichiers PKCS#12 (`*.p12`)
- ✔️ Utiliser `.gitignore`
- ✔️ Protéger la clé de la CA
- ✔️ Utiliser des mots de passe robustes
- ✔️ Stocker la CA hors ligne (idéalement)

---

## 💡 Choix techniques

- PKI volontairement simple mais fonctionnelle
- séparation entre configuration CA et profils certificats
- compatibilité multi-OS
- automatisation par scripts

---

## 🚀 Améliorations possibles

- ajout d’une CA intermédiaire
- API de gestion des certificats
- interface web
- automatisation complète

---

## 👨‍💻 Auteur

Jean-Marc : Bugjohn

---

## ⭐ Pourquoi ce projet est important

La PKI est au cœur de la sécurité moderne :

- TLS / HTTPS
- sécurité des emails (S/MIME)
- gestion des identités
- architectures Zero Trust

👉 Ce projet fait le lien entre théorie et pratique.