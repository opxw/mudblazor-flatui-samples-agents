[CmdletBinding()]
param(
    [ValidateSet("Android", "Windows")]
    [string] $Target = "Android",
    [switch] $PrepareOnly
)

$ErrorActionPreference = "Stop"
$projectRoot = [IO.Path]::GetFullPath($PSScriptRoot)
$project = @(Get-ChildItem -LiteralPath $projectRoot -Filter "*.csproj" -File)
if ($project.Count -ne 1) { throw "Expected exactly one project in '$projectRoot'." }

foreach ($name in @("bin", "obj")) {
    $path = [IO.Path]::GetFullPath((Join-Path $projectRoot $name))
    if ([IO.Path]::GetDirectoryName($path) -cne $projectRoot) { throw "Unsafe clean target '$path'." }
    if ([IO.Directory]::Exists($path)) { [IO.Directory]::Delete($path, $true) }
}

& (Join-Path $projectRoot "scripts\audit-maui-page-sync.ps1")
if (-not $?) { exit 1 }

$config = [IO.Path]::GetFullPath((Join-Path $projectRoot "..\..\NuGet.Config"))
$framework = if ($Target -eq "Windows") { "net10.0-windows10.0.19041.0" } else { "net10.0-android" }
$restore = @("restore", $project[0].FullName, "-p:TargetFramework=$framework", "--configfile", $config)
if ($Target -eq "Windows") { $restore += @("-r", "win-x64") }
dotnet @restore
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
if ($PrepareOnly) { Write-Output "MAUIHost initial-run preparation completed for $Target."; exit 0 }

$build = @("build", $project[0].FullName, "-f", $framework, "-c", "Debug", "--no-restore")
if ($Target -eq "Windows") { $build += @("-r", "win-x64") }
dotnet @build
exit $LASTEXITCODE
