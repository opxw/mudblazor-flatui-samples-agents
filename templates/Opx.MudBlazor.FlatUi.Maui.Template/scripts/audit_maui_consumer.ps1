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
    "Components\_Imports.razor" = "22BA9D3C78BF7BD40A1C8B5460E27B9226908CAF769D508D899222A56FD570B3"
    "Components\Layout\MainLayout.razor" = "BDD9FFF00DF7AA7ED01F3C8D11637568A542F9DFCA74F48BBBDFF3AA5C81C5A3"
    "Components\Layout\MobileSidebarMenu.razor" = "DD3CA98750144D20B90615556E72009E948AA2E6D69E7C1C3A8D9D14EC705FED"
    "Components\Pages\Home.razor" = "8AF7B2D7A3DD7625ED09D8157368FA9481F62FFEA32890D6901941E8B09656A5"
    "Components\RootStartupGate.razor" = "B16425B1B88AAE60091BD24AC4877EFCE78DFDF6053F560CA4D78AE99A4AB939"
    "MauiProgram.cs" = "DB63AA10050CD8ACF5F6EB1ED5ADEBAA54E99B24A48494B6B5AB48E1DE9D49FB"
    "MainPage.xaml" = "5E0FD69C86C9A67BCA5C705E4CB1EAA632801773567E7A36A1342C496CB54108"
    "Platforms\Android\AndroidManifest.xml" = "99473DD217AFF65C62A3198157E794674190858388530E0E3C074FEF63227F56"
    "Resources\Splash\splash.svg" = "2CE5A083499E8A1FB0CD3E81FC6D029563B821C8B63960552F8593A35600821F"
    "appsettings.json" = "563FFB0C899179C76612420CFF9035F1AE418418E64A89C580A2BD3BD8A241D5"
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
    'Opx.MudBlazor.FlatUi" Version="2.1.34',
    'MudBlazor" Version="9.10.0',
    'MauiSplashScreen Include="Resources\Splash\splash.svg" Color="#FFFFFF" BaseSize="1,1"')
Require-Text (Join-Path $root "NuGet.sources.xml") @("https://api.nuget.org/v3/index.json", 'globalPackagesFolder" value=".nuget\packages')
Require-Text (Join-Path $root "run-clean.ps1") @("NuGet.sources.xml", "dotnet restore", 'foreach ($name in @("bin", "obj"))')
Require-Text (Join-Path $root "MauiProgram.cs") @("UseMauiCommunityToolkit", "MobileWebViewPolicies.Configure")
Require-Text (Join-Path $root "Platforms\Android\MobileWebViewPolicies.cs") @("BlazorWebViewMapper.AppendToMapping", "OpxNoBounce", "OverScrollMode.Never")
Require-Text (Join-Path $root "Platforms\Android\AndroidManifest.xml") @("android.permission.INTERNET", "android.permission.ACCESS_NETWORK_STATE", "android.permission.POST_NOTIFICATIONS")
Require-Text (Join-Path $root "Platforms\iOS\MobileWebViewPolicies.cs") @("BlazorWebViewMapper.AppendToMapping", "OpxNoBounce", "Bounces = false", "AlwaysBounceVertical = false")
Require-Text (Join-Path $root "MainPage.xaml") @("StatusBarBehavior", "StatusBarColor", "StatusBarStyle", "OnPageNavigatedTo")
Require-Text (Join-Path $root "MainPage.xaml.cs") @("TryHandleModalBackAsync", "opxFlatModalHistory.tryHandleBack", "TryHandleBlazorBackAsync", "CanGoBack", "GoBack")
Require-Text (Join-Path $root "Platforms\Android\MainActivity.cs") @("OnBackPressedDispatcher", "TryHandleModalBackAsync", "TryHandleBlazorBackAsync", "Enabled = false")
Require-Text (Join-Path $root "Platforms\iOS\Info.plist") @("UIViewControllerBasedStatusBarAppearance", "<false/>")
Require-Text (Join-Path $root "Components\RootStartupGate.razor") @("FlatSessionRestore", "ReconnectOptions.StartupTitle", '"Memuat"', "<Router", "IRootStartupGateValidator", "NotFoundPage")
Require-Text (Join-Path $root "Components\_Imports.razor") @("@using global::Opx.MudBlazor.FlatUi.Components", "@using global::Opx.MudBlazor.FlatUi.Models", "@using global::Opx.MudBlazor.FlatUi.Services")
Require-Text (Join-Path $root "Components\Layout\MainLayout.razor") @('BottomNavigationMaxWidthPx="900"', 'SearchVisible="@Preferences.Options.AppBarSearchVisible"', "Settings", "FlatDisplaySettings", "logout-action")
Require-Text (Join-Path $root "wwwroot\index.html") @("<!-- Powered by opx (github.com/opxw) -->", "flat-system-loading-spinner", "_content/Opx.MudBlazor.FlatUi/opx-flat-ui.css", "_framework/blazor.webview.js", 'data-opx-use-app-font-size="false"', 'data-opx-font-size="16"', 'data-opx-minimum-font-size="12"', 'data-opx-maximum-font-size="18"', 'data-opx-density="Default"')
Require-Text (Join-Path $root "wwwroot\app.css") @("overscroll-behavior:none", "user-select:none", 'input:not([type="button"]', "user-select:text")
Require-Text (Join-Path $root "appsettings.json") @('"AppBarSearchVisible": true', '"PanelHeaderMinHeight": 48', '"PanelHeaderPaddingY": 10', '"HostKind": "MauiHybrid"', '"DefaultThemeMode": "Light"', '"DefaultNavigationLayout": "Bottom"', '"DefaultBottomNavigationChildPresentation": "Sheet"', '"UseAppFontSize": false', '"DefaultRoundedSizePx": 7', '"DefaultColorPalette": "fluent-blue"', '"DefaultDensity": "Default"')
Require-Text (Join-Path $root ".agents\KNOWLEDGE.md") @("UseAppFontSize=false", "system UI font stack", "does not replace the system font family", "Bottom navigation requests default", 'DefaultBottomNavigationChildPresentation="Sheet"', '`MainView` is opt-in only', "MobileToolbarActionsExpandedByDefault", 'defaults to `false`', "collapsed/hidden", "Back behavior is layered and Blazor-first", "next Back navigates through prior Blazor WebView history", "native Back/app exit only when", "Package-first reuse is mandatory", "never duplicate package behavior", "Package changes and publication require explicit approval", "FlatMobileGrid", "article.mobile-card", 'bare manual `div.mobile-grid-list`', "consumer integration defect")
Require-Text (Join-Path $root ".agents\PROMPTING.md") @("UseAppFontSize=false", "system font", "no custom app font", "bottom navigation", 'DefaultBottomNavigationChildPresentation="Sheet"', 'Select `MainView` only when the user explicitly', "search/filter text visible", "MobileToolbarActionsExpandedByDefault=false", "collapsed/hidden", "modal first", "previous Blazor page second", "native app exit only at the true navigation root", "supported NuGet public API", "do not silently build a substitute", "domain-neutral package suggestion", "host-owned domain/integration/native seam", "FlatMobileGrid", "article.mobile-card", 'Never improvise a bare `div.mobile-grid-list`')

$indexText = Get-Content -LiteralPath (Join-Path $root "wwwroot\index.html") -Raw
if ([regex]::Matches($indexText, '<!-- Powered by opx \(github\.com/opxw\) -->').Count -ne 1) { $violations.Add("Runtime HTML must contain exactly one OPX attribution comment.") }
$appCss = Get-Content -LiteralPath (Join-Path $root "wwwroot\app.css") -Raw
if ($appCss.Contains(".flat-", [StringComparison]::OrdinalIgnoreCase)) { $violations.Add("Host app.css may not override package-owned .flat-* selectors.") }
if ($appCss.Contains(".mud-", [StringComparison]::OrdinalIgnoreCase)) { $violations.Add("Host app.css may not override MudBlazor .mud-* selectors.") }
if ($appCss -match "(?im)--opx-[a-z0-9-]+\s*:") { $violations.Add("Host app.css may consume but may not redeclare package-owned --opx-* tokens.") }

$destinationCssFiles = @(Get-ChildItem -LiteralPath $root -Recurse -File -Filter "*.css" | Where-Object FullName -NotMatch '[/\\](bin|obj|[.]nuget)[/\\]')
foreach ($cssFile in $destinationCssFiles) {
    $cssSource = Get-Content -LiteralPath $cssFile.FullName -Raw
    if ($cssSource -match "(?i)\.(flat|mud)-") { $violations.Add("Destination stylesheet '$($cssFile.FullName)' may not target package-owned .flat-* or .mud-* selectors.") }
    if ($cssSource -match "(?im)--opx-[a-z0-9-]+\s*:") { $violations.Add("Destination stylesheet '$($cssFile.FullName)' may consume but may not redeclare package-owned --opx-* tokens.") }
}

$localPackageCss = @(Get-ChildItem -LiteralPath $root -Recurse -File -Filter "opx-flat-ui.css" | Where-Object FullName -NotMatch '[\\/](bin|obj|\.nuget)[\\/]')
if ($localPackageCss.Count -gt 0) { $violations.Add("Reusable OPX CSS must come only from the NuGet static web asset.") }

$assetsPath = Join-Path $root "obj\project.assets.json"
if (Test-Path -LiteralPath $assetsPath) {
    try {
        $assets = Get-Content -LiteralPath $assetsPath -Raw | ConvertFrom-Json -AsHashtable
        $packageRoot = @($assets.packageFolders.Keys)[0]
        $packageCss = Join-Path $packageRoot "opx.mudblazor.flatui\2.1.34\staticwebassets\opx-flat-ui.css"
        if (-not (Test-Path -LiteralPath $packageCss)) { $violations.Add("Restored OPX package CSS was not found.") }
        elseif ((Get-FileHash -LiteralPath $packageCss -Algorithm SHA256).Hash -ne "EE8519C20EF637D586C2F6254B7DB8C79F18AF6D52590998571786ED72D8A9B1") { $violations.Add("Restored OPX 2.1.34 CSS hash does not match the contract.") }
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
Write-Output "OPX Flat UI MAUI consumer audit passed for '$($project[0].FullName)' (contract 2.1.34$(if ($ExactSample) { ', Exact Sample Mode' }))."
