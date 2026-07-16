[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"
Set-Location -LiteralPath $PSScriptRoot

$dist = Join-Path $PSScriptRoot "dist"
$staging = Join-Path $env:TEMP ("project-continuity-kit-" + [guid]::NewGuid().ToString("N"))
$packageRoot = Join-Path $staging "project-continuity-kit"
$zipPath = Join-Path $dist "project-continuity-kit.zip"

try {
  New-Item -ItemType Directory -Force -Path $packageRoot, $dist | Out-Null

  Copy-Item -LiteralPath ".\kit" -Destination $packageRoot -Recurse -Force
  Copy-Item -LiteralPath ".\INSTALL_PROMPT.md", ".\LESSONS.md", ".\README.md", ".\install.ps1", ".\install.sh" -Destination $packageRoot -Force

  if (Test-Path -LiteralPath $zipPath) {
    Remove-Item -LiteralPath $zipPath -Force
  }

  Compress-Archive -Path $packageRoot -DestinationPath $zipPath -CompressionLevel Optimal

  $hash = Get-FileHash -LiteralPath $zipPath -Algorithm SHA256
  Write-Host "Package created:" -ForegroundColor Green
  Write-Host $zipPath
  Write-Host "SHA256: $($hash.Hash.ToLowerInvariant())"
} finally {
  Remove-Item -LiteralPath $staging -Recurse -Force -ErrorAction SilentlyContinue
}
