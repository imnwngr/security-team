[CmdletBinding()]
param()
$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$skillRoot = Join-Path $root 'skills/security-team'
$text = Get-Content -LiteralPath (Join-Path $skillRoot 'SKILL.md') -Raw
if ($text -notmatch '(?s)^---\r?\nname: security-team\r?\ndescription: [^\r\n]+\r?\n---') {
    throw 'Required skill frontmatter is invalid.'
}
$linkCount = 0
$htmlLinkCount = 0
foreach ($file in (Get-ChildItem -LiteralPath $root -Recurse -File -Filter '*.md' |
    Where-Object FullName -NotMatch '[\\/](\.git|local-test|toolkit|node_modules|\.venv)[\\/]')) {
    $content = Get-Content -LiteralPath $file.FullName -Raw
    foreach ($match in [regex]::Matches($content, '\]\(([^)]+)\)')) {
        $target = $match.Groups[1].Value
        if ($target -match '^https?://|^#') { continue }
        $target = ($target -split '#')[0]
        if (-not (Test-Path -LiteralPath (Join-Path $file.DirectoryName $target))) {
            throw "Broken link in $($file.Name): $target"
        }
        $linkCount++
    }
    foreach ($match in [regex]::Matches($content, '(?:src|href)\s*=\s*"([^"]+)"')) {
        $target = $match.Groups[1].Value
        if ($target -match '^(https?://|data:|mailto:|#)') { continue }
        $target = ($target -split '#')[0]
        if (-not (Test-Path -LiteralPath (Join-Path $file.DirectoryName $target))) {
            throw "Broken HTML asset/link in $($file.Name): $target"
        }
        $htmlLinkCount++
    }
}
$images = @('hero.svg', 'pipeline-overview.svg')
foreach ($name in $images) {
    $path = Join-Path $root "docs/images/$name"
    if (-not (Test-Path -LiteralPath $path)) { throw "Missing diagram: $path" }
    try { $svg = [xml](Get-Content -LiteralPath $path -Raw) }
    catch { throw "Invalid diagram XML: $($name): $($_.Exception.Message)" }
    if ($svg.DocumentElement.LocalName -ne 'svg') { throw "Invalid SVG root: $name" }
}
$catalog = Get-Content -LiteralPath (Join-Path $skillRoot 'references/catalog.md') -Raw
$repoCount = [regex]::Matches($catalog, '\| \[[^\]]+\]\(https://github.com/').Count
if ($repoCount -ne 11) { throw "Expected 11 catalog repos; found $repoCount" }
foreach ($file in (Get-ChildItem -LiteralPath $PSScriptRoot -Filter '*.ps1')) {
    $tokens = $null
    $parseErrors = $null
    [void][Management.Automation.Language.Parser]::ParseFile($file.FullName, [ref]$tokens, [ref]$parseErrors)
    if ($parseErrors.Count -gt 0) { throw "Invalid PowerShell: $($file.Name): $parseErrors" }
}
$metadata = Get-Content -LiteralPath (Join-Path $skillRoot 'agents/openai.yaml') -Raw
if (-not $metadata.Contains('$security-team')) { throw 'Missing skill invocation metadata.' }
Write-Output "PASS: frontmatter, $linkCount Markdown links, $htmlLinkCount HTML assets/links, $($images.Count) SVGs, 11 catalog entries, PowerShell syntax and invocation metadata."
Write-Output 'This structural check is not a YAML schema validator or an end-to-end security audit.'
