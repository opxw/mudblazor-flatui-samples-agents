# OPX MudBlazor Flat UI

[![NuGet](https://img.shields.io/nuget/v/Opx.MudBlazor.FlatUi?label=NuGet&color=005f91)](https://www.nuget.org/packages/Opx.MudBlazor.FlatUi/2.1.26)
![.NET](https://img.shields.io/badge/.NET-10.0-512BD4)
![MudBlazor](https://img.shields.io/badge/Powered%20by-MudBlazor-594AE2)
![Web and Mobile](https://img.shields.io/badge/ready-Web%20%2B%20MAUI%20Hybrid-0A7B83)

OPX Flat UI is a NuGet-first UI reference and project template for responsive Blazor Web and .NET MAUI Blazor Hybrid applications. It combines reusable flat operational components, canonical application composition, responsive navigation, theme-aware behavior, and auditable consumer rules.

**Web ready. MAUI Hybrid ready by contract. Powered by [MudBlazor](https://www.mudblazor.com/).**

## Just describe what you need in Codex

This repository provides samples, templates, skills, and rules so you can build by describing the application or feature you need. Codex reads the repository contracts, selects the closest canonical sample, and adapts the layout, components, forms, grids, spacing, responsive behavior, and Web/MAUI interactions. You do not need to specify each `PageId`, component name, or padding value.

Open this repository as a workspace in Codex. Start your first task with:

```text
Read RULES.md, .agents/AGENTS.md, .agents/RULES.md, .agents/KNOWLEDGE.md,
.agents/PROMPTING.md, and the local opx-flat-ui-development skill.
Use the canonical samples as the source of truth and consume OPX through NuGet.
Build a supplier master page with search, Add, Edit, and Delete.
Choose a contract-compliant desktop/mobile layout, then run the audits and build.
```

Once the repository context is loaded, describe the business requirement. Copy-ready examples:

```text
Build an employee leave request form with dates, leave type,
reason, and attachments. Use the closest canonical form pattern.
```

```text
Build a sales dashboard for managers with monthly trends,
target versus actual results, and drill-down to transactions.
Use demo data for now; do not invent unspecified business formulas.
```

```text
Build a purchase approval page for supervisors with document details,
Approve, Reject, and a rejection reason. Use sample data and prepare
integration callbacks; keep authorization and transaction decisions in the backend.
```

```text
Create a MAUI Hybrid version of this application sharing its UI with Web.
Follow the MAUIHost sample for native pull-to-refresh, Back navigation,
AppBar/theme-matched status bars, safe areas, keyboard behavior, and startup loading.
Use Bottom navigation with Bottom Sheet and preserve unsaved-form guards.
```

```text
Match the employee directory to the profile-grid sample in List mode.
Preserve the canonical layout, padding, typography, and behavior;
replace only application data and integrations.
```

### Use this source in another project

Open the destination project folder in Codex and make sure the following source checkout is accessible. Adjust the path to your clone location:

```text
Use D:\projects\git\mudblazor-flatui-samples-agents as this project's source of truth.
Read its rules, knowledge, prompting contract, and local skill;
import the relevant guidance into the destination project's .agents folder.

For a new project, start from the canonical template. For an existing project,
audit differences and preserve existing code and business integrations.
Use the NuGet version pinned by the source contract, original package CSS without
overrides, and the closest sample for layout and behavior. Do not add a
ProjectReference to the package source. Keep Settings, default navigation,
Light theme, Device font, Default spacing, and panel padding.

Build a Web and MAUI inventory application with an item master
and goods receipt transactions. Use demo data until the API is available.
Run the audits and build, and report which behaviors still need device testing.
```

Provide API endpoints, data models, user roles, and transaction rules when available. Codex selects routine UI details from the contract; unclear business rules, permissions, formulas, and integrations still require clarification. Results are checked through audits, builds, and appropriate tests. Device validation and production readiness require their own verification. See the [prompting contract](.agents/PROMPTING.md).

The reusable component API and original CSS are delivered by [`Opx.MudBlazor.FlatUi`](https://www.nuget.org/packages/Opx.MudBlazor.FlatUi/2.1.26). This repository owns the canonical consumer composition, sample pages, project template, rules, skills, documentation, and validation gates.

Patch 2.1.26 corrects double status-bar inset in native fullscreen modal headers through package CSS: one panel inset, a 60px header, 40px Back target and 6px leading gutter. It retains Bottom-menu history and hybrid recovery from 2.1.25. Upgrade matching package assets and rebuild the native host. See [Native editor header](docs/NATIVE-EDITOR-HEADER.md), [Hybrid recovery](docs/HYBRID-RECOVERY.md), and [Navigation](docs/AUTH-AND-NAVIGATION.md).

NuGet 2.1.26 is the current signed package. In addition to the 2.1.20 Tree Grid and IconPicker APIs, it adds hybrid reliability and productivity contracts: explicit `FlatRefreshMode`, MAUI refresh/overlay/Back coordination, visual-viewport keyboard avoidance, snapshot-based Model CRUD dirty state, `FlatPage.Title` as an optional accessible region label, scroll restoration, latest-search cancellation, diagnostics, saved views, guarded context switching, nested filter trees, stable-key record workspaces, and failed-only bulk retry. See [Mobile reliability](docs/MOBILE-RELIABILITY.md), [Hybrid hardening](docs/HYBRID-HARDENING.md), [P0 compatibility](docs/P0-COMPATIBILITY.md), and [P1/P2 productivity](docs/P1-P2-PRODUCTIVITY.md).

The package remains UI-only: hosts own authentication and authorization, scoped persistence, API queries, transactions, refresh data loaders, cancellation/idempotency, native permissions, notification delivery, and native lifecycle evidence. A NuGet upgrade does not replace the canonical MAUI host adapters.

NuGet 2.1.19 added reusable ERP/HR/IoT operational compositions (`FlatWorkInbox`, freshness, scan, telemetry, record relationships, and personal workspace), semantic filled-surface contrast, and first-paint restoration of saved Device/Manual font size plus density. The Web and MAUI hosts seed the bootstrap contract before styles so theme or reconnect mounting cannot reset typography. See [Multipurpose operational toolkit](docs/MULTIPURPOSE-TOOLKIT.md).

NuGet 2.1.18 added the public `FlatCardGrid.SearchTrailingActions` slot and package-owned input-boundary positioning, hover/focus treatment, responsive width, and reserved input space. Compact filter toggles therefore stay inside the search field while the separate toolbar action container is omitted when empty. This fixed the prior package integration gap; consumers must not recreate it with local CSS.

NuGet 2.1.17 introduced the `FlatMudProviders` DI precedence patch: resolve a directly registered `FlatUiDisplayOptions` instance before `IOptions<FlatUiDisplayOptions>` and defaults, so an implicit wrapper created by `AddOptions()` cannot mask the canonical Web/MAUI singleton configuration.

## Web preview

### Vertical navigation

Vertical is the default operational layout. It provides a searchable grouped sidebar, route-aware expansion, status badges, the mandatory Settings entry, and a right-aligned Logout action.

![OPX Flat UI Web dashboard with Vertical sidebar](docs/images/opx-flat-ui-web-vertical.jpg)

### Horizontal navigation

Horizontal is optimized for desktop Web. It moves the product identity and module navigation into a compact menu bar while retaining the same routes, permissions, theme, and page state.

![OPX Flat UI Web dashboard with Horizontal navigation](docs/images/opx-flat-ui-web-horizontal.jpg)

## Mobile preview

### MAUI Hybrid follows native interaction patterns

MAUI Hybrid shares the Blazor/MudBlazor UI with Web and integrates platform interactions through the native host. The canonical behavior covers gestures, Back navigation, keyboard, system bars, and lifecycle—not only a responsive mobile layout. Razor content still renders inside `BlazorWebView`; native adapters own the platform integration.

- **Native pull-to-refresh:** eligible pages with a real refresh handler use the host's native `RefreshView`. `FlatRefreshMode.Auto` selects the available native adapter in MAUI and the package gesture on Web. Refresh starts only when the actual scroll chain is already at the top; active overlays, busy state, and editing gestures suspend it. `Disabled` turns off package refresh gestures while ordinary scrolling remains available. Position the native spinner below the measured status-bar inset + 60dp AppBar + 8dp gap without moving the WebView.
- **Back navigation:** Android system/gesture Back follows one pipeline: dismiss the visible keyboard, handle the topmost modal/sheet and its unsaved-change guard, traverse actual Blazor/WebView history, then use native root behavior. Rejected discard keeps the editor and route intact. Bottom navigation restores the visited submenu and parent before the actual origin: General Ledger → Finance → ERP → origin. Direct links do not invent a menu trail.
- **System bars and safe areas:** the Toolkit host bridge follows the resolved AppBar/theme with contrast-aware status-bar icons. Use measured insets on rotation and layout changes. Native fullscreen editors consume the top inset once at the panel boundary, keep Back aligned with the AppBar, and leave the footer reachable.
- **Touch, scrolling, and keyboard:** preserve normal scrolling while disabling native bounce/edge glow. Ordinary UI text is not selectable; text-bearing editors retain caret, selection, and clipboard behavior. Device typography and accessibility scaling remain the default. Focused fields stay visible above the keyboard through their actual scroll owner.
- **Startup and recovery:** show the continuous theme-aware loading spinner (the sample label is `Memuat`, Indonesian for “Loading”) before interactivity and during session validation; create the Router only after the root check. Keep visited Bottom history across responsive sidebar transitions. Durable workspace/draft recovery is opt-in and host-scoped; restore drafts only with consent, and authorize deep links before navigation.
- **Native capabilities:** connectivity, notifications, camera/gallery, permissions, and resume behavior use host-owned adapters. Request permissions at the appropriate user action and report unsupported or denied capabilities explicitly.

Use [MAUIHost.Sample](samples/Opx.MudBlazor.FlatUi.MauiHost.Sample) as the complete native-integration reference. A generated MAUI consumer must wire the required adapters when enabling a capability such as native pull-to-refresh; upgrading NuGet alone does not install those host integrations. Reuse package components/assets and canonical host seams rather than adding consumer CSS or duplicate gesture handlers. See [Hybrid hardening](docs/HYBRID-HARDENING.md), [Back navigation](docs/AUTH-AND-NAVIGATION.md), [Native editor header](docs/NATIVE-EDITOR-HEADER.md), and [Recovery](docs/HYBRID-RECOVERY.md).

These are implementation contracts. Validate Android gestures, IME, rotation, resume, and process recovery against the exact built APK on an emulator/device; validate iOS on macOS/Xcode and an iOS simulator/device. Responsive Web screenshots and successful builds do not establish native runtime parity.

### Responsive views

The mobile composition is responsive, touch-aware, safe-area ready, and designed for both mobile Web and MAUI Blazor Hybrid. Tables can become equivalent cards, dialogs become full-screen editors, and controls retain usable touch geometry.

<table>
  <thead>
    <tr>
      <th>Responsive mobile view</th>
      <th>Phone Bottom bar</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><img src="docs/images/opx-flat-ui-mobile.jpg" alt="OPX Flat UI responsive mobile dashboard" width="390"></td>
      <td><img src="docs/images/opx-flat-ui-mobile-bottom-bar.jpg" alt="OPX Flat UI mobile Bottom navigation" width="390"></td>
    </tr>
  </tbody>
</table>

Bottom navigation reuses the same route tree as the other layouts and is selected from viewport width alone. The package default threshold is `600px`; this template explicitly uses `900px`, so tablet and phone widths receive the bottom bar while wider Web and Windows desktop windows receive the sidebar. It supports up to five root actions, a More entry for overflow, recursive child navigation, and safe-area spacing. Child and overflow navigation defaults to the package Bottom Sheet; the in-content `MainView` tile presentation is explicit opt-in.

## Application Settings

Every initialized consumer keeps **Settings → Application preferences** in the AppBar overflow menu. The surface previews changes immediately, persists them only after **Save**, restores the current saved state on **Cancel**, and returns to host-configured defaults through **Restore application defaults**.

![OPX Flat UI Application preferences in the canonical Light Web sample](docs/images/opx-flat-ui-settings.png)

The canonical Settings surface provides:

- **Theme:** Light (default), Dark / Night, or Auto following the device preference.
- **Navigation:** Vertical, Horizontal, or viewport-aware Bottom navigation; Bottom child menus can use a sheet or the main content view.
- **Color system:** built-in operational palettes plus separate validated sidebar background/foreground colors for Light and Dark.
- **Density and fields:** spacing defaults to the package `Default` density preset; Compact and Comfortable remain selectable, alongside the supported input presentation style.
- **Typography:** Device ownership by default, or a bounded Manual font-size preference.
- **Surface behavior:** backdrop opacity and controlled corner radius.
- **Recovery:** live preview, Cancel rollback, Save persistence, and restoration to `appsettings.json` defaults.
- **Host extension:** local OS/device notification preferences remain owned by the Web or MAUI host, including permission and scheduling.

The source defaults live under `OpxFlatUi:Display` in `appsettings.json`, including the canonical `DefaultRoundedSizePx: 7` for ordinary buttons and bottom-sheet top corners. Other standard surfaces remain square, and consumers must not reproduce this package-owned geometry with local CSS. Real per-user storage, authorization, cross-device synchronization, notification delivery, and administrative policy remain consumer responsibilities.

## OPX components beyond MudBlazor

MudBlazor remains the underlying visual component library. `Opx.MudBlazor.FlatUi` adds higher-level operational components and application contracts so consumers do not have to reconstruct responsive shells, workflows, editors, and enterprise states from individual controls.

| Capability | Principal OPX components |
|---|---|
| Application shell and navigation | `FlatAppShell`, `FlatHorizontalNavigation`, `FlatDynamicMenu`, `IFlatNavigationRouteResolver`, `FlatNavigationBadge`, `FlatPage`, `FlatPanel`, `FlatFab` |
| Theme, startup, and system feedback | `FlatMudProviders`, `FlatDisplaySettings`, `FlatSessionRestore`, `FlatReconnectModal`, `FlatProcessingContainer`, `FlatMessageBoxDialog`, `FlatUnsavedChangesGuard`, `FlatDeviceNotification` |
| Dashboard and status widgets | `FlatWidget`, `FlatMetricWidget`, `FlatActionMetricWidget`, `FlatProgressWidget`, `FlatSegmentProgressWidget`, `FlatCompactMetric`, `FlatStatCard`, `FlatStatusChip`, `FlatActivityItem`, `FlatTaskItem`, `FlatTimeline` |
| Data grids and hierarchy | `FlatDataGrid` with built-in materialized-view `.xlsx` export, `FlatMobileGrid`, `FlatGroupedDataGrid`, `FlatEditableGrid`, `FlatAdvancedEditableGrid`, `FlatTreeGrid`, `FlatPager`, `FlatGridPreferencesPanel`, `FlatHierarchyDesigner` |
| CRUD, forms, lookup, and input | `FlatModelCrud`, `FlatSchemaForm`, `FlatModelFormDesigner`, `FlatFormModal`, `FlatEditorWorkspace`, `FlatEntityLookup`, `FlatSearchComboBox`, `FlatMultiSelect`, `FlatNumberInput`, `FlatMoneyInput`, `FlatQuantityInput`, `FlatMaterialIconPicker` |
| Files, images, and documents | `FlatFileUpload`, `FlatImageUpload`, `FlatDataImport`, `FlatDocumentWorkspace`, `FlatDocumentAttachmentManager`, `FlatPdfViewer`, `FlatPrintLayout` |
| Reports and analytics | `FlatOperationalReportViewer`, `FlatPivotGrid`, `FlatPivotFieldChooser`, `FlatDataComparisonGrid`, `FlatQueryBuilder` |
| Scheduling and planning | `FlatCalendar`, `FlatScheduler`, `FlatRecurrenceEditor`, `FlatKanbanBoard`, `FlatPlanningBoard`, `FlatDashboardComposer` |
| Transactions, ERP, and operations | `FlatTransactionWorkspace`, `FlatEditableGrid`, `FlatRecordLifecycleHeader`, `FlatJournalEntryGrid`, `FlatReconciliationWorkspace`, `FlatInventoryAllocationWorkspace`, `FlatInventoryTraceabilityWorkspace`, `FlatBomRoutingEditor`, `FlatMrpCapacityWorkspace`, `FlatIntegrationCenter`, `FlatBackgroundOperationCenter` |
| Workflow and governance | `FlatWorkflowPanel`, `FlatWorkflowDesigner`, `FlatApprovalInbox`, `FlatApprovalMatrixDesigner`, `FlatRuleBuilder`, `FlatBulkActionBar`, `FlatAuditTrail`, `FlatGovernancePanel` |
| Communication and collaboration | `FlatChatShell`, `FlatChatMessage`, `FlatEmailShell`, `FlatCollaborationPanel`, `FlatConflictResolver`, `FlatNotificationCenter` |
| Content, commerce, and profile | `FlatProductDetail`, `FlatCatalogGrid`, `FlatCatalogCard`, `FlatJobCard`, `FlatJobEmailApplicationDialog`, `FlatVacancyActions`, `FlatProfileCard`, `FlatProfileListItem`, `FlatProfileAvatar`, `FlatDetailSection`, `FlatInfoItem`, `FlatEmptyState` |
| Spatial UI | `FlatVectorMap`, `FlatSpatialWorkspace` and their typed region, route, marker, layer, and geofence models |
| Application experience | `FlatCommandPalette`, `FlatAccessibilitySettings`, `FlatPermissionView`, `FlatFeatureView`, `FlatMasterDetailWorkspace`, `FlatOfflineSyncPanel` |

The OPX components own presentation, responsive composition, interaction state, and typed intent. APIs, database access, business calculations, authorization, transaction commits, file storage, notifications, realtime transport, and audit persistence stay host-owned.

## Special features

- **Three responsive navigation modes** — Vertical sidebar, Horizontal desktop menu, and viewport-aware Bottom navigation from one route tree.
- **Adaptive data presentation** — `FlatDataGrid` desktop tables and equivalent tablet/mobile cards preserve one query, filter, sort, paging, selection, permission, and loading state.
- **Native Excel export** — `FlatDataGrid` can export its materialized visible view to `.xlsx`; permission-sensitive, remote, virtualized, and unbounded exports remain host-owned through `OnExport`.
- **Public and admin recruitment samples** — the public Job Landing returns typed email-application intent without sending data, while the admin Jobs page demonstrates create/edit, publish/close, and delete vacancy intent.
- **Operational dashboards** — compact KPI widgets, charts, activity feeds, status chips, summary lists, quick actions, and responsive panel composition.
- **CRUD and transaction workspaces** — responsive editor shells, full-screen mobile forms, dirty-state protection, entity lookup, bulk actions, approval flows, and host-owned persistence boundaries.
- **Advanced reusable surfaces** — Pivot, Kanban, Chat, Email, command palette, schema-driven forms, editable grids, audit trail, collaboration, conflict resolution, document workspaces, import, calendar, and notification samples.
- **Theme and display preferences** — Light theme with Fluent Blue default palette, Dark / Night, Auto, multiple palettes, density presets, Device or Manual typography, configurable backdrop, and controlled corner sizing.
- **Shared loading system** — responsive initial skeletons, AppBar operation progress, `FlatReconnectModal`, and the mandatory MAUI `Memuat` spinner using the same package-owned visual.
- **Secure startup presentation** — `FlatSessionRestore` blocks protected UI while the host validates an untrusted saved-session hint. Local storage is never the authorization authority.
- **MAUI system integration contract** — AppBar-synchronized Android/iOS status bar, Device typography, accessibility-scaled text buttons, safe areas, lifecycle resynchronization, audited Android network/notification permission declarations, and native verification gates.
- **Native interaction rules** — normal scrolling without WebView bounce/edge glow, dedicated pull-to-refresh, and text selection limited to textbox-class inputs and editors.
- **Package-owned reusable CSS** — consumers load `_content/Opx.MudBlazor.FlatUi/opx-flat-ui.css`; host CSS remains limited to application/domain composition.
- **No destination CSS override** — consumer stylesheets may not target `.flat-*`/`.mud-*`, redeclare `--opx-*`, copy package rules, or patch package geometry with specificity/`!important`; reusable visual changes go through package options/public APIs or a source/package fix.
- **Auditable output** — versioned JSON schema, consumer audit script, source mapping, responsive rules, Release build checks, and fresh-template validation.

Business data, formulas, permissions, authentication, persistence, integration, transactions, and server-side authorization remain owned by the consuming application.

## Navigation modes

| Mode | Intended surface | Behavior |
|---|---|---|
| **Vertical** | Web desktop, tablet fallback, responsive drawer | Searchable grouped sidebar with active-route expansion. |
| **Horizontal** | Web desktop only | Compact product/menu bar with module dropdowns. |
| **Bottom** | Responsive Web, MAUI Hybrid, and resized Windows EXE | Package threshold defaults to `600px`; this template uses `900px`, with sidebar fallback above it. |

Navigation, theme, palette, density, and typography are available from the mandatory **Settings → Application preferences** surface.

## Package baseline

| Dependency | Version |
|---|---:|
| `Opx.MudBlazor.FlatUi` | `2.1.26` |
| `MudBlazor` | `9.9.0` |
| MAUI mobile template | `10.0.90` |
| `CommunityToolkit.Maui` | `15.0.1` |
| Target framework | `.NET 10` |
| Consumer contract schema | `3.1` |

## Create a consumer project

Install or refresh the repository template:

```powershell
dotnet new install . --force
```

Create a NuGet-only consumer:

```powershell
dotnet new opx-flatui-web -n MyOpxApp
Set-Location MyOpxApp\MyOpxApp
.\run-clean.ps1
```

The Web template produces sibling `MyOpxApp` (thin executable host) and `Opx.MudBlazor.FlatUi.Showcase` (shared page composition) projects. The first run cleans both projects' exact `bin` and `obj`, restores reusable OPX UI 2.1.26 from NuGet.org, and starts with the canonical Light theme, Settings menu, default navigation, package-owned CSS, responsive rules, first-paint typography/density restoration, and runtime OPX attribution.

Audit a generated consumer before accepting its output:

```powershell
..\.agents\skills\opx-flat-ui-development\scripts\audit_flat_ui_consumer.ps1 . -ExactSample
dotnet build -c Release --no-restore
```

Create the canonical Android/iOS MAUI Blazor Hybrid consumer:

```powershell
dotnet new opx-flatui-maui -n MyOpxMobileApp
Set-Location MyOpxMobileApp
.\run-clean.ps1 -PrepareOnly
.\scripts\audit_maui_consumer.ps1 -ExactSample
dotnet build -f net10.0-android -c Release --no-restore
```

The MAUI template pins MAUI `10.0.90`, CommunityToolkit.Maui `15.0.1`, MudBlazor `9.9.0`, and OPX Flat UI `2.1.26`. It replaces stock .NET/MAUI splash artwork with a neutral white-on-white invisible launch asset, then hands off to the continuous `Memuat` spinner. It also includes first-paint Device/Manual font and density restoration, the native status-bar bridge, root-before-`Router` authorization gate, Settings, default sidebar/Bottom navigation, Device typography, no-bounce WebView handlers, textbox-only text selection, package-only reusable CSS, a machine-readable mobile contract, and its audit script. Android 12+ still owns a mandatory system splash frame; the template removes its stock artwork rather than claiming that OS frame can be eliminated. Replace the sample authorization validator and sample business data before production use.

When a prompt requests UI that is the same, exact, canonical, or matches the sample/source of truth, use **Exact Sample Mode**. Generate a fresh Web or MAUI template, resolve the `PageId`, and pass `-ExactSample` before wiring host data or services. The audit rejects drift in canonical shell/page files; branding, wording, data, authorization, callbacks, and persistence may then change through existing seams without changing geometry or behavior.

## Repository map

- `samples/Opx.MudBlazor.FlatUi.Showcase` — single shared source of truth for pages, sample services, navigation metadata, and composition CSS.
- `samples/Opx.MudBlazor.FlatUi.Sample` — thin NuGet Web host and one half of the multi-project Web template.
- `.agents/skills/opx-flat-ui-development` — UI/UX, business/data analysis, implementation, responsive, Web, and MAUI rules.
- `docs/CONSUMER-CONTRACT.md` — consumer ownership and integration contract.
- `docs/DATA-GRID-EXCEL-EXPORT.md`, `docs/JOB-LANDING.md`, and `docs/JOBS-DASHBOARD.md` — feature and sample ownership contracts.
- `RULES.md` and `.agents/RULES.md` — mandatory implementation rules.
- `flat-ui.contract.json` and its schema inside the sample — machine-readable baseline enforced by the audit.
- `templates/Opx.MudBlazor.FlatUi.Maui.Template` — Android/iOS Blazor Hybrid source-of-truth template, mobile contract, and native audit.
- `samples/Opx.MudBlazor.FlatUi.MauiHost.Sample` — thin NuGet Android/Windows host that loads the shared Showcase routes, with startup gating, native adapters, edge-to-edge AppBar/status-bar integration, and runtime performance measurements.
- `docs/MAUI-HYBRID-HOST.md` — ownership, startup, responsive navigation, native status-bar, build, and device-evidence contract for the host sample.

## Web and MAUI evidence boundary

The screenshots above are captured from the real local Blazor Web sample at representative desktop and phone viewports. They prove the rendered Web composition and responsive CSS at capture time.

The repository now includes a real Android/iOS MAUI Blazor Hybrid template in addition to the Web template. A successful Android compile proves source/package compatibility only. Status-bar appearance, safe areas, keyboard/IME, system back, lifecycle, suspend/resume, no-bounce WebView behavior, native text selection, and the `Memuat` bootstrap transition still require representative emulator or physical-device validation; iOS build and runtime validation require macOS/Xcode.

---

**OPX Flat UI — Web and MAUI Hybrid ready. Powered by MudBlazor.**
