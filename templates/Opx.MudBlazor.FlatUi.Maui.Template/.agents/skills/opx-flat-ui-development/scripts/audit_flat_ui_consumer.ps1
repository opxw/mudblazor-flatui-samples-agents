# Copyright (c) 2026 opx. All rights reserved.

[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [string] $ProjectPath = ".",
    [switch] $ExactSample
)

$ErrorActionPreference = "Stop"

$expectedContractVersion = "2.1.2"
$expectedPackages = [ordered]@{
    "Opx.MudBlazor.FlatUi" = "2.1.2"
    "MudBlazor" = "9.9.0"
}
$expectedHostCssSha256 = "EDF51498287AA77C650FCC86D5E6F9DCC0FFC56D02B222FCDE51EFE977720666"
$expectedPackageCssSha256 = "6F4A09824E6FFDDCD979DB290804BA736D049AC5B23B946C6263BD1ADD0F9687"
$expectedExactSampleHashes = [ordered]@{
    "Components\Layout\MainLayout.razor" = "1329B9F7A058128B3971CA6C76FD4CCB06333CA9D7C17A2733D07109E46328A8"
    "Components\Layout\SampleSidebarMenu.razor" = "8157F2819E65D521AFB4C49BF6D2C4C4BE423C7FBBF1DF26CC7139EBB0FDA5AB"
    "Components\Pages\Home.razor" = "9303D93EAC12EAC1EB81CC2057E3283896C190086DBD7057BBBB07674CFA4440"
    "Components\RootStartupGate.razor" = "1513F7901D638CFAA829E6B55EE623B5D9A42D8C0D1AE80FE9C130C5DCB78D1D"
    "appsettings.json" = "1465D5A8931899ACDD96D7EB4C66EB9F08415267B7F35495E6D7615B557C8C9C"
    "wwwroot\app.css" = "EDF51498287AA77C650FCC86D5E6F9DCC0FFC56D02B222FCDE51EFE977720666"
}
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
else {
    $registryPath = Join-Path $contractRoot ".agents\skills\opx-flat-ui-development\references\page-registry.md"
    $behaviorRegistryPath = Join-Path $contractRoot ".agents\skills\opx-flat-ui-development\references\showcase-behavior-registry.md"
    if ((Test-Path -LiteralPath $registryPath) -and (Test-Path -LiteralPath $behaviorRegistryPath)) {
        $registryIds = @([regex]::Matches(
            (Get-Content -LiteralPath $registryPath -Raw),
            '(?m)^\| `(?<id>opx\.page\.[^`]+)` \|') | ForEach-Object { $_.Groups['id'].Value })
        $behaviorText = Get-Content -LiteralPath $behaviorRegistryPath -Raw
        if (($behaviorText -notmatch 'logical `padding-inline`') -or ($behaviorText -notmatch '`14px` desktop') -or ($behaviorText -notmatch '`12px` at `<=900px`') -or ($behaviorText -notmatch 'zero left inset')) {
            Add-Violation "Canonical showcase behavior registry must preserve the positive content-panel inset contract."
        }
        if (($behaviorText -notmatch '"bug package"') -or ($behaviorText -notmatch '"bug integrasi aplikasi"') -or ($behaviorText -notmatch '"belum terklasifikasi"')) {
            Add-Violation "Canonical showcase behavior registry must preserve explicit package-versus-integration defect labels."
        }
        $declaredProfiles = @([regex]::Matches($behaviorText, '(?m)^### `(?<profile>[^`]+)`\s*$') | ForEach-Object { $_.Groups['profile'].Value })
        $behaviorMatches = [regex]::Matches(
            $behaviorText,
            '(?m)^\| `(?<id>opx\.page\.[^`]+)` \| `(?<profile>[^`]+)` \| `(?<source>[^`]+)` \|\s*$')
        $behaviorIds = @($behaviorMatches | ForEach-Object { $_.Groups['id'].Value })
        foreach ($duplicate in @($behaviorIds | Group-Object | Where-Object Count -gt 1)) {
            Add-Violation "Canonical showcase behavior registry contains duplicate PageId '$($duplicate.Name)'."
        }
        foreach ($missingId in @($registryIds | Where-Object { $_ -notin $behaviorIds })) {
            Add-Violation "Canonical PageId '$missingId' has no showcase behavior profile."
        }
        foreach ($staleId in @($behaviorIds | Where-Object { $_ -notin $registryIds })) {
            Add-Violation "Showcase behavior registry contains unknown PageId '$staleId'."
        }
        foreach ($profile in @($behaviorMatches | ForEach-Object { $_.Groups['profile'].Value } | Select-Object -Unique)) {
            if ($profile -notin $declaredProfiles) {
                Add-Violation "Showcase behavior profile '$profile' is mapped but not declared."
            }
        }
    }
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

if ((Test-Path -LiteralPath $manifestPath) -and (Test-Path -LiteralPath $schemaPath)) {
    try {
        $manifestText = Get-Content -LiteralPath $manifestPath -Raw
        $schemaText = Get-Content -LiteralPath $schemaPath -Raw
        if (-not ($manifestText | Test-Json -Schema $schemaText)) {
            Add-Violation "flat-ui.contract.json does not satisfy flat-ui.contract.schema.json."
        }
    }
    catch {
        Add-Violation "Contract schema validation failed: $($_.Exception.Message)"
    }
}

if ($null -ne $manifest) {
    if ((Get-JsonProperty $manifest "schemaVersion") -cne "3.1") {
        Add-Violation "Contract schemaVersion must be 3.1."
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

    $canonicalSample = Get-JsonProperty $manifest "canonicalSample"
    if ((Get-JsonProperty $canonicalSample "mode") -cne "exact-initial-baseline" -or
        (Get-JsonProperty $canonicalSample "auditSwitch") -cne "-ExactSample" -or
        (Get-JsonProperty $canonicalSample "visualDriftRequiresExplicitDecision") -ne $true) {
        Add-Violation "Contract canonicalSample must require the exact initial baseline, -ExactSample audit, and explicit approval for visual drift."
    }
    $canonicalFiles = Get-JsonProperty $canonicalSample "files"
    foreach ($entry in $expectedExactSampleHashes.GetEnumerator()) {
        $jsonName = $entry.Key.Replace("\", "/")
        if ((Get-JsonProperty $canonicalFiles $jsonName) -cne $entry.Value) {
            Add-Violation "Contract canonicalSample.files.$jsonName does not match the canonical normalized hash."
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
    if ((Get-JsonProperty $baseline "useAppFontSize") -ne $false) {
        Add-Violation "Baseline useAppFontSize must be false so Device/browser font ownership is the default."
    }
    if ([double](Get-JsonProperty $baseline "baseFontSizePx") -ne 16) {
        Add-Violation "Baseline baseFontSizePx must be 16 for Manual font mode."
    }
    if ([int](Get-JsonProperty $baseline "defaultRoundedSizePx") -ne 7) {
        Add-Violation "Baseline defaultRoundedSizePx must be 7 for canonical button corners."
    }
    if ((Get-JsonProperty $baseline "defaultColorPalette") -cne "fluent-blue") {
        Add-Violation "Baseline defaultColorPalette must be fluent-blue."
    }
    if ((Get-JsonProperty $baseline "defaultDensity") -cne "Default") {
        Add-Violation "Baseline defaultDensity must be Default."
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
        @("phoneSingleColumnMaxPx", (Get-JsonProperty $adaptiveResponsive "phoneSingleColumnMaxPx"), 600),
        @("bottomNavigationDefaultMaxWidthPx", (Get-JsonProperty $adaptiveResponsive "bottomNavigationDefaultMaxWidthPx"), 600),
        @("bottomNavigationSampleMaxWidthPx", (Get-JsonProperty $adaptiveResponsive "bottomNavigationSampleMaxWidthPx"), 900),
        @("bottomNavigationBarHeightPx", (Get-JsonProperty $adaptiveResponsive "bottomNavigationBarHeightPx"), 60),
        @("bottomNavigationLabelLineHeight", (Get-JsonProperty $adaptiveResponsive "bottomNavigationLabelLineHeight"), 1.25),
        @("bottomNavigationLabelBottomInsetPx", (Get-JsonProperty $adaptiveResponsive "bottomNavigationLabelBottomInsetPx"), 1)
    )
    foreach ($check in $responsiveChecks) {
        if ($null -eq $check[1] -or [int]$check[1] -ne [int]$check[2]) {
            Add-Violation "Baseline adaptiveResponsive.$($check[0]) must be $($check[2])."
        }
    }
    foreach ($flag in @("bottomNavigationViewportOnly", "bottomNavigationDescendersVisible", "liveResizeRequired", "platformUserAgentLayoutForbidden")) {
        if ((Get-JsonProperty $adaptiveResponsive $flag) -ne $true) {
            Add-Violation "Baseline adaptiveResponsive.$flag must be true."
        }
    }
    $nativeMobileDeployment = Get-JsonProperty $baseline "nativeMobileDeployment"
    $nativeDeploymentChecks = @(
        @("appliesWhen", (Get-JsonProperty $nativeMobileDeployment "appliesWhen"), "maui-android-ios-host-present"),
        @("toolkitPackage", (Get-JsonProperty $nativeMobileDeployment "toolkitPackage"), "CommunityToolkit.Maui"),
        @("builderRegistration", (Get-JsonProperty $nativeMobileDeployment "builderRegistration"), "UseMauiCommunityToolkit")
    )
    foreach ($check in $nativeDeploymentChecks) {
        if ($null -eq $check[1] -or $check[1] -cne $check[2]) {
            Add-Violation "Baseline nativeMobileDeployment.$($check[0]) must be '$($check[2])'."
        }
    }
    if ((@((Get-JsonProperty $nativeMobileDeployment "platforms")) -join "|") -cne "Android|iOS") {
        Add-Violation "Baseline nativeMobileDeployment.platforms must be Android and iOS in canonical order."
    }
    $nativeTypography = Get-JsonProperty $nativeMobileDeployment "typography"
    $nativeTypographyChecks = @(
        @("fontOwnership", (Get-JsonProperty $nativeTypography "fontOwnership"), "Device"),
        @("rootFontSource", (Get-JsonProperty $nativeTypography "rootFontSource"), "device-browser-1rem")
    )
    foreach ($check in $nativeTypographyChecks) {
        if ($null -eq $check[1] -or $check[1] -cne $check[2]) {
            Add-Violation "Baseline nativeMobileDeployment.typography.$($check[0]) must be '$($check[2])'."
        }
    }
    foreach ($flag in @("useAppFontSize", "accessibilityScalingPreserved")) {
        $expectedValue = if ($flag -ceq "useAppFontSize") { $false } else { $true }
        if ((Get-JsonProperty $nativeTypography $flag) -ne $expectedValue) {
            Add-Violation "Baseline nativeMobileDeployment.typography.$flag must be $($expectedValue.ToString().ToLowerInvariant())."
        }
    }
    $nativeButtonSizing = Get-JsonProperty $nativeTypography "buttonSizing"
    foreach ($flag in @(
        "labelFollowsDeviceFontScale",
        "containerGrowsWithScaledText",
        "inlineSizeAccommodatesScaledLabel",
        "minimumTouchTargetPreserved",
        "textClippingForbidden",
        "fixedHeightAtAccessibilityScaleForbidden"
    )) {
        if ((Get-JsonProperty $nativeButtonSizing $flag) -ne $true) {
            Add-Violation "Baseline nativeMobileDeployment.typography.buttonSizing.$flag must be true."
        }
    }
    $statusBar = Get-JsonProperty $nativeMobileDeployment "statusBar"
    $statusBarChecks = @(
        @("toolkitApi", (Get-JsonProperty $statusBar "toolkitApi"), "StatusBarBehavior"),
        @("colorContract", (Get-JsonProperty $statusBar "colorContract"), "same-resolved-appbar-background"),
        @("colorSource", (Get-JsonProperty $statusBar "colorSource"), "resolved-appbar-theme-token")
    )
    foreach ($check in $statusBarChecks) {
        if ($null -eq $check[1] -or $check[1] -cne $check[2]) {
            Add-Violation "Baseline nativeMobileDeployment.statusBar.$($check[0]) must be '$($check[2])'."
        }
    }
    foreach ($arrayCheck in @(
        @("synchronizedThemeModes", @("Light", "Dark / Night", "Auto")),
        @("updateTriggers", @("startup", "theme-change", "palette-change", "navigation", "resume"))
    )) {
        $actual = @((Get-JsonProperty $statusBar $arrayCheck[0]))
        $expected = @($arrayCheck[1])
        if ($actual.Count -ne $expected.Count -or (Compare-Object -ReferenceObject $expected -DifferenceObject $actual -SyncWindow 0)) {
            Add-Violation "Baseline nativeMobileDeployment.statusBar.$($arrayCheck[0]) must be '$($expected -join ", ")' in contract order."
        }
    }
    foreach ($flag in @("followsResolvedUiTheme", "followsResolvedAppBarColor", "syncOnThemeOrPaletteChange", "contrastAwareContentStyle", "nativeVerificationRequired")) {
        if ((Get-JsonProperty $statusBar $flag) -ne $true) {
            Add-Violation "Baseline nativeMobileDeployment.statusBar.$flag must be true."
        }
    }
    if ((Get-JsonProperty $statusBar "iosViewControllerBasedStatusBarAppearance") -ne $false) {
        Add-Violation "Baseline nativeMobileDeployment.statusBar.iosViewControllerBasedStatusBarAppearance must be false."
    }
    $startupLoading = Get-JsonProperty $nativeMobileDeployment "startupLoading"
    $startupLoadingChecks = @(
        @("displayText", (Get-JsonProperty $startupLoading "displayText"), "Memuat"),
        @("spinnerCssClass", (Get-JsonProperty $startupLoading "spinnerCssClass"), "flat-system-loading-spinner"),
        @("visualReference", (Get-JsonProperty $startupLoading "visualReference"), "FlatReconnectModal.Reconnecting")
    )
    foreach ($check in $startupLoadingChecks) {
        if ($null -eq $check[1] -or $check[1] -cne $check[2]) {
            Add-Violation "Baseline nativeMobileDeployment.startupLoading.$($check[0]) must be '$($check[2])'."
        }
    }
    if ((@((Get-JsonProperty $startupLoading "appliesDuring")) -join "|") -cne "blazor-webview-bootstrap|session-authorization-check") {
        Add-Violation "Baseline nativeMobileDeployment.startupLoading.appliesDuring must contain blazor-webview-bootstrap and session-authorization-check in canonical order."
    }
    foreach ($flag in @(
        "spinnerRequired",
        "textOnlyForbidden",
        "singleSystemLoadingVisual",
        "staticHostMarkupRequiredBeforeRazorInteractive",
        "fullViewport",
        "centered",
        "themeAware",
        "safeAreaAware",
        "reducedMotionFallbackVisible",
        "protectedLayoutBeforeCompletionForbidden"
    )) {
        if ((Get-JsonProperty $startupLoading $flag) -ne $true) {
            Add-Violation "Baseline nativeMobileDeployment.startupLoading.$flag must be true."
        }
    }
    $webViewInteraction = Get-JsonProperty $nativeMobileDeployment "webViewInteraction"
    $webViewInteractionChecks = @(
        @("documentOverscrollBehavior", (Get-JsonProperty $webViewInteraction "documentOverscrollBehavior"), "none"),
        @("androidOverScrollMode", (Get-JsonProperty $webViewInteraction "androidOverScrollMode"), "Never")
    )
    foreach ($check in $webViewInteractionChecks) {
        if ($null -eq $check[1] -or $check[1] -cne $check[2]) {
            Add-Violation "Baseline nativeMobileDeployment.webViewInteraction.$($check[0]) must be '$($check[2])'."
        }
    }
    foreach ($flag in @("ordinaryScrollingPreserved", "rootBounceForbidden", "pullToRefreshRequiresDedicatedControl")) {
        if ((Get-JsonProperty $webViewInteraction $flag) -ne $true) {
            Add-Violation "Baseline nativeMobileDeployment.webViewInteraction.$flag must be true."
        }
    }
    foreach ($flag in @("iosScrollViewBounces", "iosAlwaysBounceVertical")) {
        if ((Get-JsonProperty $webViewInteraction $flag) -ne $false) {
            Add-Violation "Baseline nativeMobileDeployment.webViewInteraction.$flag must be false."
        }
    }
    $textSelection = Get-JsonProperty $webViewInteraction "textSelection"
    $textSelectionChecks = @(
        @("defaultPolicy", (Get-JsonProperty $textSelection "defaultPolicy"), "disabled"),
        @("allowedUserSelect", (Get-JsonProperty $textSelection "allowedUserSelect"), "text"),
        @("outsideAllowedTargetsUserSelect", (Get-JsonProperty $textSelection "outsideAllowedTargetsUserSelect"), "none")
    )
    foreach ($check in $textSelectionChecks) {
        if ($null -eq $check[1] -or $check[1] -cne $check[2]) {
            Add-Violation "Baseline nativeMobileDeployment.webViewInteraction.textSelection.$($check[0]) must be '$($check[2])'."
        }
    }
    if ((@((Get-JsonProperty $textSelection "allowedTargets")) -join "|") -cne "input-text|textarea|contenteditable") {
        Add-Violation "Baseline nativeMobileDeployment.webViewInteraction.textSelection.allowedTargets must contain input-text, textarea, and contenteditable in canonical order."
    }
    foreach ($flag in @("touchCalloutOutsideAllowedTargetsForbidden", "caretAndClipboardPreservedForAllowedTargets")) {
        if ((Get-JsonProperty $textSelection $flag) -ne $true) {
            Add-Violation "Baseline nativeMobileDeployment.webViewInteraction.textSelection.$flag must be true."
        }
    }
    $startupAccessGate = Get-JsonProperty $baseline "startupAccessGate"
    $startupAccessChecks = @(
        @("appliesWhen", (Get-JsonProperty $startupAccessGate "appliesWhen"), "host-authentication-enabled"),
        @("placement", (Get-JsonProperty $startupAccessGate "placement"), "root-before-router"),
        @("rootComponent", (Get-JsonProperty $startupAccessGate "rootComponent"), "RootStartupGate"),
        @("loadingProvider", (Get-JsonProperty $startupAccessGate "loadingProvider"), "FlatMudProviders"),
        @("loadingProviderPlacement", (Get-JsonProperty $startupAccessGate "loadingProviderPlacement"), "checking-branch-before-router"),
        @("loadingTitle", (Get-JsonProperty $startupAccessGate "loadingTitle"), "Memuat halaman"),
        @("loadingTitleSource", (Get-JsonProperty $startupAccessGate "loadingTitleSource"), "OpxFlatUi:Reconnect:StartupTitle"),
        @("loadingMessageSource", (Get-JsonProperty $startupAccessGate "loadingMessageSource"), "OpxFlatUi:Reconnect:StartupMessage"),
        @("loadingVisualReference", (Get-JsonProperty $startupAccessGate "loadingVisualReference"), "FlatReconnectModal.Reconnecting"),
        @("preloaderComponent", (Get-JsonProperty $startupAccessGate "preloaderComponent"), "FlatSessionRestore"),
        @("storageHint", (Get-JsonProperty $startupAccessGate "storageHint"), "local-storage")
    )
    foreach ($check in $startupAccessChecks) {
        if ($null -eq $check[1] -or $check[1] -cne $check[2]) {
            Add-Violation "Baseline startupAccessGate.$($check[0]) must be '$($check[2])'."
        }
    }
    foreach ($flag in @(
        "hostValidationRequired",
        "backendAuthorizationEnforcementRequired",
        "protectedLayoutBeforeValidationForbidden",
        "nestedLoadingProviderForbidden",
        "routerCreationBeforeCompletionForbidden",
        "runsForAnonymousRoutes",
        "preferencesInitializedBeforeValidation",
        "resolvedThemeProviderBeforeValidation",
        "singleFlight",
        "authenticationStateUpdatedBeforeMainLayout",
        "staleSessionClearedOnInvalid"
    )) {
        if ((Get-JsonProperty $startupAccessGate $flag) -ne $true) {
            Add-Violation "Baseline startupAccessGate.$flag must be true."
        }
    }
    if ((Get-JsonProperty $startupAccessGate "localStorageIsAuthorizationAuthority") -ne $false) {
        Add-Violation "Baseline startupAccessGate.localStorageIsAuthorizationAuthority must be false."
    }
    $startupStates = Get-JsonProperty $startupAccessGate "states"
    $startupStateChecks = @(
        @("checking", (Get-JsonProperty $startupStates "checking"), "FlatSessionRestore"),
        @("valid", (Get-JsonProperty $startupStates "valid"), "MainLayout"),
        @("invalid", (Get-JsonProperty $startupStates "invalid"), "Login"),
        @("error", (Get-JsonProperty $startupStates "error"), "Login")
    )
    foreach ($check in $startupStateChecks) {
        if ($null -eq $check[1] -or $check[1] -cne $check[2]) {
            Add-Violation "Baseline startupAccessGate.states.$($check[0]) must be '$($check[2])'."
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
    if ($reference.Include -match "(?i)(^|[\\/])Opx[.]MudBlazor[.]FlatUi[.]csproj$|mudblazor-flat-ui[\\/]src") {
        Add-Violation "Opx.MudBlazor.FlatUi must use the public PackageReference, not ProjectReference '$($reference.Include)'."
    }
}

$nugetPackagesRoot = $null
$assetsPath = Join-Path $projectRoot "obj\project.assets.json"
if (Test-Path -LiteralPath $assetsPath) {
    try {
        $assets = Get-Content -LiteralPath $assetsPath -Raw | ConvertFrom-Json
        $packageFolders = @($assets.packageFolders.PSObject.Properties.Name)
        $packageRelativePath = "opx.mudblazor.flatui\$($expectedPackages['Opx.MudBlazor.FlatUi'])\staticwebassets\opx-flat-ui.css"
        $matchingPackageFolders = @($packageFolders | Where-Object {
            Test-Path -LiteralPath (Join-Path $_ $packageRelativePath)
        })
        if ($matchingPackageFolders.Count -eq 1) {
            $nugetPackagesRoot = $matchingPackageFolders[0]
        }
        elseif ($matchingPackageFolders.Count -gt 1) {
            Add-Violation "Restore produced multiple package folders containing the OPX package asset; its effective source is ambiguous."
        }
        else {
            Add-Violation "No package folder from obj/project.assets.json contains the restored OPX package stylesheet."
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
        Add-Violation "Restored OPX package stylesheet hash must be $expectedPackageCssSha256 for package 2.1.2; found $packageCssHash."
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
    "Components\RootStartupGate.razor",
    "Components\_Imports.razor",
    "Components\Layout\MainLayout.razor",
    "Components\Layout\SampleSidebarMenu.razor",
    "Components\Pages\Home.razor",
    "Services\IRootStartupGateValidator.cs",
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
        "IRootStartupGateValidator",
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
    $rootGateIndex = $appSource.IndexOf('<RootStartupGate', [StringComparison]::Ordinal)
    if ($commentMatches -ne 1 -or $bodyIndex -lt 0 -or $commentIndex -le $bodyIndex -or $rootGateIndex -le $commentIndex) {
        Add-Violation "Components/App.razor must emit exactly one '$poweredByComment' through MarkupString immediately inside the body before RootStartupGate. A literal Razor HTML comment is removed during compilation."
    }
    if ($appSource.Contains('<Router', [StringComparison]::Ordinal) -or $appSource.Contains('<Routes', [StringComparison]::Ordinal)) {
        Add-Violation "Components/App.razor must not create Router or Routes before RootStartupGate completes."
    }
}

$rootStartupGatePath = Join-Path $projectRoot "Components\RootStartupGate.razor"
if (Test-Path -LiteralPath $rootStartupGatePath) {
    $rootStartupGateSource = Get-Content -LiteralPath $rootStartupGatePath -Raw
    foreach ($token in @(
        '@if (!_completed)',
        '<FlatMudProviders IsDarkMode="@IsDarkMode" Palette="@CurrentThemePalette">',
        '<FlatSessionRestore Title="@StartupTitle" Message="@StartupMessage"',
        '</FlatMudProviders>',
        '<Router ',
        'ReconnectOptions.StartupTitle',
        'ReconnectOptions.StartupMessage',
        'DisplayPreferences.InitializeAsync',
        'opxFlatThemeBootstrap.prefersDarkMode',
        'StartupGateValidator.ValidateAsync',
        'OnAfterRenderAsync',
        'RootStartupGateResult.Login'
    )) {
        if (-not $rootStartupGateSource.Contains($token, [StringComparison]::Ordinal)) {
            Add-Violation "Components/RootStartupGate.razor is missing startup-gate behavior '$token'."
        }
    }

    $checkingIndex = $rootStartupGateSource.IndexOf('@if (!_completed)', [StringComparison]::Ordinal)
    $providerIndex = $rootStartupGateSource.IndexOf('<FlatMudProviders ', [StringComparison]::Ordinal)
    $loadingIndex = $rootStartupGateSource.IndexOf('<FlatSessionRestore', [StringComparison]::Ordinal)
    $providerCloseIndex = $rootStartupGateSource.IndexOf('</FlatMudProviders>', [StringComparison]::Ordinal)
    $routerIndex = $rootStartupGateSource.IndexOf('<Router ', [StringComparison]::Ordinal)
    if ($checkingIndex -lt 0 -or $providerIndex -le $checkingIndex -or $loadingIndex -le $providerIndex -or $providerCloseIndex -le $loadingIndex -or $routerIndex -le $providerCloseIndex) {
        Add-Violation "RootStartupGate must render FlatSessionRestore inside FlatMudProviders in the checking branch, then create Router only in the completed branch."
    }
    if ([regex]::Matches($rootStartupGateSource, '<FlatMudProviders(?:\s|>)').Count -ne 1) {
        Add-Violation "RootStartupGate must contain exactly one loading-only FlatMudProviders instance."
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
        "Bottom navigation sample threshold" = 'BottomNavigationMaxWidthPx="900"'
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
        if ((Get-JsonProperty $display "UseAppFontSize") -ne $false) {
            Add-Violation "OpxFlatUi:Display:UseAppFontSize must start false so Device/browser font ownership is the default."
        }
        if ([double](Get-JsonProperty $display "DefaultFontSizePx") -ne 16) {
            Add-Violation "OpxFlatUi:Display:DefaultFontSizePx must start at 16 for Manual font mode."
        }
        if ([int](Get-JsonProperty $display "DefaultRoundedSizePx") -ne 7) {
            Add-Violation "OpxFlatUi:Display:DefaultRoundedSizePx must start at 7 for canonical button corners."
        }
        if ((Get-JsonProperty $display "DefaultColorPalette") -cne "fluent-blue") {
            Add-Violation "OpxFlatUi:Display:DefaultColorPalette must start at fluent-blue."
        }
        if ((Get-JsonProperty $display "DefaultDensity") -cne "Default") {
            Add-Violation "OpxFlatUi:Display:DefaultDensity must start at Default."
        }
        if ((Get-JsonProperty $display "DefaultFabShape") -cne "Circle") {
            Add-Violation "OpxFlatUi:Display:DefaultFabShape must start at Circle."
        }
        if ((Get-JsonProperty $display "DefaultThemeMode") -cne "Light") {
            Add-Violation "OpxFlatUi:Display:DefaultThemeMode must start at Light."
        }

        $reconnect = Get-JsonProperty $opxSettings "Reconnect"
        if ((Get-JsonProperty $reconnect "StartupTitle") -cne "Memuat halaman") {
            Add-Violation "OpxFlatUi:Reconnect:StartupTitle must be 'Memuat halaman'."
        }
        if ((Get-JsonProperty $reconnect "StartupMessage") -cne "Menyiapkan aplikasi...") {
            Add-Violation "OpxFlatUi:Reconnect:StartupMessage must be 'Menyiapkan aplikasi...'."
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

if ($ExactSample) {
    foreach ($entry in $expectedExactSampleHashes.GetEnumerator()) {
        $exactPath = Join-Path $projectRoot $entry.Key
        if (-not (Test-Path -LiteralPath $exactPath)) {
            Add-Violation "Exact Sample Mode is missing canonical file '$($entry.Key)'."
            continue
        }
        $actualHash = Get-NormalizedTextSha256 $exactPath
        if ($actualHash -cne $entry.Value) {
            Add-Violation "Exact Sample Mode drift: '$($entry.Key)' must match normalized SHA-256 $($entry.Value); found $actualHash. Generate the canonical template and integrate through its existing seams instead of approximating the layout."
        }
    }
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
        ".agents\KNOWLEDGE.md",
        ".agents\PROMPTING.md",
        ".agents\skills\opx-flat-ui-development\SKILL.md",
        ".agents\skills\opx-flat-ui-development\references\exact-sample-mode.md",
        ".agents\skills\opx-flat-ui-development\references\page-registry.md",
        ".agents\skills\opx-flat-ui-development\references\showcase-behavior-registry.md",
        ".agents\skills\opx-flat-ui-development\references\layout-decision.md",
        ".agents\skills\opx-flat-ui-development\references\maui-mobile-deployment.md",
        ".agents\skills\opx-flat-ui-development\references\session-authorization-bootstrap.md",
        ".agents\skills\opx-flat-ui-development\references\sample-source-map.md",
        "docs\WIDGETS.md"
    )
    foreach ($relativePath in $contractFiles) {
        if (-not (Test-Path -LiteralPath (Join-Path $contractRoot $relativePath))) {
            Add-Violation "Canonical consumer instruction is missing: $relativePath"
        }
    }
    $promptingPath = Join-Path $contractRoot ".agents\PROMPTING.md"
    if (Test-Path -LiteralPath $promptingPath) {
        $promptingText = Get-Content -LiteralPath $promptingPath -Raw
        if (($promptingText -notmatch 'Saran UI/UX') -or ($promptingText -notmatch '`Wajib`') -or ($promptingText -notmatch '`Disarankan`') -or ($promptingText -notmatch '`Opsional`')) {
            Add-Violation "Canonical prompting contract must preserve the expert UI/UX suggestion format and priorities."
        }
        if (($promptingText -notmatch 'UseAppFontSize=false') -or ($promptingText -notmatch 'system font') -or ($promptingText -notmatch 'no custom app font')) {
            Add-Violation "Canonical prompting contract must default ordinary typography to the device/browser system font without a forced custom app font."
        }
        if (($promptingText -notmatch 'supported NuGet public API') -or ($promptingText -notmatch 'do not silently build a substitute') -or ($promptingText -notmatch 'domain-neutral package suggestion') -or ($promptingText -notmatch 'host-owned domain/integration/native seam')) {
            Add-Violation "Canonical prompting contract must enforce package-first reuse and classify missing capabilities before suggesting work."
        }
        if (($promptingText -notmatch 'FlatMobileGrid') -or ($promptingText -notmatch 'article\.mobile-card') -or ($promptingText -notmatch 'Never improvise a bare `div\.mobile-grid-list`')) {
            Add-Violation "Canonical prompting contract must prohibit manual responsive CRUD/list cards when the package pattern exists."
        }
    }
    $knowledgePath = Join-Path $contractRoot ".agents\KNOWLEDGE.md"
    if (Test-Path -LiteralPath $knowledgePath) {
        $knowledgeText = Get-Content -LiteralPath $knowledgePath -Raw
        if (($knowledgeText -notmatch 'UseAppFontSize=false') -or ($knowledgeText -notmatch 'system UI font stack') -or ($knowledgeText -notmatch 'does not replace the system font family')) {
            Add-Violation "Canonical knowledge must preserve Device ownership for both ordinary font family and accessibility-scaled size."
        }
        if (($knowledgeText -notmatch 'DefaultRoundedSizePx') -or ($knowledgeText -notmatch '`7px` corner radius') -or ($knowledgeText -notmatch 'remain square')) {
            Add-Violation "Canonical knowledge must preserve the package-owned 7px ordinary-button corner baseline."
        }
        if (($knowledgeText -notmatch 'Default color palette') -or ($knowledgeText -notmatch '`fluent-blue`') -or ($knowledgeText -notmatch 'Restore returns')) {
            Add-Violation "Canonical knowledge must preserve fluent-blue as the default color palette."
        }
        if (($knowledgeText -notmatch 'initial spacing preset') -or ($knowledgeText -notmatch 'DefaultDensity="Default"') -or ($knowledgeText -notmatch 'no separate `DefaultSpacing`')) {
            Add-Violation "Canonical knowledge must preserve Default as the package spacing/density baseline."
        }
        if (($knowledgeText -notmatch 'Package-first reuse is mandatory') -or ($knowledgeText -notmatch 'never duplicate package behavior') -or ($knowledgeText -notmatch 'Package changes and publication require explicit approval')) {
            Add-Violation "Canonical knowledge must preserve package-first reuse and the approval boundary for package changes."
        }
        if (($knowledgeText -notmatch 'FlatMobileGrid') -or ($knowledgeText -notmatch 'article\.mobile-card') -or ($knowledgeText -notmatch 'bare manual `div\.mobile-grid-list`') -or ($knowledgeText -notmatch 'consumer integration defect')) {
            Add-Violation "Canonical knowledge must preserve the package-owned responsive card DOM contract."
        }
    }
}

if ($violations.Count -gt 0) {
    $violations | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Output "OPX Flat UI consumer audit passed for '$($project.FullName)' (contract $expectedContractVersion$(if ($ExactSample) { ', Exact Sample Mode' }))."
