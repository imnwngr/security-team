[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$Destination = (Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'Security-Toolkit')
)
$ErrorActionPreference = 'Stop'
$repos = @(
    'kenryu42/cc-safety-net', 'GoPlusSecurity/agentguard',
    'agamm/claude-code-owasp', 'tanviet12/vbsec', 'ghostsecurity/skills',
    'cloudflare/security-audit-skill', 'trailofbits/skills', 'AgriciDaniel/pya',
    'codexstar69/bug-hunter', 'anthropics/defending-code-reference-harness',
    'ptn1411/skill'
)
if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw 'Git is required.' }
$root = [IO.Path]::GetFullPath($Destination)
if (-not $PSCmdlet.ShouldProcess($root, 'Clone 11 repositories and write a revision manifest; no installs')) { return }
New-Item -ItemType Directory -Path $root -Force | Out-Null
$manifestPath = Join-Path $root ('toolkit-manifest-' + [guid]::NewGuid().ToString('N') + '.json')
$records = @()
foreach ($repo in $repos) {
    $path = Join-Path $root $repo.Replace('/', '__')
    $record = [ordered]@{
        repository = $repo; path = $path; status = 'pending'
        commit = $null; error = $null; recorded_at = [DateTimeOffset]::UtcNow.ToString('o')
    }
    if (Test-Path -LiteralPath $path) {
        $record.status = 'existing_unverified'
    } else {
        try {
            git clone --recurse-submodules "https://github.com/$repo.git" $path
            if ($LASTEXITCODE -ne 0) { throw "git clone exited $LASTEXITCODE" }
            $commit = git -C $path rev-parse HEAD
            if ($LASTEXITCODE -ne 0) { throw 'Unable to read clone revision.' }
            $record.commit = "$commit".Trim()
            $record.status = 'cloned'
        } catch {
            $record.status = 'failed'
            $record.error = $_.Exception.Message
            Write-Warning "${repo}: $($record.error)"
        }
    }
    $records += [pscustomobject]$record
    ConvertTo-Json -InputObject $records -Depth 4 | Set-Content -LiteralPath $manifestPath -Encoding UTF8
}
$records | Select-Object repository,status,commit | Format-Table -AutoSize
Write-Output "Manifest: $manifestPath"
if (@($records | Where-Object status -eq 'failed').Count -gt 0) {
    throw 'Some clones failed. Inspect the manifest; existing and partial directories were not modified or deleted.'
}
