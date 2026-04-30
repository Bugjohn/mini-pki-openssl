param(
    [Parameter(Mandatory = $true)]
    [string]$Username
)

$ErrorActionPreference = "Stop"

.\scripts\windows\02-create-user-key-csr.ps1 -Username $Username
.\scripts\windows\03-sign-user-cert.ps1 -Username $Username
.\scripts\windows\04-export-p12.ps1 -Username $Username

Write-Host ""
Write-Host "Utilisateur complet généré : pki\users\$Username"