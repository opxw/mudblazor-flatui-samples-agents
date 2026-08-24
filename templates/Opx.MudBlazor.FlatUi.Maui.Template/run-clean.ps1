[CmdletBinding()]
param([switch] $PrepareOnly)

$ErrorActionPreference = "Stop"
$projectRoot = [System.IO.Path]::GetFullPath($PSScriptRoot)
$project = @(Get-ChildItem -LiteralPath $projectRoot -Filter "*.csproj" -File)
if ($project.Count -ne 1) { throw "Expected exactly one project in '$projectRoot'." }

foreach ($name in @("bin", "obj")) {
    $target = [System.IO.Path]::GetFullPath((Join-Path $projectRoot $name))
    if ([System.IO.Path]::GetDirectoryName($target) -cne $projectRoot) { throw "Unsafe clean target '$target'." }
    if (Test-Path -LiteralPath $target) { [System.IO.Directory]::Delete($target, $true) }
}

dotnet restore $project[0].FullName --configfile (Join-Path $projectRoot "NuGet.sources.xml")
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
if ($PrepareOnly) { Write-Output "MAUI initial-run preparation completed."; exit 0 }

dotnet build $project[0].FullName -f net10.0-android -c Debug --no-restore
exit $LASTEXITCODE
