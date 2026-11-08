<#
Compatibility entry point for the common Bash tag command.
Requires Bash (Git Bash on Windows, or the repository's WSL shell).
Use -Yes to skip the normal confirmation, -Force to replace an existing tag,
and -DryRun to preview without changing or pushing anything.
#>
[CmdletBinding()]
param(
    [switch]$Yes,
    [switch]$Force,
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'
$script = Join-Path $PSScriptRoot 'tag-latest-version.sh'
$bash = $null

# Prefer Git Bash to Windows' legacy bash.exe WSL launcher. Git Bash accepts
# this Windows checkout path and delegates all release logic to the same script.
if ($env:OS -eq 'Windows_NT') {
    $candidates = @()
    foreach ($base in @($env:ProgramFiles, ${env:ProgramFiles(x86)}, $env:LOCALAPPDATA)) {
        if ($base) { $candidates += (Join-Path $base 'Git\bin\bash.exe') }
    }
    $git = Get-Command git.exe -ErrorAction SilentlyContinue
    if ($git) {
        $gitRoot = Split-Path (Split-Path $git.Source -Parent) -Parent
        $candidates += (Join-Path $gitRoot 'bin\bash.exe')
    }
    $bash = $candidates | Where-Object { Test-Path -LiteralPath $_ -PathType Leaf } | Select-Object -First 1
} else {
    $command = Get-Command bash -ErrorAction SilentlyContinue
    if ($command) { $bash = $command.Source }
}

if (-not $bash) {
    throw 'Bash is required. Install Git Bash on Windows, or run .scripts/tag-latest-version.sh directly from WSL.'
}

$arguments = @($script.Replace('\', '/'))
if ($Yes) { $arguments += '--yes' }
if ($Force) { $arguments += '--force' }
if ($DryRun) { $arguments += '--dry-run' }
& $bash @arguments
exit $LASTEXITCODE
