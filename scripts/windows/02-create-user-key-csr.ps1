param(
    [Parameter(Mandatory = $true)]
    [string]$Username
)

$ErrorActionPreference = "Stop"

$OpenSslConfig = "config\openssl.cnf"
$UserDir = "pki\users\$Username"

New-Item -ItemType Directory -Force $UserDir | Out-Null

Write-Host "Création de la clé privée utilisateur..."
openssl genrsa -out "$UserDir\$Username.key" 2048

Write-Host "Création de la CSR utilisateur..."
openssl req -new `
    -config $OpenSslConfig `
    -key "$UserDir\$Username.key" `
    -out "$UserDir\$Username.csr"

Write-Host ""
Write-Host "CSR générée : $UserDir\$Username.csr"