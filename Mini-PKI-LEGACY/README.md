### 🧓 Mini-PKI-LEGACY

À l’époque, on ne parlait pas encore de DevSecOps… mais on faisait déjà de la PKI.

🇫🇷 Version Française

### 📜 Introduction

Ce dossier contient une implémentation legacy d’une mini PKI basée sur OpenSSL, telle qu’on pouvait la mettre en place au début des années 2000.

👉 À une époque où :
pas d’ACME
pas d’automatisation
pas d’API
et encore moins de DevSecOps
Tout se faisait à la main, avec quelques scripts .bat, un binaire OpenSSL et beaucoup de café ☕.
Et devine quoi ?

➡️ Ça fonctionne toujours.

### ⚙️ Fonctionnement (les 4 étapes magiques)

Le processus est simple, brut, sans abstraction :
Génération de la clé privée
Création d’une CSR (Certificate Signing Request)
Signature par la CA
Export en PKCS#12 (.p12)
👉 Oui, c’est exactement ce que font aujourd’hui les outils modernes… mais sans te le dire.

### 🎲 Le fichier .rnd (le truc bizarre qu’on oublie toujours)

Dans les anciennes versions d’OpenSSL, un fichier .rnd était utilisé pour fournir de l’entropie (randomness).

👉 En clair :
OpenSSL avait besoin d’un “seed” pour générer des clés aléatoires
Sur certains systèmes (notamment Windows), l’entropie n’était pas suffisante
Le fichier .rnd servait de réserve de hasard

Aujourd’hui :
les OS modernes fournissent une entropie de qualité
OpenSSL s’appuie directement dessus

➡️ Résultat : le fichier .rnd n’est plus nécessaire
Mais il reste ici pour des raisons historiques et de compatibilité.

### 🧠 Pourquoi ça marchait ?

Parce que la PKI n’a pas changé :
clé privée
clé publique
signature
chaîne de confiance
👉 Rien de magique. Juste des maths et des conventions.

### ⚠️ Pourquoi on ne fait plus comme ça ?

Parce que ce modèle pose de sérieux problèmes :
❌ Pas de gestion automatique de révocation (CRL / OCSP)
❌ Pas de rotation de certificats
❌ Pas d’audit
❌ Pas de journalisation
❌ Distribution manuelle de la CA (bonjour les erreurs humaines)
❌ Risque élevé de mauvaise configuration

👉 En résumé : ça marche… jusqu’au jour où ça casse

### 🚫 IMPORTANT — NE PAS UTILISER EN PRODUCTION

Ce projet est fourni :
👉 uniquement à des fins pédagogiques et expérimentales
Ne PAS utiliser en production car :
absence de gestion de la confiance centralisée
pas de mécanisme de révocation fiable
aucun contrôle de sécurité moderne
aucune conformité (PKI publique, audit, etc.)

➡️ Utiliser cette version en production reviendrait à construire un château fort… sans porte.

### 📦 État du projet

✅ Fonctionnel
✅ Ready to go
❌ Non maintenu
❌ Versions des binaires non mises à jour
👉 Ce dossier est figé volontairement.

### 🧪 Usage recommandé

laboratoire
compréhension des mécanismes PKI
formation / démonstration
nostalgie (optionnel 😄)
