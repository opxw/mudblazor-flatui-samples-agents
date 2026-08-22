# Copyright (c) 2026 opx. All rights reserved.

[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [string] $ProjectPath = "."
)

$ErrorActionPreference = "Stop"

$expectedContractVersion = "2.0.10"
$expectedPackages = [ordered]@{
    "Opx.MudBlazor.FlatUi" = "2.0.10"
    "MudBlazor" = "9.7.0"
}
$expectedHostCssSha256 = "F62454A693C20C446ECDCDF563C6F0A6DF1AABB5604C352558D7CB54CFA9CE82"
$expectedPackageCssSha256 = "947B1552B674240931BF08B4450414020F61390D611FDC7B09CA0DD3A5255C02"
$violations = [System.Collections.Generic.List[string]]::new()

function Add-Violation([string] $Message) {
    $violations.Add($Message)
}

function Get-JsonProperty($Object, [string] $Name) {
    if ($null -eq $Object) {
        return $null
    }

    $property = $Object.PSObject.Properties[$Name]
    if ($null -eq $property) {
        return $null
    }

    return $property.Value
}

function Resolve-ProjectFile([string] $CandidatePath) {
    $resolved = Resolve-Path -LiteralPath $CandidatePath -ErrorAction Stop
    $item = Get-Item -LiteralPath $resolved.Path
    if (-not $item.PSIsContainer) {
        if ($item.Extension -ne ".csproj") {
            throw "ProjectPath must point to a project directory or .csproj file."
        }

        return $item
    }

    $projects = @(Get-ChildItem -LiteralPath $item.FullName -Filter "*.csproj" -File)
    if ($projects.Count -ne 1) {
        throw "Expected exactly one .csproj directly under '$($item.FullName)', found $($projects.Count)."
    }

    return $projects[0]
}

function Resolve-ContractRoot([string] $StartPath) {
    $candidate = Get-Item -LiteralPath $StartPath
    while ($null -ne $candidate) {
        $rulesPath = Join-Path $candidate.FullName "RULES.md"
        $agentsPath = Join-Path $candidate.FullName ".agents\AGENTS.md"
        if ((Test-Path -LiteralPath $rulesPath) -and (Test-Path -LiteralPath $agentsPath)) {
            return $candidate.FullName
        }

        $candidate = $candidate.Parent
    }

    return $null
}

function Get-PackageVersion($Node) {
    $attribute = $Node.Attributes["Version"]
    if ($null -ne $attribute) {
        return $attribute.Value
    }

    $versionNode = $Node.SelectSingleNode("Version")
    if ($null -ne $versionNode) {
        return $versionNode.InnerText
    }

    return $null
}

function Get-NormalizedTextSha256([string] $Path) {
    $text = (Get-Content -LiteralPath $Path -Raw).Replace("`r`n", "`n").Replace("`r", "`n")
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($text)
    return [System.Convert]::ToHexString([System.Security.Cryptography.SHA256]::HashData($bytes))
}

$project = Resolve-ProjectFile $ProjectPath
$projectRoot = $project.Directory.FullName
$contractRoot = Resolve-ContractRoot $projectRoot
if ([string]::IsNullOrWhiteSpace($contractRoot)) {
    Add-Violation "RULES.md and .agents/AGENTS.md were not found at the project root or any parent."
}

$manifestPath = Join-Path $projectRoot "flat-ui.contract.json"
$schemaPath = Join-Path $projectRoot "flat-ui.contract.schema.json"
if (-not (Test-Path -LiteralPath $manifestPath)) {
    Add-Violation "flat-ui.contract.json is missing from the project root."
}
if (-not (Test-Path -LiteralPath $schemaPath)) {
    Add-Violation "flat-ui.contract.schema.json is missing from the project root."
}

$manifest = $null
if (Test-Path -LiteralPath $manifestPath) {
    try {
        $manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
    }
    catch {
        Add-Violation "flat-ui.contract.json is not valid JSON: $($_.Exception.Message)"
    }
}

if ($null -ne $manifest) {
    if ((Get-JsonProperty $manifest "schemaVersion") -cne "1.8") {
        Add-Violation "Contract schemaVersion must be 1.8."
    }
    if ((Get-JsonProperty $manifest "contractVersion") -cne $expectedContractVersion) {
        Add-Violation "Contract version must be $expectedContractVersion."
    }

    $source = Get-JsonProperty $manifest "source"
    if ((Get-JsonProperty $source "repository") -cne "mudblazor-flat-ui") {
        Add-Violation "Contract source.repository must be mudblazor-flat-ui."
    }
    if ((Get-JsonProperty $source "samplePath") -cne "samples/Opx.MudBlazor.FlatUi.Sample") {
        Add-Violation "Contract source.samplePath must identify the canonical sample."
    }

    $manifestPackages = Get-JsonProperty $manifest "packages"
    foreach ($packageName in $expectedPackages.Keys) {
        $actualVersion = Get-JsonProperty $manifestPackages $packageName
        if ($actualVersion -cne $expectedPackages[$packageName]) {
            Add-Violation "Contract package $packageName must be $($expectedPackages[$packageName])."
        }
    }

    $baseline = Get-JsonProperty $manifest "baseline"
    if ((Get-JsonProperty $baseline "pageId") -cne "opx.page.dashboard.overview") {
        Add-Violation "Baseline PageId must be opx.page.dashboard.overview."
    }
    if ((Get-JsonProperty $baseline "route") -cne "/") {
        Add-Violation "Baseline route must be /."
    }
    if ((Get-JsonProperty $baseline "archetype") -cne "Home.razor") {
        Add-Violation "Baseline archetype must be Home.razor."
    }
    if ([double](Get-JsonProperty $baseline "baseFontSizePx") -ne 14.5) {
        Add-Violation "Baseline baseFontSizePx must be 14.5."
    }
    if ([int](Get-JsonProperty $baseline "responsiveBreakpointPx") -ne 900) {
        Add-Violation "Baseline responsiveBreakpointPx must be 900."
    }
    $adaptiveResponsive = Get-JsonProperty $baseline "adaptiveResponsive"
    $responsiveChecks = @(
        @("desktopTableAbovePx", (Get-JsonProperty $adaptiveResponsive "desktopTableAbovePx"), 900),
        @("responsiveCardMaxPx", (Get-JsonProperty $adaptiveResponsive "responsiveCardMaxPx"), 900),
        @("twoColumnCardMinPx", (Get-JsonProperty $adaptiveResponsive "twoColumnCardMinPx"), 601),
        @("twoColumnCardMaxPx", (Get-JsonProperty $adaptiveResponsive "twoColumnCardMaxPx"), 900),
        @("phoneSingleColumnMaxPx", (Get-JsonProperty $adaptiveResponsive "phoneSingleColumnMaxPx"), 600)
    )
    foreach ($check in $responsiveChecks) {
        if ($null -eq $check[1] -or [int]$check[1] -ne [int]$check[2]) {
            Add-Violation "Baseline adaptiveResponsive.$($check[0]) must be $($check[2])."
        }
    }
    foreach ($flag in @("liveResizeRequired", "platformUserAgentLayoutForbidden")) {
        if ((Get-JsonProperty $adaptiveResponsive $flag) -ne $true) {
            Add-Violation "Baseline adaptiveResponsive.$flag must be true."
        }
    }
    if ((Get-JsonProperty $baseline "defaultThemeMode") -cne "Light") {
        Add-Violation "Baseline defaultThemeMode must be Light."
    }
    $crudTerminology = Get-JsonProperty $baseline "crudTerminology"
    if ((Get-JsonProperty $crudTerminology "editActionLabel") -cne "Edit") {
        Add-Violation "Baseline CRUD edit action label must be 'Edit'."
    }

    $runtimeHtml = Get-JsonProperty $baseline "runtimeHtml"
    if ((Get-JsonProperty $runtimeHtml "poweredByComment") -cne "Powered by opx (github.com/opxw)") {
        Add-Violation "Baseline runtimeHtml.poweredByComment must be 'Powered by opx (github.com/opxw)'."
    }

    $initialRun = Get-JsonProperty $baseline "initialRun"
    if ((Get-JsonProperty $initialRun "script") -cne "run-clean.ps1") {
        Add-Violation "Baseline initialRun.script must be run-clean.ps1."
    }
    if ((@((Get-JsonProperty $initialRun "cleanDirectories")) -join "|") -cne "bin|obj") {
        Add-Violation "Baseline initialRun.cleanDirectories must be bin and obj in canonical order."
    }
    if ((Get-JsonProperty $initialRun "restoreBeforeRun") -ne $true) {
        Add-Violation "Baseline initialRun.restoreBeforeRun must be true."
    }

    $stylesheetOwnership = Get-JsonProperty $baseline "stylesheetOwnership"
    $stylesheetChecks = @(
        @("reusableCssSource", (Get-JsonProperty $stylesheetOwnership "reusableCssSource"), "package-only"),
        @("packageStylesheet", (Get-JsonProperty $stylesheetOwnership "packageStylesheet"), "_content/Opx.MudBlazor.FlatUi/opx-flat-ui.css"),
        @("packageStylesheetSha256", (Get-JsonProperty $stylesheetOwnership "packageStylesheetSha256"), $expectedPackageCssSha256),
        @("mudBlazorStylesheet", (Get-JsonProperty $stylesheetOwnership "mudBlazorStylesheet"), "_content/MudBlazor/MudBlazor.min.css"),
        @("hostStylesheet", (Get-JsonProperty $stylesheetOwnership "hostStylesheet"), "wwwroot/app.css"),
        @("hostStylesheetPurpose", (Get-JsonProperty $stylesheetOwnership "hostStylesheetPurpose"), "sample-and-domain-composition-only"),
        @("hostStylesheetSha256", (Get-JsonProperty $stylesheetOwnership "hostStylesheetSha256"), $expectedHostCssSha256),
        @("localPackageCssCopyForbidden", (Get-JsonProperty $stylesheetOwnership "localPackageCssCopyForbidden"), $true),
        @("additionalUiFrameworkCssForbidden", (Get-JsonProperty $stylesheetOwnership "additionalUiFrameworkCssForbidden"), $true)
    )
    foreach ($check in $stylesheetChecks) {
        if ($null -eq $check[1] -or $check[1] -cne $check[2]) {
            Add-Violation "Baseline stylesheetOwnership.$($check[0]) must be '$($check[2])'."
        }
    }

    $mandatoryShell = Get-JsonProperty $baseline "mandatoryShell"
    if ((Get-JsonProperty $mandatoryShell "layoutSource") -cne "Components/Layout/MainLayout.razor") {
        Add-Violation "Baseline mandatoryShell.layoutSource must be Components/Layout/MainLayout.razor."
    }

    $requiredSettings = Get-JsonProperty $mandatoryShell "settings"
    $settingsChecks = @(
        @("required", (Get-JsonProperty $requiredSettings "required"), $true),
        @("triggerIcon", (Get-JsonProperty $requiredSettings "triggerIcon"), "MoreVert"),
        @("menuLabel", (Get-JsonProperty $requiredSettings "menuLabel"), "Settings"),
        @("modalTitle", (Get-JsonProperty $requiredSettings "modalTitle"), "Application preferences")
    )
    foreach ($check in $settingsChecks) {
        if ($null -eq $check[1] -or $check[1] -cne $check[2]) {
            Add-Violation "Baseline mandatoryShell.settings.$($check[0]) must be '$($check[2])'."
        }
    }
    $themeModes = @((Get-JsonProperty $requiredSettings "themeModes"))
    if (($themeModes -join "|") -cne "Light|Dark / Night|Auto") {
        Add-Violation "Baseline mandatoryShell.settings.themeModes must be Light, Dark / Night, Auto in canonical order."
    }

    $requiredSidebar = Get-JsonProperty $mandatoryShell "sidebar"
    $sidebarChecks = @(
        @("required", (Get-JsonProperty $requiredSidebar "required"), $true),
        @("componentSource", (Get-JsonProperty $requiredSidebar "componentSource"), "Components/Layout/SampleSidebarMenu.razor"),
        @("caption", (Get-JsonProperty $requiredSidebar "caption"), "Showcase"),
        @("homeLabel", (Get-JsonProperty $requiredSidebar "homeLabel"), "Dashboard"),
        @("homeRoute", (Get-JsonProperty $requiredSidebar "homeRoute"), "/"),
        @("searchEnabled", (Get-JsonProperty $requiredSidebar "searchEnabled"), $true),
        @("activeRouteExpansion", (Get-JsonProperty $requiredSidebar "activeRouteExpansion"), $true)
    )
    foreach ($check in $sidebarChecks) {
        if ($null -eq $check[1] -or $check[1] -cne $check[2]) {
            Add-Violation "Baseline mandatoryShell.sidebar.$($check[0]) must be '$($check[2])'."
        }
    }
    $initialGroups = @((Get-JsonProperty $requiredSidebar "initialGroups"))
    if (($initialGroups -join "|") -cne "ERP|Operations|Data & Reports|Commerce & Content|Account|UI Kit") {
        Add-Violation "Baseline mandatoryShell.sidebar.initialGroups must document the canonical initialized menu groups."
    }

    $consumerOwnedSurfaces = @((Get-JsonProperty $baseline "consumerOwnedSurfaces"))
    $expectedConsumerOwnedSurfaces = @(
        "dashboard-domain-content",
        "domain-widgets-and-metrics",
        "domain-summary-lists",
        "quick-access-actions",
        "current-user-identity",
        "role-and-account-copy",
        "logout-and-session-behavior",
        "business-menu-labels-routes-and-permissions"
    )
    if (($consumerOwnedSurfaces -join "|") -cne ($expectedConsumerOwnedSurfaces -join "|")) {
        Add-Violation "Baseline consumerOwnedSurfaces must keep domain content, user identity, session behavior, and business menu records outside the reusable UI contract."
    }

    $widgetSpacing = Get-JsonProperty $baseline "widgetSpacing"
    $widgetSpacingChecks = @(
        @("outerMarginPx", (Get-JsonProperty $widgetSpacing "outerMarginPx"), 0),
        @("gridGapPx.desktop", (Get-JsonProperty (Get-JsonProperty $widgetSpacing "gridGapPx") "desktop"), 12),
        @("gridGapPx.mobile", (Get-JsonProperty (Get-JsonProperty $widgetSpacing "gridGapPx") "mobile"), 10),
        @("bodyPaddingPx", (Get-JsonProperty $widgetSpacing "bodyPaddingPx"), 12),
        @("headerPaddingPx.block", (Get-JsonProperty (Get-JsonProperty $widgetSpacing "headerPaddingPx") "block"), 9),
        @("headerPaddingPx.inline", (Get-JsonProperty (Get-JsonProperty $widgetSpacing "headerPaddingPx") "inline"), 12),
        @("footerPaddingPx.block", (Get-JsonProperty (Get-JsonProperty $widgetSpacing "footerPaddingPx") "block"), 8),
        @("footerPaddingPx.inline", (Get-JsonProperty (Get-JsonProperty $widgetSpacing "footerPaddingPx") "inline"), 12),
        @("sectionGapPx.desktop", (Get-JsonProperty (Get-JsonProperty $widgetSpacing "sectionGapPx") "desktop"), 18),
        @("sectionGapPx.mobile", (Get-JsonProperty (Get-JsonProperty $widgetSpacing "sectionGapPx") "mobile"), 16),
        @("sectionHeadingBottomMarginPx", (Get-JsonProperty $widgetSpacing "sectionHeadingBottomMarginPx"), 8),
        @("actionMetricPaddingPx.desktop", (Get-JsonProperty (Get-JsonProperty $widgetSpacing "actionMetricPaddingPx") "desktop"), 13),
        @("actionMetricPaddingPx.mobile", (Get-JsonProperty (Get-JsonProperty $widgetSpacing "actionMetricPaddingPx") "mobile"), 12),
        @("compactMetricPaddingPx", (Get-JsonProperty $widgetSpacing "compactMetricPaddingPx"), 13),
        @("lowerGridTopMarginPx.desktop", (Get-JsonProperty (Get-JsonProperty $widgetSpacing "lowerGridTopMarginPx") "desktop"), 12),
        @("lowerGridTopMarginPx.mobile", (Get-JsonProperty (Get-JsonProperty $widgetSpacing "lowerGridTopMarginPx") "mobile"), 10),
        @("mobileBreakpointPx", (Get-JsonProperty $widgetSpacing "mobileBreakpointPx"), 600)
    )
    foreach ($check in $widgetSpacingChecks) {
        if ($null -eq $check[1] -or [int]$check[1] -ne [int]$check[2]) {
            Add-Violation "Baseline widgetSpacing.$($check[0]) must be $($check[2])."
        }
    }
}

[xml] $projectXml = Get-Content -LiteralPath $project.FullName -Raw
$packageNodes = @($projectXml.SelectNodes("//PackageReference"))
foreach ($packageName in $expectedPackages.Keys) {
    $matches = @($packageNodes | Where-Object { $_.Include -ceq $packageName })
    if ($matches.Count -ne 1) {
        Add-Violation "Project must contain exactly one PackageReference for $packageName."
        continue
    }

    $actualVersion = Get-PackageVersion $matches[0]
    if ($actualVersion -cne $expectedPackages[$packageName]) {
        Add-Violation "Project package $packageName must be pinned to $($expectedPackages[$packageName]); found '$actualVersion'."
    }
}

$projectReferences = @($projectXml.SelectNodes("//ProjectReference"))
foreach ($reference in $projectReferences) {
    if ($reference.Include -match "(?i)Opx[.]MudBlazor[.]FlatUi|mudblazor-flat-ui") {
        Add-Violation "Opx.MudBlazor.FlatUi must use the public PackageReference, not ProjectReference '$($reference.Include)'."
    }
}

$nugetPackagesRoot = $null
$assetsPath = Join-Path $projectRoot "obj\project.assets.json"
if (Test-Path -LiteralPath $assetsPath) {
    try {
        $assets = Get-Content -LiteralPath $assetsPath -Raw | ConvertFrom-Json
        $packageFolders = @($assets.packageFolders.PSObject.Properties.Name)
        if ($packageFolders.Count -eq 1) {
            $nugetPackagesRoot = $packageFolders[0]
        }
        elseif ($packageFolders.Count -gt 1) {
            Add-Violation "Restore produced multiple package folders; the OPX package asset source is ambiguous."
        }
    }
    catch {
        Add-Violation "obj/project.assets.json could not be read: $($_.Exception.Message)"
    }
}
if ([string]::IsNullOrWhiteSpace($nugetPackagesRoot)) {
    $nugetPackagesRoot = $env:NUGET_PACKAGES
}
if ([string]::IsNullOrWhiteSpace($nugetPackagesRoot)) {
    $nugetPackagesRoot = Join-Path ([Environment]::GetFolderPath([Environment+SpecialFolder]::UserProfile)) ".nuget\packages"
}
$packageCssPath = Join-Path $nugetPackagesRoot "opx.mudblazor.flatui\$($expectedPackages['Opx.MudBlazor.FlatUi'])\staticwebassets\opx-flat-ui.css"
if (-not (Test-Path -LiteralPath $packageCssPath)) {
    Add-Violation "Restored OPX package stylesheet was not found at '$packageCssPath'; restore the project before auditing."
}
else {
    $packageCssHash = (Get-FileHash -LiteralPath $packageCssPath -Algorithm SHA256).Hash
    if ($packageCssHash -cne $expectedPackageCssSha256) {
        Add-Violation "Restored OPX package stylesheet hash must be $expectedPackageCssSha256 for package 2.0.10; found $packageCssHash."
    }
}

$disallowedPackages = "Radzen", "Syncfusion", "Telerik", "Blazorise", "AntDesign"
foreach ($packageNode in $packageNodes) {
    foreach ($disallowed in $disallowedPackages) {
        if ($packageNode.Include -match "(?i)^$([regex]::Escape($disallowed))") {
            Add-Violation "Additional UI framework package '$($packageNode.Include)' is not allowed by the OPX Flat UI contract."
        }
    }
}

$requiredFiles = @(
    "Program.cs",
    "Components\App.razor",
    "Components\_Imports.razor",
    "Components\Layout\MainLayout.razor",
    "Components\Layout\SampleSidebarMenu.razor",
    "Components\Pages\Home.razor",
    "appsettings.json",
    "run-clean.ps1",
    "wwwroot\app.css"
)
foreach ($relativePath in $requiredFiles) {
    if (-not (Test-Path -LiteralPath (Join-Path $projectRoot $relativePath))) {
        Add-Violation "Required consumer baseline file is missing: $relativePath"
    }
}

$programPath = Join-Path $projectRoot "Program.cs"
if (Test-Path -LiteralPath $programPath) {
    $program = Get-Content -LiteralPath $programPath -Raw
    $requiredProgramTokens = @(
        "AddRazorComponents()",
        ".AddInteractiveServerComponents",
        "AddMudServices",
        "FlatPageLoadingState",
        "FlatMessageBoxService",
        "FlatUiPreferencesService",
        "MapStaticAssets()",
        "AddInteractiveServerRenderMode()"
    )
    foreach ($token in $requiredProgramTokens) {
        if (-not $program.Contains($token, [StringComparison]::Ordinal)) {
            Add-Violation "Program.cs is missing required host registration '$token'."
        }
    }

    foreach ($section in @("Application", "Display", "Reconnect", "Grid", "Loading", "Assets", "Localization")) {
        if ($program -notmatch [regex]::Escape("GetSection(`"OpxFlatUi:$section`")")) {
            Add-Violation "Program.cs does not bind OpxFlatUi:$section."
        }
    }
}

$appPath = Join-Path $projectRoot "Components\App.razor"
if (Test-Path -LiteralPath $appPath) {
    $appSource = Get-Content -LiteralPath $appPath -Raw
    $orderedAssets = @(
        "opx-flat-ui-theme-bootstrap.js",
        "MudBlazor/MudBlazor.min.css",
        "Opx.MudBlazor.FlatUi/opx-flat-ui.css",
        "app.css",
        "MudBlazor/MudBlazor.min.js",
        "FlatUiJavaScriptPath",
        "_framework/blazor.web.js"
    )
    $lastIndex = -1
    foreach ($asset in $orderedAssets) {
        $assetIndex = $appSource.IndexOf($asset, [StringComparison]::Ordinal)
        if ($assetIndex -lt 0) {
            Add-Violation "Components/App.razor is missing required asset '$asset'."
        }
        elseif ($assetIndex -le $lastIndex) {
            Add-Violation "Components/App.razor asset '$asset' is loaded out of canonical order."
        }
        else {
            $lastIndex = $assetIndex
        }
    }

    if ($appSource -notmatch '<FlatReconnectModal\s+Options="ReconnectOptions"') {
        Add-Violation "Components/App.razor must render the package-owned FlatReconnectModal."
    }

    $poweredByComment = '<!-- Powered by opx (github.com/opxw) -->'
    $commentMatches = [regex]::Matches($appSource, [regex]::Escape($poweredByComment)).Count
    $bodyIndex = $appSource.IndexOf('<body>', [StringComparison]::Ordinal)
    $commentIndex = $appSource.IndexOf($poweredByComment, [StringComparison]::Ordinal)
    $routesIndex = $appSource.IndexOf('<Routes', [StringComparison]::Ordinal)
    if ($commentMatches -ne 1 -or $bodyIndex -lt 0 -or $commentIndex -le $bodyIndex -or $routesIndex -le $commentIndex) {
        Add-Violation "Components/App.razor must emit exactly one '$poweredByComment' through MarkupString immediately inside the body before Routes. A literal Razor HTML comment is removed during compilation."
    }
}

$cleanRunPath = Join-Path $projectRoot "run-clean.ps1"
if (Test-Path -LiteralPath $cleanRunPath) {
    $cleanRunSource = Get-Content -LiteralPath $cleanRunPath -Raw
    foreach ($token in @(
        '@("bin", "obj")',
        '[System.IO.Directory]::Delete($target, $true)',
        'dotnet restore',
        'dotnet run --project',
        '--no-restore'
    )) {
        if (-not $cleanRunSource.Contains($token, [StringComparison]::Ordinal)) {
            Add-Violation "run-clean.ps1 is missing required initial-run behavior '$token'."
        }
    }
}

$mainLayoutPath = Join-Path $projectRoot "Components\Layout\MainLayout.razor"
if (Test-Path -LiteralPath $mainLayoutPath) {
    $mainLayoutSource = Get-Content -LiteralPath $mainLayoutPath -Raw
    $requiredLayoutTokens = [ordered]@{
        "AppBar MoreVert trigger" = "Icons.Material.Outlined.MoreVert"
        "Settings menu item" = 'Label="Settings"'
        "Settings click handler" = 'OnClick="OpenSettings"'
        "Settings modal state" = '@if (_settingsOpen)'
        "Application preferences modal" = "Application preferences"
        "Light theme choice" = "FlatUiThemeMode.Light"
        "Dark theme choice" = "FlatUiThemeMode.Dark"
        "Auto theme choice" = "FlatUiThemeMode.Auto"
        "Display settings editor" = "<FlatDisplaySettings"
        "Default sidebar mount" = "<SampleSidebarMenu />"
        "Logout action icon" = "Icons.Material.Outlined.Logout"
        "Logout action class" = 'Class="logout-action"'
        "Logout accessible name" = 'aria-label="Logout"'
    }
    foreach ($requirement in $requiredLayoutTokens.GetEnumerator()) {
        if (-not $mainLayoutSource.Contains($requirement.Value, [StringComparison]::Ordinal)) {
            Add-Violation "Components/Layout/MainLayout.razor is missing mandatory $($requirement.Key)."
        }
    }
}

$sidebarPath = Join-Path $projectRoot "Components\Layout\SampleSidebarMenu.razor"
if (Test-Path -LiteralPath $sidebarPath) {
    $sidebarSource = Get-Content -LiteralPath $sidebarPath -Raw
    $requiredSidebarTokens = [ordered]@{
        "Showcase caption" = 'Class="nav-caption">Showcase'
        "Dashboard home route" = 'Href="/" Match="NavLinkMatch.All"'
        "Dashboard label" = "Dashboard"
        "Sidebar group structure" = "<MudNavGroup"
        "Sidebar search state" = "FlatSidebarSearchState"
        "Active-route expansion" = "ExpandActiveRouteGroup"
        "Route change subscription" = "Navigation.LocationChanged"
    }
    foreach ($requirement in $requiredSidebarTokens.GetEnumerator()) {
        if (-not $sidebarSource.Contains($requirement.Value, [StringComparison]::Ordinal)) {
            Add-Violation "Components/Layout/SampleSidebarMenu.razor is missing mandatory $($requirement.Key)."
        }
    }
}

$settingsPath = Join-Path $projectRoot "appsettings.json"
if (Test-Path -LiteralPath $settingsPath) {
    try {
        $settings = Get-Content -LiteralPath $settingsPath -Raw | ConvertFrom-Json
        $opxSettings = Get-JsonProperty $settings "OpxFlatUi"
        foreach ($section in @("Application", "Display", "Reconnect", "Grid", "Loading", "Assets", "Localization")) {
            if ($null -eq (Get-JsonProperty $opxSettings $section)) {
                Add-Violation "appsettings.json is missing OpxFlatUi:$section."
            }
        }

        $display = Get-JsonProperty $opxSettings "Display"
        if ([double](Get-JsonProperty $display "DefaultFontSizePx") -ne 14.5) {
            Add-Violation "OpxFlatUi:Display:DefaultFontSizePx must start at 14.5."
        }
        if ([int](Get-JsonProperty $display "DefaultRoundedSizePx") -ne 0) {
            Add-Violation "OpxFlatUi:Display:DefaultRoundedSizePx must start at 0."
        }
        if ((Get-JsonProperty $display "DefaultFabShape") -cne "Circle") {
            Add-Violation "OpxFlatUi:Display:DefaultFabShape must start at Circle."
        }
        if ((Get-JsonProperty $display "DefaultThemeMode") -cne "Light") {
            Add-Violation "OpxFlatUi:Display:DefaultThemeMode must start at Light."
        }

        $assets = Get-JsonProperty $opxSettings "Assets"
        if ((Get-JsonProperty $assets "UseMinifiedJavaScript") -ne $true) {
            Add-Violation "OpxFlatUi:Assets:UseMinifiedJavaScript must be true for the consumer baseline."
        }
    }
    catch {
        Add-Violation "appsettings.json is not valid JSON: $($_.Exception.Message)"
    }
}

$appCssPath = Join-Path $projectRoot "wwwroot\app.css"
if (Test-Path -LiteralPath $appCssPath) {
    $appCss = Get-Content -LiteralPath $appCssPath -Raw
    $appCssHash = Get-NormalizedTextSha256 $appCssPath
    if ($appCssHash -cne $expectedHostCssSha256) {
        Add-Violation "wwwroot/app.css must be the untouched canonical host/sample stylesheet with SHA-256 $expectedHostCssSha256; found $appCssHash."
    }
    if (-not $appCss.Contains('.logout-action{margin-left:auto!important;', [StringComparison]::Ordinal)) {
        Add-Violation "wwwroot/app.css must keep the initialized admin Logout action aligned to the right edge."
    }
    if ($appCss -match "(?im)@import\s+[^;]*(bootstrap|tailwind|radzen|syncfusion|telerik|blazorise|antdesign)") {
        Add-Violation "wwwroot/app.css imports another UI framework and may override the Flat UI baseline."
    }
}

$localPackageCssCopies = @(Get-ChildItem -LiteralPath $projectRoot -Recurse -File -Include "opx-flat-ui.css", "MudBlazor.min.css" | Where-Object {
    $_.FullName -notmatch "[\\/](bin|obj|[.]nuget)[\\/]"
})
foreach ($copy in $localPackageCssCopies) {
    Add-Violation "Reusable CSS must come from NuGet static web assets; remove local package CSS copy '$($copy.FullName)'."
}

$localCssFiles = @(Get-ChildItem -LiteralPath $projectRoot -Recurse -File -Filter "*.css" | Where-Object {
    $_.FullName -notmatch "[\\/](bin|obj|[.]nuget)[\\/]"
})
foreach ($cssFile in $localCssFiles) {
    $cssSource = Get-Content -LiteralPath $cssFile.FullName -Raw
    if ($cssSource -match "(?im)@import\s+[^;]*(bootstrap|tailwind|radzen|syncfusion|telerik|blazorise|antdesign)") {
        Add-Violation "Local stylesheet '$($cssFile.FullName)' imports an additional UI framework."
    }
}

if (-not [string]::IsNullOrWhiteSpace($contractRoot)) {
    $contractFiles = @(
        "RULES.md",
        ".agents\AGENTS.md",
        ".agents\RULES.md",
        ".agents\skills\opx-flat-ui-development\SKILL.md",
        ".agents\skills\opx-flat-ui-development\references\page-registry.md",
        ".agents\skills\opx-flat-ui-development\references\layout-decision.md",
        ".agents\skills\opx-flat-ui-development\references\sample-source-map.md",
        "docs\WIDGETS.md"
    )
    foreach ($relativePath in $contractFiles) {
        if (-not (Test-Path -LiteralPath (Join-Path $contractRoot $relativePath))) {
            Add-Violation "Canonical consumer instruction is missing: $relativePath"
        }
    }
}

if ($violations.Count -gt 0) {
    $violations | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Output "OPX Flat UI consumer audit passed for '$($project.FullName)' (contract $expectedContractVersion)."
