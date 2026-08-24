[CmdletBinding()]
param(
    [string] $ProjectPath = ".",
    [switch] $ExactSample
)

$ErrorActionPreference = "Stop"
$root = [System.IO.Path]::GetFullPath($ProjectPath)
$project = @(Get-ChildItem -LiteralPath $root -Filter "*.csproj" -File)
if ($project.Count -ne 1) { throw "Expected exactly one MAUI project in '$root'." }
$violations = [System.Collections.Generic.List[string]]::new()
$expectedExactSampleHashes = [ordered]@{
    "Components\Layout\MainLayout.razor" = "01588A5DFA354458C9E5A01204D314B7DDA74CF0CB89FA601269429E112B886C"
    "Components\Layout\MobileSidebarMenu.razor" = "DD3CA98750144D20B90615556E72009E948AA2E6D69E7C1C3A8D9D14EC705FED"
    "Components\Pages\Home.razor" = "8AF7B2D7A3DD7625ED09D8157368FA9481F62FFEA32890D6901941E8B09656A5"
    "Components\RootStartupGate.razor" = "B16425B1B88AAE60091BD24AC4877EFCE78DFDF6053F560CA4D78AE99A4AB939"
    "MauiProgram.cs" = "DB63AA10050CD8ACF5F6EB1ED5ADEBAA54E99B24A48494B6B5AB48E1DE9D49FB"
    "MainPage.xaml" = "5E0FD69C86C9A67BCA5C705E4CB1EAA632801773567E7A36A1342C496CB54108"
    "appsettings.json" = "98ED21544BFC7451A6F0D34E0BFC8EA0A89F12174B89C87E7EC8EBCDCFF2CDF8"
    "wwwroot\app.css" = "92FA657E143FAF00348F4E5CEF9CE806F5FBE1D8CB37E45863DE759194B94DDB"
}
function Require-Text([string] $path, [string[]] $tokens) {
    if (-not (Test-Path -LiteralPath $path)) { $violations.Add("Missing $path"); return }
    $text = Get-Content -LiteralPath $path -Raw
    foreach ($token in $tokens) { if (-not $text.Contains($token, [StringComparison]::Ordinal)) { $violations.Add("$path is missing '$token'.") } }
}
function Get-NormalizedTextSha256([string] $path, [string] $actualNamespace) {
    $text = (Get-Content -LiteralPath $path -Raw).Replace("`r`n", "`n").Replace("`r", "`n")
    if (-not [string]::IsNullOrWhiteSpace($actualNamespace)) {
        $canonicalNamespace = "Opx.MudBlazor.FlatUi.Maui." + "Template"
        $text = $text.Replace($actualNamespace, $canonicalNamespace, [StringComparison]::Ordinal)
    }
    $bytes = [Text.Encoding]::UTF8.GetBytes($text)
    return [Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($bytes))
}

$projectText = Get-Content -LiteralPath $project[0].FullName -Raw
$projectXml = [xml]$projectText
$rootNamespace = [string]$projectXml.Project.PropertyGroup.RootNamespace | Select-Object -First 1
if ($projectText.Contains("<ProjectReference", [StringComparison]::OrdinalIgnoreCase)) {
    $violations.Add("Opx.MudBlazor.FlatUi must remain a public NuGet PackageReference; ProjectReference is forbidden.")
}

$contractPath = Join-Path $root "flat-ui.mobile.contract.json"
$schemaPath = Join-Path $root "flat-ui.mobile.contract.schema.json"
if (-not (Test-Path -LiteralPath $contractPath) -or -not (Test-Path -LiteralPath $schemaPath)) {
    $violations.Add("Missing mobile contract or schema.")
} else {
    try {
        $contractText = Get-Content -LiteralPath $contractPath -Raw
        $schemaText = Get-Content -LiteralPath $schemaPath -Raw
        if (-not ($contractText | Test-Json -Schema $schemaText)) { $violations.Add("Mobile contract does not satisfy its schema.") }
    } catch { $violations.Add("Mobile contract schema validation failed: $($_.Exception.Message)") }
}

Require-Text $project[0].FullName @(
    'net10.0-android;net10.0-ios',
    '<MauiVersion>10.0.90</MauiVersion>',
    'CommunityToolkit.Maui" Version="15.0.1',
    'Opx.MudBlazor.FlatUi" Version="2.0.17',
    'MudBlazor" Version="9.8.0')
Require-Text (Join-Path $root "NuGet.sources.xml") @("https://api.nuget.org/v3/index.json", 'globalPackagesFolder" value=".nuget\packages')
Require-Text (Join-Path $root "run-clean.ps1") @("NuGet.sources.xml", "dotnet restore", 'foreach ($name in @("bin", "obj"))')
Require-Text (Join-Path $root "MauiProgram.cs") @("UseMauiCommunityToolkit", "MobileWebViewPolicies.Configure")
Require-Text (Join-Path $root "Platforms\Android\MobileWebViewPolicies.cs") @("BlazorWebViewMapper.AppendToMapping", "OpxNoBounce", "OverScrollMode.Never")
Require-Text (Join-Path $root "Platforms\iOS\MobileWebViewPolicies.cs") @("BlazorWebViewMapper.AppendToMapping", "OpxNoBounce", "Bounces = false", "AlwaysBounceVertical = false")
Require-Text (Join-Path $root "MainPage.xaml") @("StatusBarBehavior", "StatusBarColor", "StatusBarStyle", "OnPageNavigatedTo")
Require-Text (Join-Path $root "Platforms\iOS\Info.plist") @("UIViewControllerBasedStatusBarAppearance", "<false/>")
Require-Text (Join-Path $root "Components\RootStartupGate.razor") @("FlatSessionRestore", "ReconnectOptions.StartupTitle", '"Memuat"', "<Router", "IRootStartupGateValidator", "NotFoundPage")
Require-Text (Join-Path $root "Components\Layout\MainLayout.razor") @('BottomNavigationMaxWidthPx="900"', "Settings", "FlatDisplaySettings", "logout-action")
Require-Text (Join-Path $root "wwwroot\index.html") @("<!-- Powered by opx (github.com/opxw) -->", "flat-system-loading-spinner", "_content/Opx.MudBlazor.FlatUi/opx-flat-ui.css", "_framework/blazor.webview.js")
Require-Text (Join-Path $root "wwwroot\app.css") @("overscroll-behavior:none", "user-select:none", 'input:not([type="button"]', "user-select:text")
Require-Text (Join-Path $root "appsettings.json") @('"HostKind": "MauiHybrid"', '"DefaultThemeMode": "Light"', '"DefaultNavigationLayout": "Bottom"', '"UseAppFontSize": false')

$indexText = Get-Content -LiteralPath (Join-Path $root "wwwroot\index.html") -Raw
if ([regex]::Matches($indexText, '<!-- Powered by opx \(github\.com/opxw\) -->').Count -ne 1) { $violations.Add("Runtime HTML must contain exactly one OPX attribution comment.") }
$appCss = Get-Content -LiteralPath (Join-Path $root "wwwroot\app.css") -Raw
if ($appCss.Contains(".flat-", [StringComparison]::OrdinalIgnoreCase)) { $violations.Add("Host app.css may not override package-owned .flat-* selectors.") }

$localPackageCss = @(Get-ChildItem -LiteralPath $root -Recurse -File -Filter "opx-flat-ui.css" | Where-Object FullName -NotMatch '[\\/](bin|obj|\.nuget)[\\/]')
if ($localPackageCss.Count -gt 0) { $violations.Add("Reusable OPX CSS must come only from the NuGet static web asset.") }

$assetsPath = Join-Path $root "obj\project.assets.json"
if (Test-Path -LiteralPath $assetsPath) {
    try {
        $assets = Get-Content -LiteralPath $assetsPath -Raw | ConvertFrom-Json -AsHashtable
        $packageRoot = @($assets.packageFolders.Keys)[0]
        $packageCss = Join-Path $packageRoot "opx.mudblazor.flatui\2.0.17\staticwebassets\opx-flat-ui.css"
        if (-not (Test-Path -LiteralPath $packageCss)) { $violations.Add("Restored OPX package CSS was not found.") }
        elseif ((Get-FileHash -LiteralPath $packageCss -Algorithm SHA256).Hash -ne "57EE747876F19F0F082B2249E4562F82B45A101AA50F65D8681C7082B1E9E165") { $violations.Add("Restored OPX 2.0.17 CSS hash does not match the contract.") }
    } catch { $violations.Add("Unable to verify restored OPX CSS: $($_.Exception.Message)") }
} else { $violations.Add("Run restore before the mobile consumer audit; obj/project.assets.json is missing.") }

if ($ExactSample) {
    foreach ($entry in $expectedExactSampleHashes.GetEnumerator()) {
        $path = Join-Path $root $entry.Key
        if (-not (Test-Path -LiteralPath $path)) {
            $violations.Add("Exact Sample Mode: missing canonical file '$($entry.Key)'.")
            continue
        }
        if ((Get-NormalizedTextSha256 $path $rootNamespace) -cne $entry.Value) {
            $violations.Add("Exact Sample Mode: '$($entry.Key)' has integration drift from the canonical MAUI template.")
        }
    }
}

if ($violations.Count -gt 0) { $violations | ForEach-Object { Write-Error $_ }; exit 1 }
Write-Output "OPX Flat UI MAUI consumer audit passed for '$($project[0].FullName)' (contract 2.0.17$(if ($ExactSample) { ', Exact Sample Mode' }))."
