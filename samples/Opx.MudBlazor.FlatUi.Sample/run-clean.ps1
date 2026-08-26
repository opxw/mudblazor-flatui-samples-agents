# Copyright (c) 2026 opx. All rights reserved.

[CmdletBinding()]
param(
    [switch] $PrepareOnly
)

$ErrorActionPreference = "Stop"

$projectRoot = [System.IO.Path]::GetFullPath($PSScriptRoot).TrimEnd([System.IO.Path]::DirectorySeparatorChar)
$projects = @(Get-ChildItem -LiteralPath $projectRoot -Filter "*.csproj" -File)
if ($projects.Count -ne 1) {
    throw "Expected exactly one project file in '$projectRoot', found $($projects.Count)."
}

$cleanRoots = [System.Collections.Generic.List[string]]::new()
$cleanRoots.Add($projectRoot)
$showcaseRoot = [System.IO.Path]::GetFullPath((Join-Path $projectRoot "..\Opx.MudBlazor.FlatUi.Showcase"))
if (Test-Path -LiteralPath (Join-Path $showcaseRoot "Opx.MudBlazor.FlatUi.Showcase.csproj")) {
    $cleanRoots.Add($showcaseRoot)
}

foreach ($cleanRoot in $cleanRoots) {
    foreach ($directoryName in @("bin", "obj")) {
        $target = [System.IO.Path]::GetFullPath((Join-Path $cleanRoot $directoryName))
        $expected = "$cleanRoot$([System.IO.Path]::DirectorySeparatorChar)$directoryName"
        if (-not $target.Equals($expected, [System.StringComparison]::OrdinalIgnoreCase)) {
            throw "Refusing to clean unexpected path '$target'."
        }

        if ([System.IO.Directory]::Exists($target)) {
            [System.IO.Directory]::Delete($target, $true)
        }
    }
}

Write-Output "Cleaned exact host and shared Showcase bin/obj directories."
$nugetConfig = $null
$candidateDirectory = [System.IO.DirectoryInfo]::new($projectRoot)
while ($null -ne $candidateDirectory -and $null -eq $nugetConfig) {
    $candidateConfig = Join-Path $candidateDirectory.FullName "NuGet.Config"
    if (Test-Path -LiteralPath $candidateConfig) {
        $nugetConfig = $candidateConfig
    }
    $candidateDirectory = $candidateDirectory.Parent
}
if ($null -eq $nugetConfig) {
    throw "NuGet.Config was not found in the project directory or its parents."
}

dotnet restore $projects[0].FullName --configfile $nugetConfig
if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

if ($PrepareOnly) {
    Write-Output "Initial-run preparation completed without launching the application."
    exit 0
}

dotnet run --project $projects[0].FullName --no-restore
exit $LASTEXITCODE
