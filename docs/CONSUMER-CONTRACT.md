# OPX Flat UI consumer contract

Copyright (c) 2026 opx. All rights reserved.

Use the repository templates when a new Blazor Web or Android/iOS MAUI Blazor Hybrid project must reproduce the compiled OPX Flat UI composition. Both templates carry repository rules, agent skill, NuGet.org configuration, and a versioned consumer contract; the MAUI template additionally owns the native host boundary.

## Create a consumer

From this repository root:

```powershell
dotnet new install .
dotnet new opx-flatui-web -n MyCompany.MyApp
Set-Location MyCompany.MyApp\MyCompany.MyApp
& .\run-clean.ps1 -PrepareOnly
& ..\.agents\skills\opx-flat-ui-development\scripts\audit_flat_ui_consumer.ps1 -ProjectPath . -ExactSample
dotnet build -c Release --no-restore --nologo
& .\run-clean.ps1
```

The generated project remains in public NuGet package mode. Do not replace `Opx.MudBlazor.FlatUi` with a source `ProjectReference`.

For a native Android/iOS host, create and audit the dedicated template:

```powershell
dotnet new opx-flatui-maui -n MyCompany.MyMobileApp
Set-Location MyCompany.MyMobileApp
& .\run-clean.ps1 -PrepareOnly
& .\scripts\audit_maui_consumer.ps1 -ProjectPath . -ExactSample
dotnet build -f net10.0-android -c Release --no-restore
```

Its `flat-ui.mobile.contract.json` pins MAUI `10.0.90`, CommunityToolkit.Maui `15.0.1`, MudBlazor `9.9.0`, and OPX Flat UI `2.1.6`. Android compilation is required source evidence; iOS build/runtime and all native UX claims still require macOS/Xcode plus simulator/device evidence.

## Required workflow

1. Read `RULES.md`, `.agents/AGENTS.md`, `.agents/RULES.md`, and the development skill.
2. Read `flat-ui.contract.json` and keep its package, clean initial-run, stylesheet ownership, runtime HTML attribution, theme, adaptive responsive boundaries, native-mobile deployment, startup access gate, mandatory shell, and widget-spacing baseline values aligned with the installed contract.
3. Resolve the requested UI to one canonical `PageId` in `page-registry.md`.
4. Open the mapped archetype and every shared component it directly uses.
5. Inspect and reuse the supported NuGet public component, option, callback, service seam, CSS, or JavaScript behavior before creating any local substitute. If the capability is absent, classify it as a reusable package suggestion or a host-owned domain/integration/native seam; do not change or publish the package without explicit approval.
6. Keep the initialized admin shell complete: host `MainLayout.razor` exposes the AppBar three-dot menu with `Settings`, its Application preferences modal, and Light/Dark/Auto choices; shared `ShowcaseNavigationCatalog` supplies Dashboard `/`, initial groups, search, and route titles. In the seeded user block, keep Logout last and right-aligned while avatar/copy remain left. Seed labels, permissions, identity data, and actual logout/session behavior remain host-owned.
7. Adapt only branding, wording, data, authorization, and domain integration. Start with the Light default theme and preserve composition, responsive behavior, theme tokens, widget padding/margins/gaps, loading, modal, toolbar, grid, and FAB contracts. For widgets, use the parent grid gap and do not add outer margins to individual cards; follow `docs/WIDGETS.md`.
8. Run the consumer audit with `-ExactSample`, Release build, and representative desktop/mobile Light/Dark browser validation.

Exact Sample Mode is mandatory when the request says the result must be the same, exact, canonical, like the sample, or follow the source of truth. Generate a fresh canonical consumer and pass the unchanged hash baseline before integration. Then replace only host-owned branding, wording, data, authorization, callbacks, endpoints, and persistence through the sample's existing seams. If the application differs while the fresh reference is correct, treat it as integration drift; investigate the package only when the same defect reproduces in the verified fresh reference.

## Adaptive responsive design

Responsive behavior is a composition contract, not desktop scaling. Keep table/desktop presentation above `900px`, equivalent responsive cards at `900px` and below, two-column cards from `601px` through `900px`, and single-column phone refinement at `600px` and below. Preserve one query, selection, permission, loading, validation, and mutation state across representations. Use viewport/container CSS rather than Android/iOS user-agent checks, perform desktop -> responsive -> desktop live resize without reload, and verify Light/Dark/Auto, browser text scaling, keyboard focus, touch geometry, internal scroll ownership, and zero document-level horizontal overflow. Browser checks do not prove MAUI native behavior.

The initialized geometry baseline sets `OpxFlatUi:Display:DefaultRoundedSizePx` to `7`. The package applies it to ordinary buttons and bottom-sheet top corners; other standard Flat UI surfaces remain square. Keep this package-owned token as the single authority and do not recreate the radius with consumer CSS.

The initialized color baseline sets `OpxFlatUi:Display:DefaultColorPalette` to the built-in ID `fluent-blue`. Settings may preview and persist another built-in/configured palette, but Restore clears that override and returns to Fluent Blue. Consume the resolved shared palette tokens across Light and Dark/Night; do not hard-code its hex values into page CSS.

The initialized spacing preset uses the package density key `OpxFlatUi:Display:DefaultDensity` with value `Default`. Do not create a parallel `DefaultSpacing` setting. Compact and Comfortable remain optional persisted choices; density affects internal component rhythm but never replaces the canonical page gutters, panel insets, safe areas, or widget/component spacing contracts.

For `NavigationLayout=Bottom`, `FlatAppShell.BottomNavigationMaxWidthPx` defaults to `600`. The initialized template sets `900`, rendering Bottom navigation at tablet and phone widths and the sidebar above `900px`. This decision must follow live viewport width identically on Web, MAUI Hybrid, and resized Windows EXE hosts; OS, device type, user-agent, and MAUI-platform branching are forbidden.

If a request selects Bottom navigation but does not specify child presentation, set `OpxFlatUi:Display:DefaultBottomNavigationChildPresentation` to `Sheet`. Parent and overflow items then open through the package-owned recursive bottom sheet. `MainView` is an explicit opt-in that replaces the content area with navigation tiles; it must not be inferred silently.

Responsive/mobile search and filter toolbars keep their text field visible while a toolbar row containing at least two secondary icon actions starts collapsed/hidden. Preserve the package default `FlatPage.MobileToolbarActionsExpandedByDefault=false`; the accessible Apps/Close toggle controls the row, desktop actions remain visible, and initial expansion is explicit opt-in.

Bottom-navigation labels are package-owned and descender-safe: line-height `1.25`, bottom inset `1px`, single-line ellipsis, and bar height `60px`. Validate letters `g`, `j`, `p`, `q`, and `y`; do not recreate this fix in `app.css`.

## Android/iOS MAUI deployment

When this Web composition is hosted by a .NET MAUI Android or iOS app, add the `CommunityToolkit.Maui` NuGet package compatible with the selected MAUI SDK and call `UseMauiCommunityToolkit()` from `MauiProgram.cs`. Mobile typography starts with Device ownership (`OpxFlatUi:Display:UseAppFontSize=false`), follows device/browser `1rem`, and preserves OS/browser accessibility text scaling. Manual remains available as an explicit persisted user preference, but a fixed Manual value is not the Android/iOS default. Ordinary text-button labels follow the same Device scale; button height and content width must grow or wrap when required, never clip a required action label, and never shrink below the established touch target. Icon-only toolbar/FAB glyphs and unrelated spacing remain density-owned.

Attach Toolkit `StatusBarBehavior` to the native root `ContentPage`/BlazorWebView page. Bind `StatusBarColor` to the exact resolved theme token that paints the OPX AppBar—not merely palette Primary, a copied hex, or a value inferred by scraping rendered CSS. Synchronize it at startup, explicit Light/Dark/Night selection, Auto system-theme changes, palette changes, navigation, and resume. Explicit selection wins over the system theme; Auto follows it. Choose `LightContent` or `DarkContent` from the final resolved background contrast.

Keep normal MAUI Hybrid scrolling, but disable root bounce and Android edge overscroll: configure iOS `WKWebView.ScrollView.Bounces=false` plus `AlwaysBounceVertical=false`, configure Android `WebView.OverScrollMode=Never`, and set document-root `overscroll-behavior:none`. A page that explicitly supports pull-to-refresh uses a dedicated control/gesture and may not restore root bounce. Ordinary UI labels, cards, icons, navigation, and dashboard copy are non-selectable and expose no long-press text callout. Restore `user-select:text`, caret placement, and clipboard operations only for text-bearing `input`, `textarea`, and intentional `[contenteditable=true]` editors. The implementation must preserve typing, validation, password-manager, keyboard/IME, accessibility focus, and normal scrolling.

For MAUI Hybrid startup, every visible `Memuat` state must include exactly one `.flat-system-loading-spinner` from the package and match the Reconnecting state of `FlatReconnectModal`. Put a centered full-viewport placeholder in the native host document so the spinner is visible before Razor becomes interactive; when authentication is enabled, continue with `FlatSessionRestore Title="Memuat"`. The handoff must not create a blank frame, duplicate spinner, text-only state, or protected-layout flash. Resolve the background/foreground from the active theme, honor safe areas, and keep a visible non-animated ring when reduced motion suppresses animation.

Android needs no additional Toolkit status-bar configuration. For iOS, set `UIViewControllerBasedStatusBarAppearance` to `false` in `Platforms/iOS/Info.plist`. Verify startup, navigation/back, live theme and palette changes, device text scaling, scaled-button label/geometry, orientation, suspend/resume, safe-area geometry, and readable status-bar icons on representative Android and iOS emulators or devices. Browser responsive validation does not satisfy this native deployment gate. The detailed host checklist is in `.agents/skills/opx-flat-ui-development/references/maui-mobile-deployment.md`.

## Startup authorization preloader

When a host enables authentication, mount `RootStartupGate` directly from `App.razor` and gate route creation before `MainLayout` is rendered. Its checking branch first initializes `FlatUiPreferencesService`, resolves Light/Dark/Auto and the selected palette, then shows only full-page `FlatSessionRestore` inside the matching `FlatMudProviders`, so the package theme and spinner geometry are active even though `Router` does not exist yet. Source its copy from `OpxFlatUi:Reconnect:StartupTitle` and `StartupMessage`; this template seeds `Memuat halaman` and `Menyiapkan aplikasi...`. After validation completes, remove that loading-only provider branch and create `Router`; the selected layout then owns its normal provider. This preserves Settings theme/palette preview without nested providers and applies even when the requested URL is anonymous, including Login. Never show a default shell first and replace it later, because that flashes protected navigation/content and produces a misleading authenticated state.

Local storage is client-controlled and is not authorization authority. Missing, expired, revoked, tampered, or failed validation clears stale saved state and opens Login. Only a successful host/server validation may update `AuthenticationStateProvider` and then render protected routes through `MainLayout`. Protected APIs and route policies must still enforce authorization independently. Keep the check single-flight, avoid redirect loops, validate return URLs, and never log or persist passwords, raw credentials, roles, or permission authority as trusted local data. See `.agents/skills/opx-flat-ui-development/references/session-authorization-bootstrap.md`.

## CRUD terminology

Use `Edit` consistently for the CRUD edit button, editor-title verb, tooltip, and accessible action name. The template contract does not use `Ubah` for this action, including when surrounding business copy is Indonesian.

## Clean initial run

Use `run-clean.ps1` for the first Web application start. It resolves the thin host and its fixed sibling `Opx.MudBlazor.FlatUi.Showcase`, deletes only those two projects' exact `bin` and `obj` directories, restores through the copied `NuGet.Config`, and runs the host with `--no-restore`. `-PrepareOnly` performs clean/restore only. Do not replace this with broad recursive cleanup.

## Stylesheet ownership

- Reusable OPX styling comes only from the restored NuGet static web asset `_content/Opx.MudBlazor.FlatUi/opx-flat-ui.css`. Contract `2.1.6` pins its SHA-256 so a stale or substituted package asset fails audit.
- The consumer starts with Light theme and Device/browser font ownership (`UseAppFontSize=false`). Settings always exposes Device/Manual; Manual uses the bounded `16px` default, while Device follows browser `1rem` and preserves accessibility scaling. This intentionally differs from the source showroom's theme default while retaining its `2.1.6` font behavior.
- MudBlazor styling comes only from `_content/MudBlazor/MudBlazor.min.css`. Never copy either package stylesheet into `wwwroot`.
- `Opx.MudBlazor.FlatUi.Showcase/wwwroot/opx-flat-ui-showcase.css` is the canonical sample/domain composition layer, not a fork of reusable package CSS. Its normalized-LF hash is audited; change it only for deliberate shared sample composition.
- A destination may not override package or MudBlazor CSS. Outside that untouched canonical composition file, local stylesheets must not target `.flat-*`/`.mud-*`, redeclare `--opx-*`, copy package rules, or use specificity/`!important` workarounds. Use typed options, Settings, component parameters, and documented public seams. New application/domain classes may compose host-owned content only when they preserve canonical geometry and responsive behavior.
- The template excludes the unused local Bootstrap distribution. Additional UI-framework packages, stylesheet links, and CSS imports are forbidden.
- `Components/App.razor` keeps theme bootstrap first, then MudBlazor CSS, OPX NuGet CSS, and the shared Showcase composition stylesheet. Stale `bin`/`obj` static-web-asset manifests cannot be used as visual evidence because the initial launcher removes them.

## Runtime HTML attribution

`Components/App.razor` emits exactly one `<!-- Powered by opx (github.com/opxw) -->` immediately inside `<body>` before `RootStartupGate` through an explicit `MarkupString`. This is a non-visible HTML comment that must remain present in the initial runtime response for every route. A literal HTML comment in a Razor file and a Razor comment are both removed during compilation, so source inspection alone is not proof. Do not place secrets, environment details, user data, or dynamic identifiers in this comment.

## Business and data decision contract

For dashboards, reports, layouts, and transaction workspaces, the agent acts as UI/UX, business, and data analyst: identify the user decision or operational action, data grain/source/freshness/units/comparison, relevant KPI or exception, and drill-down path before choosing widgets or charts. Transaction layouts must represent the applicable lifecycle, validation, approval, completion, cancellation/reversal, retry, concurrency, and audit boundaries. The UI must not invent formulas, thresholds, statuses, permissions, accounting effects, or live data; those remain host-owned and assumptions must be explicit.

`flat-ui.contract.schema.json` is machine-readable but does not replace the PowerShell audit. The audit reads the effective restore package folder from `obj/project.assets.json`, then checks project references, package versions, the restored OPX CSS hash, absence of local package-CSS copies/imported UI frameworks, clean-run launcher, host registrations, asset order, baseline options, canonical rules, and the selected archetype.

## Outside the contract

The template may show sample content, but the UI contract does not define or require dashboard status distribution, quick-access actions, user-summary lists, real user names/avatars/roles, logout/session behavior, or the final business menu labels/routes/permissions. Those surfaces belong to the consumer and must be derived from its data, authorization, navigation, and session contracts. The contract covers their reusable visual primitives and shell placement only.

The standard `audit_flat_ui_repo.ps1` entrypoint detects a package-only checkout and delegates to the consumer audit. A source checkout that contains `src/Opx.MudBlazor.FlatUi` continues to run the full library audit.

When the package or UI contract changes, update the schema, manifest, template identity, rules, skill, documentation, and audit together. Generate a fresh consumer and validate it before accepting the change.
