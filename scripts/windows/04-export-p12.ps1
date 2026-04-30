param(
    [Parameter(Mandatory = $true)]
    [string]$Username
)

$ErrorActionPreference = "Stop"

$CaCert = "pki\root\certs\root-ca.crt"
$UserDir = "pki\users\$Username"

$UserKey = "$UserDir\$Username.key"
$UserCert = "$UserDir\$Username.crt"
$UserP12 = "$UserDir\$Username.p12"

if (-not (Test-Path $UserKey)) {
    Write-Error "Clé privée introuvable : $UserKey"
    exit 1
}

if (-not (Test-Path $UserCert)) {
    Write-Error "Certificat introuvable : $UserCert"
    exit 1
}

Write-Host "Export PKCS#12..."
openssl pkcs12 -export `
    -in $UserCert `
    -inkey $UserKey `
    -certfile $CaCert `
    -name $Username `
    -caname "Mini PKI Root CA" `
    -out $UserP12

Write-Host ""
Write-Host "Certificat PKCS#12 généré : $UserP12"