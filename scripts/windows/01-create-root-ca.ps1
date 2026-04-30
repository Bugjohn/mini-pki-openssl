$ErrorActionPreference = "Stop"

$OpenSslConfig = "config\openssl.cnf"
$CaDir = "pki\root"

New-Item -ItemType Directory -Force "$CaDir\private" | Out-Null
New-Item -ItemType Directory -Force "$CaDir\certs" | Out-Null
New-Item -ItemType Directory -Force "$CaDir\db" | Out-Null
New-Item -ItemType Directory -Force "$CaDir\newcerts" | Out-Null
New-Item -ItemType Directory -Force "$CaDir\crl" | Out-Null

if (-not (Test-Path "$CaDir\db\index.txt")) {
    New-Item -ItemType File "$CaDir\db\index.txt" | Out-Null
}

if (-not (Test-Path "$CaDir\db\serial")) {
    "1000" | Out-File "$CaDir\db\serial" -Encoding ascii
}

if (-not (Test-Path "$CaDir\db\crlnumber")) {
    "1000" | Out-File "$CaDir\db\crlnumber" -Encoding ascii
}

Write-Host "Création de la clé privée de la CA..."
openssl genrsa -aes256 -out "$CaDir\private\root-ca.key" 4096

Write-Host "Création du certificat racine autosigné..."
openssl req -new -x509 `
    -config $OpenSslConfig `
    -key "$CaDir\private\root-ca.key" `
    -sha256 `
    -days 3650 `
    -out "$CaDir\certs\root-ca.crt"

Write-Host ""
Write-Host "CA créée :"
Write-Host "- Clé  : $CaDir\private\root-ca.key"
Write-Host "- Cert : $CaDir\certs\root-ca.crt"