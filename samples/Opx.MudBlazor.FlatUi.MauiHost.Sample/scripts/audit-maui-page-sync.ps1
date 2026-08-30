# Copyright (c) 2026 opx. All rights reserved.

[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"
$mauiRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot ".."))
$samplesRoot = [IO.Path]::GetFullPath((Join-Path $mauiRoot ".."))
$showcaseRoot = Join-Path $samplesRoot "Opx.MudBlazor.FlatUi.Showcase"
$violations = [Collections.Generic.List[string]]::new()

function Require-Tokens([string] $relativePath, [string[]] $tokens) {
    $path = Join-Path $mauiRoot $relativePath
    if (-not (Test-Path -LiteralPath $path)) {
        $violations.Add("Missing '$relativePath'.")
        return
    }
    $text = Get-Content -LiteralPath $path -Raw
    foreach ($token in $tokens) {
        if (-not $text.Contains($token, [StringComparison]::Ordinal)) {
            $violations.Add("'$relativePath' is missing '$token'.")
        }
    }
}

if (-not (Test-Path -LiteralPath (Join-Path $showcaseRoot "Opx.MudBlazor.FlatUi.Showcase.csproj"))) {
    $violations.Add("Shared Showcase project is missing.")
}

Require-Tokens "Opx.MudBlazor.FlatUi.MauiHost.Sample.csproj" @(
    'PackageReference Include="Opx.MudBlazor.FlatUi" Version="2.1.6"',
    'ProjectReference Include="..\Opx.MudBlazor.FlatUi.Showcase\Opx.MudBlazor.FlatUi.Showcase.csproj"',
    'MauiSplashScreen Include="Resources\Splash\splash.svg" Color="#FFFFFF" BaseSize="1,1"'
)
Require-Tokens "Components\Routes.razor" @(
    'AdditionalAssemblies="SharedAssemblies"',
    'typeof(ShowcaseAssemblyMarker).Assembly'
)
Require-Tokens "Components\Layout\MainLayout.razor" @(
    'ShowcaseNavigationCatalog.NavigationItems',
    'new("MAUI Host", "/maui-host"',
    'new("MAUI Performance", "/maui-performance"'
)
Require-Tokens "Components\RootStartupGate.razor" @(
    '<FlatMudProviders',
    '<FlatSessionRestore',
    '<Routes />',
    'MauiPerformanceTracker'
)
Require-Tokens "wwwroot\index.html" @(
    'data-opx-theme-mode="light"',
    'class="opx-maui-static-loading"',
    '>Memuat<',
    '_content/Opx.MudBlazor.FlatUi.Showcase/opx-flat-ui-showcase.css'
)
Require-Tokens "appsettings.json" @(
    '"DefaultThemeMode": "Light"',
    '"StartupTitle": "Memuat halaman"',
    '"StartupMessage": "Menyiapkan aplikasi..."'
)
Require-Tokens "Platforms\Android\AndroidManifest.xml" @(
    'android.permission.ACCESS_NETWORK_STATE',
    'android.permission.POST_NOTIFICATIONS'
)
Require-Tokens "Resources\Splash\splash.svg" @(
    'viewBox="0 0 1 1"',
    'fill="#FFFFFF"'
)
Require-Tokens "Services\MauiHybridDeviceAdapter.cs" @(
    'Connectivity.Current.NetworkAccess',
    'HybridCapabilityResult Unsupported'
)
Require-Tokens "run-clean.ps1" @(
    'foreach ($name in @("bin", "obj"))',
    'audit-maui-page-sync.ps1',
    'dotnet @restore'
)

$projectText = Get-Content -LiteralPath (Join-Path $mauiRoot "Opx.MudBlazor.FlatUi.MauiHost.Sample.csproj") -Raw
if ($projectText -match '<ProjectReference[^>]+src[\/]Opx\.MudBlazor\.FlatUi') {
    $violations.Add("Reusable OPX UI must come from NuGet; package-source ProjectReference is forbidden.")
}

$showcaseRoutes = Get-ChildItem -LiteralPath (Join-Path $showcaseRoot "Components\Pages") -Filter "*.razor" -File |
    ForEach-Object { [regex]::Matches((Get-Content -LiteralPath $_.FullName -Raw), '@page\s+"([^"]+)"') } |
    ForEach-Object { $_.Groups[1].Value } |
    Sort-Object -Unique
$hostRoutes = Get-ChildItem -LiteralPath (Join-Path $mauiRoot "Components\Pages") -Filter "*.razor" -File |
    ForEach-Object { [regex]::Matches((Get-Content -LiteralPath $_.FullName -Raw), '@page\s+"([^"]+)"') } |
    ForEach-Object { $_.Groups[1].Value } |
    Sort-Object -Unique

$overlap = @($hostRoutes | Where-Object { $_ -in $showcaseRoutes })
foreach ($route in $overlap) {
    $violations.Add("Host route '$route' duplicates the shared Showcase route.")
}
foreach ($route in @("/maui-host", "/maui-performance", "/native-adapters", "/compatibility")) {
    if ($route -notin $hostRoutes) {
        $violations.Add("Required MAUI-only route '$route' is missing.")
    }
}

$repositoryRoot = [IO.Path]::GetFullPath((Join-Path $samplesRoot ".."))
$registryPath = Join-Path $repositoryRoot ".agents\skills\opx-flat-ui-development\references\page-registry.md"
$registryMatches = [regex]::Matches(
    (Get-Content -LiteralPath $registryPath -Raw),
    '(?m)^\| `(?<id>opx\.page\.[^`]+)` \|.*?\| `(?<route>/[^`]*)` \|')
$registryIds = @($registryMatches | ForEach-Object { $_.Groups['id'].Value })
$registryRoutes = @($registryMatches | ForEach-Object { $_.Groups['route'].Value })
foreach ($duplicate in @($registryIds | Group-Object | Where-Object Count -gt 1)) {
    $violations.Add("PageId registry contains duplicate ID '$($duplicate.Name)'.")
}
foreach ($duplicate in @($registryRoutes | Group-Object | Where-Object Count -gt 1)) {
    $violations.Add("PageId registry contains duplicate route '$($duplicate.Name)'.")
}
foreach ($route in @($showcaseRoutes) + @($hostRoutes)) {
    if ($route -notin $registryRoutes) {
        $violations.Add("Declared route '$route' has no canonical PageId.")
    }
}

if ($violations.Count -gt 0) {
    $violations | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Output "MAUI shared-page audit passed: $($showcaseRoutes.Count) Showcase routes load once; $($hostRoutes.Count) MAUI-only routes remain in the host; OPX UI uses NuGet 2.1.6."
