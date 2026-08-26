[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"
$mauiRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot ".."))
$samplesRoot = [IO.Path]::GetFullPath((Join-Path $mauiRoot ".."))
$webRoot = Join-Path $samplesRoot "Opx.MudBlazor.FlatUi.Sample"

if (-not (Test-Path -LiteralPath (Join-Path $webRoot "Components\Pages\Home.razor"))) {
    throw "Canonical Web sample was not found at '$webRoot'."
}

$pageTarget = Join-Path $mauiRoot "Components\Pages"
Get-ChildItem -LiteralPath (Join-Path $webRoot "Components\Pages") -File |
    Where-Object Name -ne "Error.razor" |
    ForEach-Object { Copy-Item -LiteralPath $_.FullName -Destination (Join-Path $pageTarget $_.Name) -Force }

foreach ($name in @("ChartCode.razor", "SamplePageUsage.razor")) {
    Copy-Item -LiteralPath (Join-Path $webRoot "Components\$name") -Destination (Join-Path $mauiRoot "Components\$name") -Force
}

foreach ($name in @("AuthLayout.razor", "WebsiteLayout.razor")) {
    $target = Join-Path $mauiRoot "Components\Layout\$name"
    Copy-Item -LiteralPath (Join-Path $webRoot "Components\Layout\$name") -Destination $target -Force
    $text = (Get-Content -LiteralPath $target -Raw).Replace(
        "An unhandled error has occurred.",
        "Aplikasi mengalami kesalahan.").Replace(
        '<a href="." class="reload">Reload</a>',
        '<a href="." class="reload">Muat ulang</a>').Replace(
        '<span class="dismiss">x</span>',
        '<span class="dismiss" aria-label="Tutup">×</span>')
    [IO.File]::WriteAllText($target, $text, [Text.UTF8Encoding]::new($false))
}

foreach ($name in @("SampleCatalog.cs", "ErpSampleCatalog.cs")) {
    $source = Join-Path $webRoot "Services\$name"
    $target = Join-Path $mauiRoot "Services\$name"
    $text = (Get-Content -LiteralPath $source -Raw).Replace(
        "namespace Opx.MudBlazor.FlatUi.Sample.Services;",
        "namespace Opx.MudBlazor.FlatUi.MauiHost.Sample.Services;")
    [IO.File]::WriteAllText($target, $text, [Text.UTF8Encoding]::new($false))
}

$spatial = Join-Path $pageTarget "SpatialWorkItem.cs"
$spatialText = (Get-Content -LiteralPath $spatial -Raw).Replace(
    "namespace Opx.MudBlazor.FlatUi.Sample.Components.Pages;",
    "namespace Opx.MudBlazor.FlatUi.MauiHost.Sample.Components.Pages;")
[IO.File]::WriteAllText($spatial, $spatialText, [Text.UTF8Encoding]::new($false))

Copy-Item -LiteralPath (Join-Path $webRoot "wwwroot\app.css") -Destination (Join-Path $mauiRoot "wwwroot\sample-content.css") -Force
foreach ($name in @("sample-job-hero.svg", "sample-product-shirt.svg", "sample-profile.svg")) {
    Copy-Item -LiteralPath (Join-Path $webRoot "wwwroot\$name") -Destination (Join-Path $mauiRoot "wwwroot\$name") -Force
}

Write-Output "Canonical Web page content synchronized into '$mauiRoot'."
