[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$Destination = (Join-Path ([Environment]::GetFolderPath('UserProfile')) '.agents/skills/security-team')
)
$ErrorActionPreference = 'Stop'
$source = Join-Path $PSScriptRoot '../skills/security-team'
if (-not (Test-Path -LiteralPath (Join-Path $source 'SKILL.md'))) {
    throw 'Skill source is missing.'
}
$target = [IO.Path]::GetFullPath($Destination)
if (Test-Path -LiteralPath $target) {
    throw "Destination already exists; inspect and back it up before updating: $target"
}
if ($PSCmdlet.ShouldProcess($target, 'Copy security-team skill; no hooks or dependencies')) {
    $parent = Split-Path -Parent $target
    New-Item -ItemType Directory -Path $parent -Force | Out-Null
    Copy-Item -LiteralPath $source -Destination $target -Recurse
    Write-Output "Installed: $target"
}
