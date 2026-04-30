# 🔐 Client Certificate Authentication (TLS) — NGINX & Apache

> Practical guide to implementing client certificate authentication  
> Using certificates generated with this PKI project

---

## 🎯 Objective

This guide explains how to:

- use client certificates for authentication
- configure a web server to require certificates
- validate users based on PKI identity

👉 Using NGINX and Apache examples.

---

## 🧠 What is Client Certificate Authentication?

Unlike traditional authentication (login/password):

👉 the client proves its identity using a certificate.

Client → presents certificate → Server verifies → Access granted


---

## 🔐 Authentication Flow


[ Client ]
|
| TLS Handshake + Certificate
↓
[ Web Server ]
|
| Verify against trusted CA
↓
[ Application / Backend ]


Steps:

1. Client connects via HTTPS
2. Server requests a certificate
3. Client sends certificate
4. Server validates certificate
5. Access granted or denied

---

## 📦 Prerequisites

You must have:

- Root CA certificate:

pki/root/certs/root-ca.crt

- User certificate:

pki/users/jean-marc/jean-marc.crt

- Private key:

pki/users/jean-marc/jean-marc.key


---

## 🌐 NGINX Configuration

### Enable Client Certificate Authentication

```nginx
server {
  listen 443 ssl;
  server_name localhost;

  ssl_certificate     /etc/nginx/ssl/server.crt;
  ssl_certificate_key /etc/nginx/ssl/server.key;

  # Trust CA
  ssl_client_certificate /etc/nginx/ssl/root-ca.crt;

  # Require client certificate
  ssl_verify_client on;

  location / {
      return 200 "Client certificate authentication successful\n";
  }
}
Optional: Pass Certificate Info to Backend
location / {
    proxy_set_header X-Client-Cert $ssl_client_cert;
    proxy_set_header X-Client-Verify $ssl_client_verify;
    proxy_set_header X-Client-DN $ssl_client_s_dn;

    proxy_pass http://backend;
}

👉 This allows backend applications to:

identify user
enforce authorization rules
🧰 Apache Configuration
Enable Modules
a2enmod ssl
a2enmod headers
VirtualHost Configuration
<VirtualHost *:443>

    SSLEngine on

    SSLCertificateFile /etc/apache2/ssl/server.crt
    SSLCertificateKeyFile /etc/apache2/ssl/server.key

    # Trust CA
    SSLCACertificateFile /etc/apache2/ssl/root-ca.crt

    # Require client certificate
    SSLVerifyClient require
    SSLVerifyDepth 2

    <Location />
        Require all granted
    </Location>

</VirtualHost>
Pass Certificate Info to Backend
RequestHeader set X-Client-DN "%{SSL_CLIENT_S_DN}s"
RequestHeader set X-Client-Verify "%{SSL_CLIENT_VERIFY}s"
🧪 Testing the Setup
Using curl
curl https://localhost \
  --cert pki/users/jean-marc/jean-marc.crt \
  --key pki/users/jean-marc/jean-marc.key \
  --cacert pki/root/certs/root-ca.crt
Expected Result
Client certificate authentication successful
❌ Test Without Certificate
curl https://localhost

👉 Result:

403 Forbidden
🔍 Verification
Successful Authentication
certificate trusted
signed by CA
valid (not expired)
Failed Authentication
unknown CA
revoked certificate
missing certificate
⚠️ Common Issues
❌ "No required SSL certificate was sent"

👉 Cause:

client not providing certificate
❌ "Certificate not trusted"

👉 Cause:

CA not configured on server
❌ "SSL handshake failed"

👉 Cause:

mismatch key/certificate
invalid chain
🔐 Security Considerations
Strong Authentication
no password required
identity tied to certificate
Revocation Matters

👉 If certificate is compromised:

revoke it
update CRL
enforce validation
Backend Trust

👉 Never trust headers blindly

Always verify:

certificate validity
CA chain
revocation status
🧠 Real-World Use Cases
internal APIs (service-to-service auth)
admin access (strong authentication)
VPN / Zero Trust environments
IoT device authentication
🚀 What This Project Demonstrates

With this setup, you can:

enforce certificate-based authentication
simulate enterprise PKI usage
test secure access scenarios

💬 Final Thought
Client certificate authentication is:
one of the strongest forms of authentication available

👉 It removes:

passwords
phishing risks
credential reuse

And replaces them with:

cryptographic identity