param(
    [string]$Root = (Resolve-Path "$PSScriptRoot\..").Path,
    [string]$OutputDir = (Join-Path (Resolve-Path "$PSScriptRoot\..").Path "dist")
)

$ErrorActionPreference = "Stop"

& (Join-Path $Root "scripts\validate-skills.ps1") -Root $Root
& (Join-Path $Root "scripts\check-sensitive-terms.ps1") -Root $Root

New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null

$zipPath = Join-Path $OutputDir "finance-lease-dd-skills.zip"
if (Test-Path -LiteralPath $zipPath) {
    Remove-Item -LiteralPath $zipPath -Force
}

$items = @(
    (Join-Path $Root "skills"),
    (Join-Path $Root "docs"),
    (Join-Path $Root "README.md"),
    (Join-Path $Root "SECURITY.md"),
    (Join-Path $Root "LICENSE")
)

Compress-Archive -LiteralPath $items -DestinationPath $zipPath -Force
Write-Host "Packaged: $zipPath"
