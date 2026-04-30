$ErrorActionPreference = "Stop"

$OpenSslConfig = "config\openssl.cnf"
$CrlOutput = "pki\root\crl\root-ca.crl"

New-Item -ItemType Directory -Force "pki\root\crl" | Out-Null

Write-Host "Génération de la CRL..."

openssl ca `
    -config $OpenSslConfig `
    -gencrl `
    -out $CrlOutput

Write-Host ""
Write-Host "CRL générée : $CrlOutput"

Write-Host ""
Write-Host "Vérification de la CRL :"

openssl crl `
    -in $CrlOutput `
    -noout `
    -text