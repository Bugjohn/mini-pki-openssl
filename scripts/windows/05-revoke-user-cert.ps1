param(
    [Parameter(Mandatory = $true)]
    [string]$Username
)

$ErrorActionPreference = "Stop"

$OpenSslConfig = "config\openssl.cnf"
$UserCert = "pki\users\$Username\$Username.crt"

if (-not (Test-Path $UserCert)) {
    Write-Error "Certificat introuvable : $UserCert"
    exit 1
}

Write-Host "Révocation du certificat utilisateur : $UserCert"

openssl ca `
    -config $OpenSslConfig `
    -revoke $UserCert

Write-Host ""
Write-Host "Certificat révoqué."
Write-Host "Pense à régénérer la CRL avec :"
Write-Host ".\scripts\windows\06-generate-crl.ps1"