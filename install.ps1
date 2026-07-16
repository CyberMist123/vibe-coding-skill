[CmdletBinding()]
param(
  [Parameter(Mandatory = $true)]
  [string]$TargetPath,

  [string]$ProjectName,

  [switch]$Force
)

$ErrorActionPreference = "Stop"

$sourceRoot = Join-Path $PSScriptRoot "kit"
if (-not (Test-Path -LiteralPath $sourceRoot)) {
  throw "Kit directory not found: $sourceRoot"
}

if (-not (Test-Path -LiteralPath $TargetPath)) {
  New-Item -ItemType Directory -Force -Path $TargetPath | Out-Null
}

$targetRoot = (Resolve-Path -LiteralPath $TargetPath).Path
$sourceRoot = (Resolve-Path -LiteralPath $sourceRoot).Path.TrimEnd([System.IO.Path]::DirectorySeparatorChar)

if ([string]::IsNullOrWhiteSpace($ProjectName)) {
  $ProjectName = Split-Path -Leaf $targetRoot
}

$today = Get-Date -Format "yyyy-MM-dd"
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$created = New-Object System.Collections.Generic.List[string]
$overwritten = New-Object System.Collections.Generic.List[string]
$skipped = New-Object System.Collections.Generic.List[string]

Get-ChildItem -LiteralPath $sourceRoot -Recurse -File | ForEach-Object {
  $relative = $_.FullName.Substring($sourceRoot.Length).TrimStart(
    [System.IO.Path]::DirectorySeparatorChar,
    [System.IO.Path]::AltDirectorySeparatorChar
  )
  $destination = Join-Path $targetRoot $relative
  $destinationDirectory = Split-Path -Parent $destination

  if (-not (Test-Path -LiteralPath $destinationDirectory)) {
    New-Item -ItemType Directory -Force -Path $destinationDirectory | Out-Null
  }

  $alreadyExists = Test-Path -LiteralPath $destination
  if ($alreadyExists -and -not $Force) {
    $skipped.Add($relative)
    return
  }

  $content = [System.IO.File]::ReadAllText($_.FullName)
  $content = $content.Replace("{{PROJECT_NAME}}", $ProjectName)
  $content = $content.Replace("{{DATE}}", $today)
  [System.IO.File]::WriteAllText($destination, $content, $utf8NoBom)

  if ($alreadyExists) {
    $overwritten.Add($relative)
  } else {
    $created.Add($relative)
  }
}

Write-Host ""
Write-Host "Project continuity kit installed." -ForegroundColor Green
Write-Host "Target: $targetRoot"
Write-Host "Project name: $ProjectName"

if ($created.Count -gt 0) {
  Write-Host "Created:" -ForegroundColor Cyan
  $created | ForEach-Object { Write-Host "  + $_" }
}

if ($overwritten.Count -gt 0) {
  Write-Host "Overwritten because -Force was used:" -ForegroundColor Yellow
  $overwritten | ForEach-Object { Write-Host "  ! $_" }
}

if ($skipped.Count -gt 0) {
  Write-Host "Skipped existing files (merge them with AI; nothing was overwritten):" -ForegroundColor Yellow
  $skipped | ForEach-Object { Write-Host "  = $_" }
}

Write-Host ""
Write-Host "Next prompt:" -ForegroundColor Cyan
Write-Host "先读根目录 AGENTS.md，执行 project-bootstrap；只建立当前项目事实，不修改业务代码。"
