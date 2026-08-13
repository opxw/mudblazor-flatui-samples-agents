# Copyright (c) 2026 opx. All rights reserved.

param(
    [Parameter(Mandatory = $false)]
    [string]$Workspace = (Get-Location).Path
)

$requiredFiles = @(
    'ROADMAP.md',
    'RULES.md',
    '.agents\AGENTS.md',
    '.agents\RULES.md',
    '.agents\skills\opx-flat-ui-development\SKILL.md',
    '.agents\skills\opx-flat-ui-development\references\sample-source-map.md',
    'samples\Opx.MudBlazor.FlatUi.Sample\Components\Pages\Crud.razor',
    'samples\Opx.MudBlazor.FlatUi.Sample\Components\Pages\DataGridLarge.razor',
    'samples\Opx.MudBlazor.FlatUi.Sample\Components\Pages\GridEditor.razor',
    'samples\Opx.MudBlazor.FlatUi.Sample\Components\Pages\AiChat.razor',
    'samples\Opx.MudBlazor.FlatUi.Sample\Components\Pages\Email.razor',
    'samples\Opx.MudBlazor.FlatUi.Sample\Components\Pages\Charts.razor',
    'samples\Opx.MudBlazor.FlatUi.Sample\Components\Pages\FileUpload.razor',
    'samples\Opx.MudBlazor.FlatUi.Sample\Components\Pages\GridPreferences.razor',
    'samples\Opx.MudBlazor.FlatUi.Sample\Components\Pages\Pivot.razor',
    'samples\Opx.MudBlazor.FlatUi.Sample\Components\ChartCode.razor',
    'samples\Opx.MudBlazor.FlatUi.Sample\Components\Pages\Login.razor',
    'samples\Opx.MudBlazor.FlatUi.Sample\Components\Pages\NotFound.razor',
    'samples\Opx.MudBlazor.FlatUi.Sample\Components\Pages\ResetPassword.razor',
    'samples\Opx.MudBlazor.FlatUi.Sample\Components\App.razor',
    'samples\Opx.MudBlazor.FlatUi.Sample\appsettings.json',
    'samples\Opx.MudBlazor.FlatUi.Sample\Components\Layout\MainLayout.razor',
    'src\Opx.MudBlazor.FlatUi\Components\FlatPage.razor',
    'src\Opx.MudBlazor.FlatUi\Components\FlatChatShell.razor',
    'src\Opx.MudBlazor.FlatUi\Components\FlatNavigationBadge.razor',
    'src\Opx.MudBlazor.FlatUi\Components\FlatFileUpload.razor',
    'src\Opx.MudBlazor.FlatUi\Components\Grid\FlatGridPreferencesPanel.razor',
    'src\Opx.MudBlazor.FlatUi\Components\Grid\FlatEditableGrid.razor',
    'src\Opx.MudBlazor.FlatUi\Components\Grid\FlatGridEditResult.cs',
    'src\Opx.MudBlazor.FlatUi\Components\Reporting\FlatPivotGrid.razor',
    'src\Opx.MudBlazor.FlatUi\Models\FlatApplicationOptions.cs',
    'src\Opx.MudBlazor.FlatUi\Models\FlatAssetOptions.cs',
    'src\Opx.MudBlazor.FlatUi\Models\FlatFileUploadModels.cs',
    'src\Opx.MudBlazor.FlatUi\Models\FlatGridPreferences.cs',
    'src\Opx.MudBlazor.FlatUi\Models\FlatPivotModels.cs',
    'src\Opx.MudBlazor.FlatUi\wwwroot\opx-flat-ui.css',
    'src\Opx.MudBlazor.FlatUi\wwwroot\opx-flat-ui.js',
    'package.json',
    'package-lock.json',
    'docs\API-GRID-LOADING.md',
    'docs\ASSET-PIPELINE.md',
    'docs\EDITABLE-GRID.md',
    'docs\EMAIL-TEMPLATE.md',
    'docs\CHARTS.md',
    'docs\TESTING.md',
    'docs\FILE-UPLOAD.md',
    'docs\GRID-PREFERENCES.md',
    'docs\PIVOT-GRID.md',
    'docs\AI-CHAT-TEMPLATE.md'
)

$violations = [System.Collections.Generic.List[string]]::new()
foreach ($relativePath in $requiredFiles) {
    $resolvedPath = Join-Path $Workspace $relativePath
    if (-not (Test-Path -LiteralPath $resolvedPath)) {
        $violations.Add("Required source-of-truth file is missing: $relativePath")
    }
}

$sidebarSamplePath = Join-Path $Workspace 'samples\Opx.MudBlazor.FlatUi.Sample\Components\Layout\SampleSidebarMenu.razor'
$navigationBadgePath = Join-Path $Workspace 'src\Opx.MudBlazor.FlatUi\Components\FlatNavigationBadge.razor'
if ((Test-Path -LiteralPath $sidebarSamplePath) -and (Test-Path -LiteralPath $navigationBadgePath)) {
    $sidebarSample = Get-Content -LiteralPath $sidebarSamplePath -Raw
    $navigationBadge = Get-Content -LiteralPath $navigationBadgePath -Raw
    if ($sidebarSample -notmatch '<FlatNavigationBadge\b' -or
        $sidebarSample -notmatch '<TitleContent>' -or
        $navigationBadge -notmatch 'AccessibleLabel' -or
        $navigationBadge -notmatch 'Color\s+Color') {
        $violations.Add('Sidebar badge support must retain leaf/group samples, semantic color, and accessible labeling')
    }
}

$roadmapPath = Join-Path $Workspace 'ROADMAP.md'
if (Test-Path -LiteralPath $roadmapPath) {
    $roadmap = Get-Content -LiteralPath $roadmapPath -Raw
    $requiredRoadmapMarkers = @(
        'Target release: `1.1.0`',
        'Phase 1 — Automated test foundation',
        'Phase 2 — FlatFileUpload',
        'Phase 3 — Advanced grid preferences',
        'public API compatibility'
    )

    foreach ($marker in $requiredRoadmapMarkers) {
        if (-not $roadmap.Contains($marker)) {
            $violations.Add("ROADMAP.md is missing the approved marker: $marker")
        }
    }

    $phase1 = $roadmap.IndexOf('Phase 1 — Automated test foundation')
    $phase2 = $roadmap.IndexOf('Phase 2 — FlatFileUpload')
    $phase3 = $roadmap.IndexOf('Phase 3 — Advanced grid preferences')
    if ($phase1 -lt 0 -or $phase2 -le $phase1 -or $phase3 -le $phase2) {
        $violations.Add('ROADMAP.md must keep the approved phase order: automated tests, FlatFileUpload, advanced grid preferences')
    }
}

$agentRoot = Join-Path $Workspace '.agents'
if (Test-Path -LiteralPath $agentRoot) {
    Get-ChildItem -LiteralPath $agentRoot -Recurse -File | ForEach-Object {
        $content = Get-Content -LiteralPath $_.FullName -Raw
        if ($content -match '\[TODO[:\]]') {
            $violations.Add("Agent file contains an unresolved TODO: $($_.FullName)")
        }
    }
}

$pageRoot = Join-Path $Workspace 'samples\Opx.MudBlazor.FlatUi.Sample\Components\Pages'
$pages = @()

$displayOptionsPath = Join-Path $Workspace 'src\Opx.MudBlazor.FlatUi\Models\FlatUiDisplayPreferences.cs'
$themePath = Join-Path $Workspace 'src\Opx.MudBlazor.FlatUi\Models\FlatUiTheme.cs'
$sharedCssPath = Join-Path $Workspace 'src\Opx.MudBlazor.FlatUi\wwwroot\opx-flat-ui.css'
$sharedJsPath = Join-Path $Workspace 'src\Opx.MudBlazor.FlatUi\wwwroot\opx-flat-ui.js'
if ((Test-Path -LiteralPath $displayOptionsPath) -and
    (Test-Path -LiteralPath $themePath) -and
    (Test-Path -LiteralPath $sharedCssPath) -and
    (Test-Path -LiteralPath $sharedJsPath)) {
    $displayOptionsSource = Get-Content -LiteralPath $displayOptionsPath -Raw
    $themeSource = Get-Content -LiteralPath $themePath -Raw
    $sharedCss = Get-Content -LiteralPath $sharedCssPath -Raw
    $sharedJs = Get-Content -LiteralPath $sharedJsPath -Raw
    if ($displayOptionsSource -notmatch 'Accent\s*\{[^}]*\}\s*=\s*"#004a77"' -or
        $displayOptionsSource -notmatch 'DarkAccent\s*\{[^}]*\}\s*=\s*"#004a77"' -or
        $themeSource -notmatch 'string\s+Accent\s*=\s*"#004a77"' -or
        $sharedCss -notmatch '--opx-accent-light:#004a77' -or
        $sharedCss -notmatch '--opx-accent-night:#004a77' -or
        $sharedJs -notmatch 'accent:\s*colorOr\(sourcePalette\.accent,\s*"#004a77"\)' -or
        $sharedJs -notmatch 'darkAccent:\s*colorOr\(sourcePalette\.darkAccent,\s*"#004a77"\)') {
        $violations.Add('The built-in blue palette must keep the reference #004a77 Primary surface in Light and Dark/Night')
    }

    if ($sharedJs -notmatch 'resistedDistance' -or
        $sharedJs -notmatch 'horizontalDelta\s*>\s*rawDelta\s*\?\s*"horizontal"' -or
        $sharedJs -notmatch 'setIndicator\("refreshing"' -or
        $sharedJs -notmatch 'minimumRefreshVisibleMs' -or
        $sharedJs -notmatch 'settleIndicator' -or
        $sharedCss -notmatch '--pull-distance' -or
        $sharedCss -notmatch 'pull-refresh-spin') {
        $violations.Add('Shared pull-to-refresh must retain native-like resistance, direction lock, held refresh state, and snap-back')
    }

    $emailPagePath = Join-Path $Workspace 'samples\Opx.MudBlazor.FlatUi.Sample\Components\Pages\Email.razor'
    if ((Test-Path -LiteralPath $emailPagePath) -and
        ((Get-Content -LiteralPath $emailPagePath -Raw) -notmatch 'class="flat-email-sender-copy"' -or
         $sharedCss -notmatch '\.flat-email-sender-card>\.flat-profile-avatar\{display:grid!important\}')) {
        $violations.Add('Email sender rows must keep FlatProfileAvatar grid-centered and scope text to flat-email-sender-copy')
    }
}

if (Test-Path -LiteralPath $pageRoot) {
    $pages = Get-ChildItem -LiteralPath $pageRoot -Filter '*.razor' -File
    foreach ($page in $pages) {
        $content = Get-Content -LiteralPath $page.FullName -Raw
        $isOperational = $content -match '<FlatPage\b' -and $content -match '(FlatDataGrid|FlatMobileGrid|FlatCardGrid|module-table|erp-desktop-table|CrudEditorShell|FlatFormModal)'

        if ($isOperational -and $content -match '<BeforePanel>') {
            $violations.Add("$($page.Name): operational grid/list page reserves BeforePanel content")
        }
        if ($content -match 'PullToRefreshEnabled\s*=\s*"true"' -and $content -notmatch 'OnRefresh\s*=') {
            $violations.Add("$($page.Name): pull-to-refresh is enabled without OnRefresh")
        }
        if ($content -match '(FilterEnabled|FilterVisible)\s*=\s*"true"' -and $content -notmatch 'OnFilter\s*=') {
            $violations.Add("$($page.Name): toolbar filter is visible/enabled without OnFilter")
        }
        if ($content -match '<FlatDataGrid\b' -and $content -match '<MobileGridFilterSheet\b') {
            if ($content -match '(FilterEnabled|FilterVisible)\s*=\s*"true"') {
                $violations.Add("$($page.Name): responsive grid filter visibility is unconditional instead of column-driven")
            }

            $grid = [regex]::Match($content, '<FlatDataGrid\b(?<attributes>(?:[^>"'']|"[^"]*"|''[^'']*'')*)>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
            $sheet = [regex]::Match($content, '<MobileGridFilterSheet\b(?<attributes>(?:[^>"'']|"[^"]*"|''[^'']*'')*)>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
            $gridColumns = [regex]::Match($grid.Groups['attributes'].Value, '\bColumns\s*=\s*"@?(?<value>[^"]+)"').Groups['value'].Value
            $sheetColumns = [regex]::Match($sheet.Groups['attributes'].Value, '\bColumns\s*=\s*"@?(?<value>[^"]+)"').Groups['value'].Value
            $gridState = [regex]::Match($grid.Groups['attributes'].Value, '\bState\s*=\s*"@?(?<value>[^"]+)"').Groups['value'].Value
            $sheetState = [regex]::Match($sheet.Groups['attributes'].Value, '\bState\s*=\s*"@?(?<value>[^"]+)"').Groups['value'].Value

            if ([string]::IsNullOrWhiteSpace($gridColumns) -or
                [string]::IsNullOrWhiteSpace($sheetColumns) -or
                $gridColumns -cne $sheetColumns -or
                [string]::IsNullOrWhiteSpace($gridState) -or
                [string]::IsNullOrWhiteSpace($sheetState) -or
                $gridState -cne $sheetState) {
                $violations.Add("$($page.Name): desktop grid and mobile filter sheet must share the same Columns and GridViewState")
            }
        }
        if ($content -match '<MobilePrimaryAction>' -and $content -notmatch 'ShowMobilePrimaryAction\s*=\s*"true"') {
            $violations.Add("$($page.Name): MobilePrimaryAction is present without ShowMobilePrimaryAction=true")
        }
        if ($content -match 'PrimaryActionVisible\s*=\s*"true"' -and $content -notmatch 'OnPrimaryAction\s*=') {
            $violations.Add("$($page.Name): automatic primary action is visible without OnPrimaryAction")
        }
        if ($content -match 'PrimaryActionVisible\s*=\s*"true"' -and $content -match '<MobilePrimaryAction>') {
            $violations.Add("$($page.Name): automatic primary action conflicts with a manual MobilePrimaryAction slot")
        }
        if ($content -match 'PrimaryActionVisible\s*=\s*"true"' -and $content -match 'ReadOnlySource\s*=') {
            $violations.Add("$($page.Name): read-only page cannot expose an automatic primary action")
        }
        if ($page.Name -in @('Crud.razor', 'SimpleCrud.razor') -and $content -notmatch 'PrimaryActionVisible\s*=\s*"true"') {
            $violations.Add("$($page.Name): CRUD source-of-truth page must use the automatic FlatPage primary action")
        }
        if ($content -match '<FlatFab\b[^>]*Extended\s*=\s*"true"') {
            $violations.Add("$($page.Name): mobile FAB is extended instead of icon-only")
        }
        if ($content -match 'ReadOnlySource\s*=' -and
            $content -match '(<CrudEditorShell\b|<FlatFormModal\b|<MobilePrimaryAction>|OnClick\s*=\s*"[^"]*(Create|Edit|Delete|OpenCreate))') {
            $violations.Add("$($page.Name): read-only marker conflicts with source-mutation actions")
        }
    }
}

$flatUiCssPath = Join-Path $Workspace 'src\Opx.MudBlazor.FlatUi\wwwroot\opx-flat-ui.css'
$largeGridPath = Join-Path $Workspace 'samples\Opx.MudBlazor.FlatUi.Sample\Components\Pages\DataGridLarge.razor'
if ((Test-Path -LiteralPath $flatUiCssPath) -and (Test-Path -LiteralPath $largeGridPath)) {
    $flatUiCss = Get-Content -LiteralPath $flatUiCssPath -Raw
    $largeGrid = Get-Content -LiteralPath $largeGridPath -Raw
    if ($flatUiCss -notmatch '\.module-panel>div:has\(>\.flat-data-grid-shell\)') {
        $violations.Add('FlatDataGrid custom direct hosts are not bounded by the reusable desktop selector')
    }
    if ($flatUiCss -notmatch '@media\(max-width:900px\).*?\.module-panel:has\(>\.mobile-grid-list\)>div:has\(>\.flat-data-grid-shell\)') {
        $violations.Add('FlatDataGrid custom direct hosts are not hidden with the equivalent mobile grid')
    }
    if ($largeGrid -notmatch '<div class="large-grid-host">\s*<FlatDataGrid') {
        $violations.Add('DataGridLarge must exercise a custom direct FlatDataGrid host')
    }
}

$editableGridPath = Join-Path $Workspace 'src\Opx.MudBlazor.FlatUi\Components\Grid\FlatEditableGrid.razor'
$editableGridSamplePath = Join-Path $Workspace 'samples\Opx.MudBlazor.FlatUi.Sample\Components\Pages\GridEditor.razor'
if ((Test-Path -LiteralPath $editableGridPath) -and (Test-Path -LiteralPath $editableGridSamplePath)) {
    $editableGrid = Get-Content -LiteralPath $editableGridPath -Raw
    $editableGridSample = Get-Content -LiteralPath $editableGridSamplePath -Raw
    if ($editableGrid -notmatch 'CloneItem' -or
        $editableGrid -notmatch 'CancellationToken' -or
        $editableGrid -notmatch 'FlatGridEditResult<TItem>' -or
        $editableGrid -notmatch 'EventCallback<FlatGridRowResult<TItem>> RowResult' -or
        $editableGrid -notmatch 'flat-editable-grid-mobile') {
        $violations.Add('FlatEditableGrid must preserve isolated drafts, cancellable result callbacks, and responsive card editing')
    }
    if ($editableGridSample -notmatch 'PrimaryActionVisible\s*=\s*"true"' -or
        $editableGridSample -notmatch '<FlatEditableGrid' -or
        $editableGridSample -notmatch 'ConfirmDelete=' -or
        $editableGridSample -notmatch 'SaveRow=' -or
        $editableGridSample -notmatch 'RowResult=' -or
        $editableGridSample -match 'AddVisible\s*=\s*"true"') {
        $violations.Add('GridEditor sample must use the FlatPage Add/FAB contract and explicit delete confirmation')
    }
}

$loginPath = Join-Path $Workspace 'samples\Opx.MudBlazor.FlatUi.Sample\Components\Pages\Login.razor'
$resetPasswordPath = Join-Path $Workspace 'samples\Opx.MudBlazor.FlatUi.Sample\Components\Pages\ResetPassword.razor'
if (Test-Path -LiteralPath $flatUiCssPath) {
    $flatUiCss = Get-Content -LiteralPath $flatUiCssPath -Raw
    if ($flatUiCss -notmatch '(?s)html\.opx-root-theme-dark \.opx-password-visibility-field.*?color:#fff!important' -or
        $flatUiCss -notmatch '(?s)\.opx-password-visibility-field.*?color:#212529!important') {
        $violations.Add('Password visibility icon does not define inverse Light/Dark theme contrast')
    }
    if ($flatUiCss -notmatch 'input:autofill' -or
        $flatUiCss -notmatch 'input:-webkit-autofill:hover' -or
        $flatUiCss -notmatch 'input:-webkit-autofill:focus' -or
        $flatUiCss -notmatch 'input:-webkit-autofill:active' -or
        $flatUiCss -notmatch '--opx-field-autofill-background:var\(--opx-field-control-background\)' -or
        $flatUiCss -notmatch '-webkit-text-fill-color:var\(--opx-field-autofill-foreground\)!important' -or
        $flatUiCss -notmatch '(?s)\.global-search input:autofill.*?box-shadow:none!important') {
        $violations.Add('Browser autofill must preserve the resolved field background, foreground, and interaction states')
    }
    if ($flatUiCss -notmatch '(?s)\.mud-input\.mud-input-outlined\s*\{.*?background-color:var\(--opx-field-control-background\)!important' -or
        $flatUiCss -notmatch '(?s)\.global-search \.mud-input\.mud-input-outlined\s*\{.*?background-color:transparent!important' -or
        $flatUiCss -notmatch '--opx-field-control-background:#262a2f') {
        $violations.Add('Outlined fields must own one continuous theme surface across value and adornment areas')
    }
    if ($flatUiCss -notmatch '--opx-checkbox-checked:var\(--accent\)' -or
        $flatUiCss -notmatch '(?s)\.mud-checkbox \.mud-icon-button\.mud-default-text:not\(\.mud-disabled\)\.mud-checkbox-true.*?color:var\(--opx-checkbox-checked\)!important' -or
        $flatUiCss -notmatch '(?s)\.mud-checkbox \.mud-icon-button\.mud-disabled.*?background-color:transparent!important.*?color:var\(--opx-checkbox-disabled\)!important') {
        $violations.Add('Checkbox enabled and disabled states must keep explicit Light/Dark contrast')
    }
}
foreach ($authPagePath in @($loginPath, $resetPasswordPath)) {
    if (Test-Path -LiteralPath $authPagePath) {
        $authPage = Get-Content -LiteralPath $authPagePath -Raw
        if ($authPage -match 'OnAdornmentClick\s*=' -and $authPage -notmatch 'Class="opx-password-visibility-field"') {
            $violations.Add("$([IO.Path]::GetFileName($authPagePath)): show/hide password field must use opx-password-visibility-field")
        }
        if ($authPage -match 'OnAdornmentClick\s*=' -and $authPage -notmatch 'AdornmentAriaLabel\s*=') {
            $violations.Add("$([IO.Path]::GetFileName($authPagePath)): show/hide password action must define AdornmentAriaLabel")
        }
    }
}

if (Test-Path -LiteralPath $loginPath) {
    $loginPage = Get-Content -LiteralPath $loginPath -Raw
    $sampleSettingsPath = Join-Path $Workspace 'samples\Opx.MudBlazor.FlatUi.Sample\appsettings.json'
    $sampleSettings = Get-Content -LiteralPath $sampleSettingsPath -Raw
    if ($loginPage -notmatch '@inject\s+FlatApplicationOptions\s+ApplicationOptions' -or
        $loginPage -notmatch 'ApplicationOptions\.ResolvedAppName' -or
        $loginPage -notmatch 'ApplicationOptions\.ResolvedCompanyName' -or
        $loginPage -notmatch 'ApplicationOptions\.HasResolvedLogo' -or
        $loginPage -notmatch 'ApplicationOptions\.ResolvedLoginBrandBackgroundColor' -or
        $loginPage -notmatch 'ApplicationOptions\.ResolvedLoginBrandBackgroundImageUrl') {
        $violations.Add('Login branding must render from FlatApplicationOptions')
    }
    if ($loginPage -match 'login-demo-note|login-security-note|mobile-login-brand|Sample only|Protected sign-in') {
        $violations.Add('Login must omit static security/sample banners and the duplicate top mobile identity row')
    }
    if ($loginPage -notmatch 'SampleUsername' -or
        $loginPage -notmatch 'SamplePassword' -or
        $loginPage -notmatch 'MessageBox\.ErrorAsync' -or
        $loginPage -notmatch 'username or password is incorrect') {
        $violations.Add('Login sample must route invalid credentials through the generic Error MessageBox simulation')
    }
    if ($sampleSettings -notmatch '"Application"\s*:' -or
        $sampleSettings -notmatch '"AppName"\s*:' -or
        $sampleSettings -notmatch '"CompanyName"\s*:' -or
        $sampleSettings -notmatch '"LoginBrandBackgroundColor"\s*:' -or
        $sampleSettings -notmatch '"LoginBrandBackgroundImageUrl"\s*:' -or
        $sampleSettings -notmatch '"LoginBrandOverlayColor"\s*:' -or
        $sampleSettings -notmatch '"LoginBrandOverlayOpacity"\s*:') {
        $violations.Add('Initial host appsettings must provide the complete OpxFlatUi Application and Login background branding baseline')
    }
}

$appDocumentPath = Join-Path $Workspace 'samples\Opx.MudBlazor.FlatUi.Sample\Components\App.razor'
if (Test-Path -LiteralPath $appDocumentPath) {
    $appDocument = Get-Content -LiteralPath $appDocumentPath -Raw
    $applicationOptionsPath = Join-Path $Workspace 'src\Opx.MudBlazor.FlatUi\Models\FlatApplicationOptions.cs'
    $applicationOptionsSource = Get-Content -LiteralPath $applicationOptionsPath -Raw
    $sampleSettingsPath = Join-Path $Workspace 'samples\Opx.MudBlazor.FlatUi.Sample\appsettings.json'
    $sampleSettings = Get-Content -LiteralPath $sampleSettingsPath -Raw
    if ($appDocument -notmatch '(?s)\[Inject\]\s*private\s+FlatApplicationOptions\s+ApplicationOptions' -or
        $appDocument -notmatch '<meta\s+name="author"\s+content="@ApplicationOptions\.ResolvedAuthor"\s*/>') {
        $violations.Add('The host document must expose the resolved global author metadata for every route')
    }
    if ($applicationOptionsSource -notmatch 'public\s+string\s+Author\s*\{[^}]*\}\s*=\s*"opx"' -or
        $applicationOptionsSource -notmatch 'ResolvedAuthor\s*=>\s*Resolve\(Author,\s*"opx"\)') {
        $violations.Add('FlatApplicationOptions must provide the normalized opx author default')
    }
    if ($sampleSettings -notmatch '"Author"\s*:\s*"opx"') {
        $violations.Add('Initial host appsettings must seed OpxFlatUi Application Author as opx')
    }

    $assetOptionsPath = Join-Path $Workspace 'src\Opx.MudBlazor.FlatUi\Models\FlatAssetOptions.cs'
    $rclProjectPath = Join-Path $Workspace 'src\Opx.MudBlazor.FlatUi\Opx.MudBlazor.FlatUi.csproj'
    $packageJsonPath = Join-Path $Workspace 'package.json'
    if ((Test-Path -LiteralPath $assetOptionsPath) -and
        (Test-Path -LiteralPath $rclProjectPath) -and
        (Test-Path -LiteralPath $packageJsonPath)) {
        $assetOptionsSource = Get-Content -LiteralPath $assetOptionsPath -Raw
        $rclProject = Get-Content -LiteralPath $rclProjectPath -Raw
        $packageJson = Get-Content -LiteralPath $packageJsonPath -Raw
        if ($assetOptionsSource -notmatch 'UseMinifiedJavaScript\s*\{[^}]*\}\s*=\s*true' -or
            $assetOptionsSource -notmatch 'ResolveJavaScriptPath\(bool\s+isDebugBuild\)' -or
            $appDocument -notmatch 'AssetOptions\.ResolveJavaScriptPath\(IsDebugBuild\)' -or
            $sampleSettings -notmatch '"Assets"\s*:\s*\{\s*"UseMinifiedJavaScript"\s*:\s*true' -or
            $rclProject -notmatch 'GenerateFlatUiMinifiedJavaScript' -or
            $packageJson -notmatch '"terser"\s*:\s*"5\.49\.0"') {
            $violations.Add('JavaScript assets must keep typed Debug/Release selection and deterministic pinned Release minification')
        }
    }
}

$notFoundPath = Join-Path $Workspace 'samples\Opx.MudBlazor.FlatUi.Sample\Components\Pages\NotFound.razor'
$mainLayoutPath = Join-Path $Workspace 'samples\Opx.MudBlazor.FlatUi.Sample\Components\Layout\MainLayout.razor'
$sampleCssPath = Join-Path $Workspace 'samples\Opx.MudBlazor.FlatUi.Sample\wwwroot\app.css'
if ((Test-Path -LiteralPath $notFoundPath) -and
    (Test-Path -LiteralPath $mainLayoutPath) -and
    (Test-Path -LiteralPath $sampleCssPath)) {
    $notFoundPage = Get-Content -LiteralPath $notFoundPath -Raw
    $mainLayout = Get-Content -LiteralPath $mainLayoutPath -Raw
    $sampleCss = Get-Content -LiteralPath $sampleCssPath -Raw

    if ($notFoundPage -notmatch 'page-content\s+no-mobile-fab\s+not-found-page' -or
        $sampleCss -notmatch '\.not-found-page\{' -or
        $sampleCss -notmatch '@media\(max-width:760px\)\{\.not-found-page\{padding:16px\}\}') {
        $violations.Add('Not Found must use standard content gutters including 16px mobile padding')
    }
    if ($mainLayout -notmatch '_\s*=>\s*"Not found"') {
        $violations.Add('Unknown routes must resolve the AppBar PageTitle to Not found')
    }
    if ($sampleCss -match 'login-security-note|mobile-login-brand') {
        $violations.Add('Login CSS retains a removed security banner or duplicate top mobile identity selector')
    }
}

$gridSkeletonPath = Join-Path $Workspace 'src\Opx.MudBlazor.FlatUi\Components\Grid\FlatDataGridSkeleton.razor'
$largeGridPath = Join-Path $Workspace 'samples\Opx.MudBlazor.FlatUi.Sample\Components\Pages\DataGridLarge.razor'
if (-not (Test-Path -LiteralPath $gridSkeletonPath)) {
    $violations.Add('FlatDataGridSkeleton reusable initial-load component is missing')
}
elseif (Test-Path -LiteralPath $largeGridPath) {
    $gridSkeleton = Get-Content -LiteralPath $gridSkeletonPath -Raw
    $largeGrid = Get-Content -LiteralPath $largeGridPath -Raw
    if ($gridSkeleton -notmatch '<MudSkeleton' -or
        $gridSkeleton -notmatch 'flat-data-grid-skeleton-desktop' -or
        $gridSkeleton -notmatch 'flat-data-grid-skeleton-mobile' -or
        $largeGrid -notmatch 'InitialLoading="@_initialLoading"' -or
        $largeGrid -notmatch 'SkeletonColumnCount="12"' -or
        $largeGrid -notmatch '_initialLoading') {
        $violations.Add('Large grid initial loading must use FlatPage automatic responsive skeleton loading')
    }
}

$flatPagePath = Join-Path $Workspace 'src\Opx.MudBlazor.FlatUi\Components\FlatPage.razor'
$pageSkeletonPath = Join-Path $Workspace 'src\Opx.MudBlazor.FlatUi\Components\FlatPageSkeleton.razor'
if (-not (Test-Path -LiteralPath $flatPagePath) -or -not (Test-Path -LiteralPath $pageSkeletonPath)) {
    $violations.Add('Automatic FlatPage skeleton components are missing')
}
else {
    $flatPage = Get-Content -LiteralPath $flatPagePath -Raw
    $pageSkeleton = Get-Content -LiteralPath $pageSkeletonPath -Raw
    if ($flatPage -notmatch 'InitialLoading' -or
        $flatPage -notmatch 'LoadingContent' -or
        $pageSkeleton -notmatch 'FlatPageKind\.Module\s*=>\s*FlatPageSkeletonTemplate\.DataGrid') {
        $violations.Add('FlatPage must expose automatic initial skeleton loading with per-page overrides')
    }
}

$chartsSamplePath = Join-Path $Workspace 'samples\Opx.MudBlazor.FlatUi.Sample\Components\Pages\Charts.razor'
if (Test-Path -LiteralPath $chartsSamplePath) {
    $chartsSample = Get-Content -LiteralPath $chartsSamplePath -Raw
    $requiredChartTypes = @('Line', 'Bar', 'StackedBar', 'Pie', 'Donut', 'Timeseries', 'HeatMap', 'Rose', 'Radar', 'Sankey', 'ScatterPlot')
    foreach ($chartType in $requiredChartTypes) {
        if ($chartsSample -notmatch [regex]::Escape("ChartType.$chartType")) {
            $violations.Add("Charts sample must include MudBlazor ChartType.$chartType")
        }
    }
    if ($chartsSample -notmatch '<ChartCode\s+Code=') {
        $violations.Add('Charts sample must retain expandable copy-ready Razor code for every chart type')
    }
}

if ($violations.Count -gt 0) {
    $violations | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Output "OPX Flat UI repository audit passed ($($pages.Count) Razor pages checked)."
