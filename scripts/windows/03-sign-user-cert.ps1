param(
    [Parameter(Mandatory = $true)]
    [string]$Username
)

$ErrorActionPreference = "Stop"

$OpenSslConfig = "config\openssl.cnf"
$SmimeProfile = "config\profiles\email-smime.cnf"
$CaCert = "pki\root\certs\root-ca.crt"
$UserDir = "pki\users\$Username"

$UserCsr = "$UserDir\$Username.csr"
$UserCert = "$UserDir\$Username.crt"

if (-not (Test-Path $UserCsr)) {
    Write-Error "CSR introuvable : $UserCsr"
    exit 1
}

if (-not (Test-Path $SmimeProfile)) {
    Write-Error "Profil S/MIME introuvable : $SmimeProfile"
    exit 1
}

Write-Host "Signature du certificat utilisateur..."

openssl ca `
    -config $OpenSslConfig `
    -extfile $SmimeProfile `
    -extensions email_smime `
    -out $UserCert `
    -batch `
    -infiles $UserCsr

Write-Host ""
Write-Host "Vérification du certificat..."

openssl verify `
    -CAfile $CaCert `
    $UserCert

Write-Host ""
Write-Host "Certificat signé : $UserCert"