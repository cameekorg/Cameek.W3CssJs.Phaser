# Powershell script to tag git with version from csproj, from any location

$ErrorActionPreference = "Stop"

# Find script and repo root regardless of current directory
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$repoRoot = Resolve-Path "$scriptDir\.."
$csprojPath = Join-Path $repoRoot "Cameek.W3CssJs.Phaser\Cameek.W3CssJs.Phaser.csproj"

# Go to repo root for git commands
Set-Location $repoRoot

# Parse version from .csproj
[xml]$projXml = Get-Content $csprojPath
$version = $projXml.Project.PropertyGroup.Version

if ([string]::IsNullOrWhiteSpace($version)) {
    Write-Error "Version not found in $csprojPath!"
    exit 1
}

$tagName = "v$version"

# Check if tag exists
$existingTag = git tag --list "$tagName"
if ($existingTag) {
    Write-Warning "Tag $tagName already exists."
    $confirm = Read-Host "Overwrite (delete and re-create) and push? (y/n)"
    if ($confirm -ne "y") {
        Write-Host "Aborted."
        exit 1
    }
    git tag -d $tagName
    git push origin :refs/tags/$tagName
}

# Confirm before tagging (optional)
Write-Host "About to create and push tag: $tagName"
$confirm = Read-Host "Proceed? (y/n)"
if ($confirm -ne "y") {
    Write-Host "Aborted."
    exit 1
}

# Create and push tag
git tag $tagName
git push origin "refs/tags/$tagName"

Write-Host "Tag $tagName created and pushed from project version $version."
