# OPX MudBlazor Flat UI

[![NuGet](https://img.shields.io/nuget/v/Opx.MudBlazor.FlatUi?label=NuGet&color=005f91)](https://www.nuget.org/packages/Opx.MudBlazor.FlatUi/2.1.29)
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

The reusable component API and original CSS are delivered by [`Opx.MudBlazor.FlatUi`](https://www.nuget.org/packages/Opx.MudBlazor.FlatUi/2.1.29). This repository owns the canonical consumer composition, sample pages, project template, rules, skills, documentation, and validation gates.

The current dependency is **2.1.29**, including the responsive report-toolbar and bounded mobile-card scrolling correction. Imported [hybrid operations guidance](docs/HYBRID-OPERATIONS.md) covers document transfer, scanner/outbox coordination and explicit host obligations; new adapters are not automatically wired by a NuGet upgrade. The screenshot gallery below remains labeled with its actual **2.1.27** capture version.

The current package includes shared PDF printing through `IFlatPrintService`. The Web sample registers the browser service; MAUIHost supplies Android/Windows adapters. Printing uses authorized PDF bytes and reports `Submitted` when the final outcome is unknown. Native adapters require host integration; printer capability is not physical-printer discovery. See [Print support](docs/PRINT-SUPPORT.md).

NuGet 2.1.29 is the current signed package. In addition to the 2.1.20 Tree Grid and IconPicker APIs, it adds hybrid reliability and productivity contracts: explicit `FlatRefreshMode`, MAUI refresh/overlay/Back coordination, visual-viewport keyboard avoidance, snapshot-based Model CRUD dirty state, `FlatPage.Title` as an optional accessible region label, scroll restoration, latest-search cancellation, diagnostics, saved views, guarded context switching, nested filter trees, stable-key record workspaces, and failed-only bulk retry. See [Mobile reliability](docs/MOBILE-RELIABILITY.md), [Hybrid hardening](docs/HYBRID-HARDENING.md), [P0 compatibility](docs/P0-COMPATIBILITY.md), and [P1/P2 productivity](docs/P1-P2-PRODUCTIVITY.md).

The package remains UI-only: hosts own authentication and authorization, scoped persistence, API queries, transactions, refresh data loaders, cancellation/idempotency, native permissions, notification delivery, and native lifecycle evidence. A NuGet upgrade does not replace the canonical MAUI host adapters.

NuGet 2.1.19 added reusable ERP/HR/IoT operational compositions (`FlatWorkInbox`, freshness, scan, telemetry, record relationships, and personal workspace), semantic filled-surface contrast, and first-paint restoration of saved Device/Manual font size plus density. The Web and MAUI hosts seed the bootstrap contract before styles so theme or reconnect mounting cannot reset typography. See [Multipurpose operational toolkit](docs/MULTIPURPOSE-TOOLKIT.md).

NuGet 2.1.18 added the public `FlatCardGrid.SearchTrailingActions` slot and package-owned input-boundary positioning, hover/focus treatment, responsive width, and reserved input space. Compact filter toggles therefore stay inside the search field while the separate toolbar action container is omitted when empty. This fixed the prior package integration gap; consumers must not recreate it with local CSS.

NuGet 2.1.17 introduced the `FlatMudProviders` DI precedence patch: resolve a directly registered `FlatUiDisplayOptions` instance before `IOptions<FlatUiDisplayOptions>` and defaults, so an implicit wrapper created by `AddOptions()` cannot mask the canonical Web/MAUI singleton configuration.

## Web preview

### Vertical navigation

Vertical is the default operational layout. It provides a searchable grouped sidebar, route-aware expansion, status badges, the mandatory Settings entry, and a right-aligned Logout action.

All sidebar groups are expanded below. The sidebar remains scrollable at ordinary desktop heights; open the complete menu image to inspect every entry.

![OPX Flat UI Web dashboard with every Vertical sidebar group expanded](docs/images/showcase/vertical-expanded.png)

<details>
<summary>Vertical menu — expand all, complete menu tree</summary>

<img src="docs/images/showcase/vertical-all-groups.png" alt="Complete Vertical sidebar with all eleven groups expanded" width="270">

</details>

### Horizontal navigation

Horizontal is optimized for desktop Web. It moves the product identity and module navigation into a compact menu bar while retaining the same routes, permissions, theme, and page state.

![OPX Flat UI Web dashboard with Horizontal navigation](docs/images/showcase/horizontal.png)

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
      <th>Phone Bottom menu</th>
      <th>Bottom Sheet — ERP menu open</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><img src="docs/images/showcase/bottom-mobile.png" alt="OPX Flat UI Bottom menu at a 390px mobile viewport" width="390"></td>
      <td><img src="docs/images/showcase/bottomsheet-mobile.png" alt="Package-owned Bottom Sheet opened from the mobile ERP Bottom menu" width="390"></td>
    </tr>
  </tbody>
</table>

Bottom navigation reuses the same route tree as the other layouts and is selected from viewport width alone. The package default threshold is `600px`; this template explicitly uses `900px`, so tablet and phone widths receive the bottom bar while wider Web and Windows desktop windows receive the sidebar. It supports up to five root actions, a More entry for overflow, recursive child navigation, and safe-area spacing. Child and overflow navigation defaults to the package Bottom Sheet; the in-content `MainView` tile presentation is explicit opt-in.

## Application Settings

Every initialized consumer keeps **Settings → Application preferences** in the AppBar overflow menu. The surface previews changes immediately, persists them only after **Save**, restores the current saved state on **Cancel**, and returns to host-configured defaults through **Restore application defaults**.

![OPX Flat UI Application preferences in the canonical Light Web sample](docs/images/showcase/settings.png)

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

## Component screenshot gallery

Browse the [complete screenshot catalog](docs/SCREENSHOT-GALLERY.md) for every shared showcase route, named component panels, widgets, and open dialog previews. Each entry links to its canonical Razor source and lists the OPX components used by that page. Expand a section below to view its screenshots without leaving this README.

Captured from the running NuGet **2.1.27** Web sample with original package styles, Light theme, Fluent Blue, Device typography, and Default spacing. Desktop captures use **1440 × 1000**; the Bottom menu and Bottom Sheet use **390 × 844**. The complete Vertical tree uses a taller viewport, with all eleven groups expanded through their normal controls. Images show sample data, not production records.

Coverage means the shared showcase's rendered pages and named panels—not every state, tab, virtualized row, or public API type. Dialog previews are included separately. Native-only MAUI capabilities and operating-system permission/print dialogs require device screenshots; responsive Web images do not prove native behavior. See the catalog's evidence notes and [capture manifest](docs/images/showcase/manifest.json).

<!-- BEGIN GENERATED SHOWCASE GALLERY -->

<details>
<summary>Accordions — /accordions</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/Accordions.razor) · Route: `/accordions`

`FlatAccordion`, `FlatAccordionItem`, `FlatPage`, `FlatPanel`.

![Accordions showcase](docs/images/showcase/accordions.png)

**Default accordion**

![Default accordion component panel](docs/images/showcase/accordions-panel-1.png)

**Accordion flush**

![Accordion flush component panel](docs/images/showcase/accordions-panel-2.png)

**Accordions with icons**

![Accordions with icons component panel](docs/images/showcase/accordions-panel-3.png)

**Accordions without toggle icons**

![Accordions without toggle icons component panel](docs/images/showcase/accordions-panel-4.png)

</details>

<details>
<summary>Advanced Editable Grid — /advanced-editable-grid</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/AdvancedEditableGrid.razor) · Route: `/advanced-editable-grid`

`FlatAdvancedEditableGrid`, `FlatAdvancedGridCommandKind`, `FlatNumberInput`, `FlatNumberText`, `FlatPage`.

![Advanced Editable Grid showcase](docs/images/showcase/advanced-editable-grid.png)

**Advanced editable grid**

![Advanced editable grid component panel](docs/images/showcase/advanced-editable-grid-detail-1.png)

</details>

<details>
<summary>Ai Chat — /ai-chat</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/AiChat.razor) · Route: `/ai-chat`

`FlatChatConversationItem`, `FlatChatMessage`, `FlatChatShell`, `FlatChatTypingIndicator`, `FlatEmptyState`, `FlatPage`.

![Ai Chat showcase](docs/images/showcase/ai-chat.png)

</details>

<details>
<summary>Blog — /blog</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/Blog.razor) · Route: `/blog`

![Blog showcase](docs/images/showcase/blog.png)

</details>

<details>
<summary>Business Toolkit — /business-toolkit</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/BusinessToolkit.razor) · Route: `/business-toolkit`

`FlatApprovalLevel`, `FlatApprovalMatrixDesigner`, `FlatBomNode`, `FlatBomRoutingEditor`, `FlatDataComparisonGrid`, `FlatDataComparisonRow`, `FlatDocumentAttachment`, `FlatDocumentAttachmentManager`, `FlatInventoryTraceabilityWorkspace`, `FlatPage`, `FlatQueryBuilder`, `FlatQueryField`, `FlatRecurrenceEditor`, `FlatRuleBuilder`, `FlatRuleField`, `FlatTraceabilityNode`.

![Business Toolkit showcase](docs/images/showcase/business-toolkit.png)

**Inventory Traceability**

![Inventory Traceability component panel](docs/images/showcase/business-toolkit-detail-1.png)

**BOM and Routing**

![BOM and Routing component panel](docs/images/showcase/business-toolkit-detail-2.png)

**Rule Builder**

![Rule Builder component panel](docs/images/showcase/business-toolkit-detail-3.png)

**Approval Matrix**

![Approval Matrix component panel](docs/images/showcase/business-toolkit-detail-4.png)

**Document Attachments**

![Document Attachments component panel](docs/images/showcase/business-toolkit-detail-5.png)

**Recurrence Editor**

![Recurrence Editor component panel](docs/images/showcase/business-toolkit-detail-6.png)

**Query Builder**

![Query Builder component panel](docs/images/showcase/business-toolkit-detail-7.png)

**Data Comparison**

![Data Comparison component panel](docs/images/showcase/business-toolkit-detail-8.png)

</details>

<details>
<summary>Calendar — /calendar</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/Calendar.razor) · Route: `/calendar`

`FlatCalendar`, `FlatFormModal`, `FlatPage`, `FlatSchedulerItem`.

![Calendar showcase](docs/images/showcase/calendar.png)

</details>

<details>
<summary>Catalog — /catalog</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/Catalog.razor) · Route: `/catalog`

`FlatCatalogCard`, `FlatCatalogGrid`, `FlatFilterWorkspace`, `FlatPage`.

![Catalog showcase](docs/images/showcase/catalog.png)

</details>

<details>
<summary>Charts — /charts</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/Charts.razor) · Route: `/charts`

`FlatPage`, `FlatPanel`.

![Charts showcase](docs/images/showcase/charts.png)

**Line**

![Line component panel](docs/images/showcase/charts-panel-1.png)

**Line**

![Line component panel](docs/images/showcase/charts-panel-2.png)

**Bar**

![Bar component panel](docs/images/showcase/charts-panel-3.png)

**Stacked Bar**

![Stacked Bar component panel](docs/images/showcase/charts-panel-4.png)

**Pie**

![Pie component panel](docs/images/showcase/charts-panel-5.png)

**Donut**

![Donut component panel](docs/images/showcase/charts-panel-6.png)

**Timeseries**

![Timeseries component panel](docs/images/showcase/charts-panel-7.png)

**Heat Map**

![Heat Map component panel](docs/images/showcase/charts-panel-8.png)

**Rose**

![Rose component panel](docs/images/showcase/charts-panel-9.png)

**Radar**

![Radar component panel](docs/images/showcase/charts-panel-10.png)

**Sankey**

![Sankey component panel](docs/images/showcase/charts-panel-11.png)

**Scatter Plot**

![Scatter Plot component panel](docs/images/showcase/charts-panel-12.png)

</details>

<details>
<summary>Chat — /chat</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/Chat.razor) · Route: `/chat`

`FlatChatConversationItem`, `FlatChatMessage`, `FlatChatShell`, `FlatChatTypingIndicator`, `FlatEmptyState`, `FlatPage`, `FlatProfileAvatar`.

![Chat showcase](docs/images/showcase/chat.png)

</details>

<details>
<summary>Colors — /colors</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/Colors.razor) · Route: `/colors`

`FlatColorReference`, `FlatPage`.

![Colors showcase](docs/images/showcase/colors.png)

</details>

<details>
<summary>Components Gallery — /components</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ComponentsGallery.razor) · Route: `/components`

`FlatDetailSection`, `FlatEmptyState`, `FlatFormModal`, `FlatInfoItem`, `FlatMaterialIconPicker`, `FlatMultiSelect`, `FlatMultiSelectOption`, `FlatNumberInput`, `FlatPageHeading`, `FlatPanel`, `FlatProcessingContainer`, `FlatProfileAvatar`, `FlatReconnectModal`, `FlatSearchComboBox`, `FlatSearchComboOption`, `FlatSessionRestore`, `FlatStatCard`.

![Components Gallery showcase](docs/images/showcase/components.png)

**Theme Tokens**

![Theme Tokens component panel](docs/images/showcase/components-panel-1.png)

**Empty State**

![Empty State component panel](docs/images/showcase/components-panel-2.png)

**Button States**

![Button States component panel](docs/images/showcase/components-panel-3.png)

**Info Items**

![Info Items component panel](docs/images/showcase/components-panel-4.png)

**Formatted Number Input**

![Formatted Number Input component panel](docs/images/showcase/components-panel-5.png)

**Profile Avatar**

![Profile Avatar component panel](docs/images/showcase/components-panel-6.png)

**Optional Page Heading**

![Optional Page Heading component panel](docs/images/showcase/components-panel-7.png)

**Processing State**

![Processing State component panel](docs/images/showcase/components-panel-8.png)

**Message Box**

![Message Box component panel](docs/images/showcase/components-panel-9.png)

**Reconnect Notice**

![Reconnect Notice component panel](docs/images/showcase/components-panel-10.png)

**Form Modal**

![Form Modal component panel](docs/images/showcase/components-panel-11.png)

**MudBlazor Line Chart**

![MudBlazor Line Chart component panel](docs/images/showcase/components-panel-12.png)

**MudBlazor Pie Chart**

![MudBlazor Pie Chart component panel](docs/images/showcase/components-panel-13.png)

**Multi Select**

![Multi Select component panel](docs/images/showcase/components-panel-14.png)

**Search Combo Box**

![Search Combo Box component panel](docs/images/showcase/components-panel-15.png)

**Material Icon Picker**

![Material Icon Picker component panel](docs/images/showcase/components-panel-16.png)

**Multi Select with leading visuals**

![Multi Select with leading visuals component panel](docs/images/showcase/components-panel-17.png)

</details>

<details>
<summary>Crud — /crud</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/Crud.razor) · Route: `/crud`

`FlatDataGrid`, `FlatEmptyState`, `FlatFormModal`, `FlatInfoItem`, `FlatMobileGrid`, `FlatPage`, `FlatPager`.

![Crud showcase](docs/images/showcase/crud.png)

</details>

<details>
<summary>Data Grid Large — /data-grid-large</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/DataGridLarge.razor) · Route: `/data-grid-large`

`FlatDataGrid`, `FlatEmptyState`, `FlatInfoItem`, `FlatMobileGrid`, `FlatPage`, `FlatPager`, `FlatStatusChip`.

![Data Grid Large showcase](docs/images/showcase/data-grid-large.png)

</details>

<details>
<summary>Development Rules — /development-rules</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/DevelopmentRules.razor) · Route: `/development-rules`

`FlatPage`, `FlatPanel`.

![Development Rules showcase](docs/images/showcase/development-rules.png)

**Canonical development path**

![Canonical development path component panel](docs/images/showcase/development-rules-panel-1.png)

</details>

<details>
<summary>Dynamic Menu — /dynamic-menu</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/DynamicMenu.razor) · Route: `/dynamic-menu`

`FlatDynamicMenu`, `FlatDynamicMenuItem`, `FlatInfoItem`, `FlatNavigationMenuItem`, `FlatPage`.

![Dynamic Menu showcase](docs/images/showcase/dynamic-menu.png)

</details>

<details>
<summary>Edit Account — /account/edit</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/EditAccount.razor) · Route: `/account/edit`

`FlatMultiSelect`, `FlatMultiSelectOption`, `FlatPage`, `FlatPanel`, `FlatProfileAvatar`.

![Edit Account showcase](docs/images/showcase/account-edit.png)

**Profile picture**

![Profile picture component panel](docs/images/showcase/account-edit-panel-1.png)

**Account details**

![Account details component panel](docs/images/showcase/account-edit-panel-2.png)

**Security**

![Security component panel](docs/images/showcase/account-edit-panel-3.png)

</details>

<details>
<summary>Email — /email</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/Email.razor) · Route: `/email`

`FlatEmailFolderItem`, `FlatEmailMessageItem`, `FlatEmailShell`, `FlatEmptyState`, `FlatFab`, `FlatPage`, `FlatProfileAvatar`.

![Email showcase](docs/images/showcase/email.png)

</details>

<details>
<summary>Enterprise Toolkit — /enterprise-toolkit</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/EnterpriseToolkit.razor) · Route: `/enterprise-toolkit`

`FlatAuditEvent`, `FlatAuditTrail`, `FlatBulkAction`, `FlatBulkActionBar`, `FlatDashboardComposer`, `FlatDashboardWidgetDefinition`, `FlatDataImport`, `FlatDataImportColumn`, `FlatDataImportField`, `FlatDataImportRow`, `FlatDocumentItem`, `FlatDocumentWorkspace`, `FlatDocumentWorkspaceAction`, `FlatFormFieldDefinition`, `FlatInfoItem`, `FlatMasterDetailWorkspace`, `FlatNotificationCenter`, `FlatNotificationItem`, `FlatOfflineSyncPanel`, `FlatPage`, `FlatPivotFieldChooser`, `FlatPivotFieldDefinition`, `FlatPrintLayout`, `FlatScheduler`, `FlatSchedulerItem`, `FlatSchemaForm`, `FlatSyncItem`, `FlatWorkflowPanel`, `FlatWorkflowStep`.

![Enterprise Toolkit showcase](docs/images/showcase/enterprise-toolkit.png)

**Workspace productivity**

![Workspace productivity component panel](docs/images/showcase/enterprise-toolkit-panel-1.png)

**Workspace productivity**

![Workspace productivity component panel](docs/images/showcase/enterprise-toolkit-panel-2.png)

**Record workspace**

![Record workspace component panel](docs/images/showcase/enterprise-toolkit-panel-3.png)

**Bulk progress**

![Bulk progress component panel](docs/images/showcase/enterprise-toolkit-panel-4.png)

**ERP · HR · IoT work inbox**

![ERP · HR · IoT work inbox component panel](docs/images/showcase/enterprise-toolkit-detail-1.png)

**Telemetry and alarms**

![Telemetry and alarms component panel](docs/images/showcase/enterprise-toolkit-detail-3.png)

**My workspace**

![My workspace component panel](docs/images/showcase/enterprise-toolkit-detail-4.png)

**Data Import Wizard**

![Data Import Wizard component panel](docs/images/showcase/enterprise-toolkit-detail-5.png)

**Pivot Field Chooser**

![Pivot Field Chooser component panel](docs/images/showcase/enterprise-toolkit-detail-6.png)

**Master–Detail Workspace**

![Master–Detail Workspace component panel](docs/images/showcase/enterprise-toolkit-detail-7.png)

**Audit Trail and Diff**

![Audit Trail and Diff component panel](docs/images/showcase/enterprise-toolkit-detail-8.png)

**Schema Form**

![Schema Form component panel](docs/images/showcase/enterprise-toolkit-detail-9.png)

**Approval Workflow**

![Approval Workflow component panel](docs/images/showcase/enterprise-toolkit-detail-10.png)

**Bulk Actions**

![Bulk Actions component panel](docs/images/showcase/enterprise-toolkit-detail-11.png)

**Scheduler**

![Scheduler component panel](docs/images/showcase/enterprise-toolkit-detail-12.png)

**Dashboard Composer**

![Dashboard Composer component panel](docs/images/showcase/enterprise-toolkit-detail-13.png)

**Notification Center**

![Notification Center component panel](docs/images/showcase/enterprise-toolkit-detail-14.png)

**Offline Sync**

![Offline Sync component panel](docs/images/showcase/enterprise-toolkit-detail-15.png)

**Document Workspace**

![Document Workspace component panel](docs/images/showcase/enterprise-toolkit-detail-16.png)

**Print Layout**

![Print Layout component panel](docs/images/showcase/enterprise-toolkit-detail-17.png)

</details>

<details>
<summary>Erp Finance — /erp/finance</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ErpFinance.razor) · Route: `/erp/finance`

`FlatInfoItem`, `FlatPage`, `FlatPanel`, `FlatStatCard`.

![Erp Finance showcase](docs/images/showcase/erp-finance.png)

**Profit and loss trend**

![Profit and loss trend component panel](docs/images/showcase/erp-finance-panel-1.png)

**Period close**

![Period close component panel](docs/images/showcase/erp-finance-panel-2.png)

**Recent journal activity**

![Recent journal activity component panel](docs/images/showcase/erp-finance-panel-3.png)

</details>

<details>
<summary>Erp Finance — /erp/finance/general-ledger</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ErpFinance.razor) · Route: `/erp/finance/general-ledger`

`FlatInfoItem`, `FlatPage`, `FlatPanel`, `FlatStatCard`.

![Erp Finance showcase](docs/images/showcase/erp-finance-general-ledger.png)

</details>

<details>
<summary>Erp Finance — /erp/finance/payables</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ErpFinance.razor) · Route: `/erp/finance/payables`

`FlatInfoItem`, `FlatPage`, `FlatPanel`, `FlatStatCard`.

![Erp Finance showcase](docs/images/showcase/erp-finance-payables.png)

**Supplier open items**

![Supplier open items component panel](docs/images/showcase/erp-finance-payables-panel-1.png)

</details>

<details>
<summary>Erp Finance — /erp/finance/receivables</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ErpFinance.razor) · Route: `/erp/finance/receivables`

`FlatInfoItem`, `FlatPage`, `FlatPanel`, `FlatStatCard`.

![Erp Finance showcase](docs/images/showcase/erp-finance-receivables.png)

**Customer open items**

![Customer open items component panel](docs/images/showcase/erp-finance-receivables-panel-1.png)

</details>

<details>
<summary>Erp Hr — /erp/hr</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ErpHr.razor) · Route: `/erp/hr`

`FlatInfoItem`, `FlatPage`, `FlatPanel`, `FlatStatCard`.

![Erp Hr showcase](docs/images/showcase/erp-hr.png)

**Workforce by department**

![Workforce by department component panel](docs/images/showcase/erp-hr-panel-1.png)

**People actions**

![People actions component panel](docs/images/showcase/erp-hr-panel-2.png)

**Recent employees**

![Recent employees component panel](docs/images/showcase/erp-hr-panel-3.png)

</details>

<details>
<summary>Erp Hr — /erp/hr/employees</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ErpHr.razor) · Route: `/erp/hr/employees`

`FlatInfoItem`, `FlatPage`, `FlatPanel`, `FlatStatCard`.

![Erp Hr showcase](docs/images/showcase/erp-hr-employees.png)

</details>

<details>
<summary>Erp Hr — /erp/hr/attendance</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ErpHr.razor) · Route: `/erp/hr/attendance`

`FlatInfoItem`, `FlatPage`, `FlatPanel`, `FlatStatCard`.

![Erp Hr showcase](docs/images/showcase/erp-hr-attendance.png)

**Today's attendance**

![Today's attendance component panel](docs/images/showcase/erp-hr-attendance-panel-1.png)

</details>

<details>
<summary>Erp Overview — /erp</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ErpOverview.razor) · Route: `/erp`

`FlatInfoItem`, `FlatPage`, `FlatPanel`, `FlatStatCard`.

![Erp Overview showcase](docs/images/showcase/erp.png)

**Revenue and operating cost**

![Revenue and operating cost component panel](docs/images/showcase/erp-panel-1.png)

**Workflow inbox**

![Workflow inbox component panel](docs/images/showcase/erp-panel-2.png)

**Business exceptions**

![Business exceptions component panel](docs/images/showcase/erp-panel-3.png)

</details>

<details>
<summary>Erp Production — /erp/production</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ErpProduction.razor) · Route: `/erp/production`

`FlatInfoItem`, `FlatPage`, `FlatPanel`, `FlatStatCard`.

![Erp Production showcase](docs/images/showcase/erp-production.png)

**Output by production line**

![Output by production line component panel](docs/images/showcase/erp-production-panel-1.png)

**Shift performance**

![Shift performance component panel](docs/images/showcase/erp-production-panel-2.png)

**Active production orders**

![Active production orders component panel](docs/images/showcase/erp-production-panel-3.png)

</details>

<details>
<summary>Erp Production — /erp/production/work-orders</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ErpProduction.razor) · Route: `/erp/production/work-orders`

`FlatInfoItem`, `FlatPage`, `FlatPanel`, `FlatStatCard`.

![Erp Production showcase](docs/images/showcase/erp-production-work-orders.png)

</details>

<details>
<summary>Erp Production — /erp/production/quality</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ErpProduction.razor) · Route: `/erp/production/quality`

`FlatInfoItem`, `FlatPage`, `FlatPanel`, `FlatStatCard`.

![Erp Production showcase](docs/images/showcase/erp-production-quality.png)

**Quality inspection queue**

![Quality inspection queue component panel](docs/images/showcase/erp-production-quality-panel-1.png)

</details>

<details>
<summary>Erp Release Train — /erp-release-train</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ErpReleaseTrain.razor) · Route: `/erp-release-train`

`FlatApprovalInbox`, `FlatApprovalInboxItem`, `FlatCapacityBucket`, `FlatGovernanceCheck`, `FlatGovernancePanel`, `FlatIntegrationCenter`, `FlatIntegrationRun`, `FlatInventoryAllocation`, `FlatInventoryAllocationWorkspace`, `FlatJournalEntryGrid`, `FlatMaterialRequirement`, `FlatMrpCapacityWorkspace`, `FlatNumberText`, `FlatPage`, `FlatTransactionEngine`, `FlatValidationIssue`, `FlatWorkflowDesigner`, `FlatWorkflowNode`.

![Erp Release Train showcase](docs/images/showcase/erp-release-train.png)

**2.1 · Transaction Engine**

![2.1 · Transaction Engine component panel](docs/images/showcase/erp-release-train-detail-1.png)

**2.2 · Inventory Allocation**

![2.2 · Inventory Allocation component panel](docs/images/showcase/erp-release-train-detail-2.png)

**2.3 · Finance**

![2.3 · Finance component panel](docs/images/showcase/erp-release-train-detail-3.png)

**2.4 · Workflow Designer**

![2.4 · Workflow Designer component panel](docs/images/showcase/erp-release-train-detail-4.png)

**2.4 · Approval Inbox**

![2.4 · Approval Inbox component panel](docs/images/showcase/erp-release-train-detail-5.png)

**2.5 · Integration Center**

![2.5 · Integration Center component panel](docs/images/showcase/erp-release-train-detail-6.png)

**3.0 · MRP and Capacity**

![3.0 · MRP and Capacity component panel](docs/images/showcase/erp-release-train-detail-7.png)

**3.0 · Governance**

![3.0 · Governance component panel](docs/images/showcase/erp-release-train-detail-8.png)

</details>

<details>
<summary>Erp Sales — /erp/sales</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ErpSales.razor) · Route: `/erp/sales`

`FlatInfoItem`, `FlatPage`, `FlatPanel`, `FlatStatCard`.

![Erp Sales showcase](docs/images/showcase/erp-sales.png)

**Sales versus target**

![Sales versus target component panel](docs/images/showcase/erp-sales-panel-1.png)

**Fulfillment pipeline**

![Fulfillment pipeline component panel](docs/images/showcase/erp-sales-panel-2.png)

**Sales orders**

![Sales orders component panel](docs/images/showcase/erp-sales-panel-3.png)

</details>

<details>
<summary>Erp Sales — /erp/sales/orders</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ErpSales.razor) · Route: `/erp/sales/orders`

`FlatInfoItem`, `FlatPage`, `FlatPanel`, `FlatStatCard`.

![Erp Sales showcase](docs/images/showcase/erp-sales-orders.png)

**Sales versus target**

![Sales versus target component panel](docs/images/showcase/erp-sales-orders-panel-1.png)

**Fulfillment pipeline**

![Fulfillment pipeline component panel](docs/images/showcase/erp-sales-orders-panel-2.png)

**Sales orders**

![Sales orders component panel](docs/images/showcase/erp-sales-orders-panel-3.png)

</details>

<details>
<summary>Erp Supply Chain — /erp/procurement</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ErpSupplyChain.razor) · Route: `/erp/procurement`

`FlatInfoItem`, `FlatPage`, `FlatPanel`, `FlatStatCard`.

![Erp Supply Chain showcase](docs/images/showcase/erp-procurement.png)

**Spend by category**

![Spend by category component panel](docs/images/showcase/erp-procurement-panel-1.png)

**Procurement actions**

![Procurement actions component panel](docs/images/showcase/erp-procurement-panel-2.png)

**Recent purchase orders**

![Recent purchase orders component panel](docs/images/showcase/erp-procurement-panel-3.png)

</details>

<details>
<summary>Erp Supply Chain — /erp/inventory</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ErpSupplyChain.razor) · Route: `/erp/inventory`

`FlatInfoItem`, `FlatPage`, `FlatPanel`, `FlatStatCard`.

![Erp Supply Chain showcase](docs/images/showcase/erp-inventory.png)

</details>

<details>
<summary>Erp Toolkit — /erp-toolkit</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ErpToolkit.razor) · Route: `/erp-toolkit`

`FlatBackgroundOperation`, `FlatBackgroundOperationCenter`, `FlatEntityLookup`, `FlatInfoItem`, `FlatJournalEntryGrid`, `FlatLifecycleStep`, `FlatMoneyInput`, `FlatPage`, `FlatPlanningBoard`, `FlatQuantityInput`, `FlatReconciliationWorkspace`, `FlatRecordLifecycleHeader`, `FlatTransactionAction`, `FlatTransactionWorkspace`.

![Erp Toolkit showcase](docs/images/showcase/erp-toolkit.png)

**Transaction Workspace**

![Transaction Workspace component panel](docs/images/showcase/erp-toolkit-detail-1.png)

**Entity Lookup and Composite Inputs**

![Entity Lookup and Composite Inputs component panel](docs/images/showcase/erp-toolkit-detail-2.png)

**Background Operations**

![Background Operations component panel](docs/images/showcase/erp-toolkit-detail-3.png)

**Journal Entry Grid**

![Journal Entry Grid component panel](docs/images/showcase/erp-toolkit-detail-4.png)

**Reconciliation Workspace**

![Reconciliation Workspace component panel](docs/images/showcase/erp-toolkit-detail-5.png)

**Planning Board**

![Planning Board component panel](docs/images/showcase/erp-toolkit-detail-6.png)

</details>

<details>
<summary>Experience Toolkit — /experience-toolkit</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ExperienceToolkit.razor) · Route: `/experience-toolkit`

`FlatAccessibilitySettings`, `FlatCollaborationComment`, `FlatCollaborationPanel`, `FlatCommandDefinition`, `FlatCommandPalette`, `FlatConflictField`, `FlatConflictResolver`, `FlatFeatureView`, `FlatFormFieldDefinition`, `FlatFormStepDefinition`, `FlatFormValidationIssue`, `FlatOperationState`, `FlatPage`, `FlatPermissionView`, `FlatPresenceUser`, `FlatSchemaForm`, `FlatSessionTimeout`, `FlatUnsavedChangesGuard`.

![Experience Toolkit showcase](docs/images/showcase/experience-toolkit.png)

**Hybrid recovery**

![Hybrid recovery component panel](docs/images/showcase/experience-toolkit-panel-1.png)

**Hybrid recovery**

![Hybrid recovery component panel](docs/images/showcase/experience-toolkit-panel-2.png)

**Mobile reliability**

![Mobile reliability component panel](docs/images/showcase/experience-toolkit-panel-3.png)

**Command Palette**

![Command Palette component panel](docs/images/showcase/experience-toolkit-detail-1.png)

**Advanced Schema Form**

![Advanced Schema Form component panel](docs/images/showcase/experience-toolkit-detail-2.png)

**Accessibility Gate**

![Accessibility Gate component panel](docs/images/showcase/experience-toolkit-detail-3.png)

**Realtime Collaboration UI**

![Realtime Collaboration UI component panel](docs/images/showcase/experience-toolkit-detail-4.png)

**Offline Conflict Workspace**

![Offline Conflict Workspace component panel](docs/images/showcase/experience-toolkit-detail-5.png)

**Global Application Foundation**

![Global Application Foundation component panel](docs/images/showcase/experience-toolkit-detail-6.png)

**Workspace State & Server Data**

![Workspace State &amp; Server Data component panel](docs/images/showcase/experience-toolkit-detail-7.png)

**Undo, Redo & Observability**

![Undo, Redo &amp; Observability component panel](docs/images/showcase/experience-toolkit-detail-8.png)

**Security & Accessibility UX**

![Security &amp; Accessibility UX component panel](docs/images/showcase/experience-toolkit-detail-9.png)

</details>

<details>
<summary>File Upload — /file-upload</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/FileUpload.razor) · Route: `/file-upload`

`FlatFileUpload`, `FlatFileUploadResult`, `FlatImageUpload`, `FlatPage`, `FlatPanel`.

![File Upload showcase](docs/images/showcase/file-upload.png)

**Flat File Upload**

![Flat File Upload component panel](docs/images/showcase/file-upload-panel-1.png)

**Flat File Upload**

![Flat File Upload component panel](docs/images/showcase/file-upload-panel-2.png)

**Multiple Image Upload**

![Multiple Image Upload component panel](docs/images/showcase/file-upload-panel-3.png)

</details>

<details>
<summary>Grid Editor — /grid-editor</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/GridEditor.razor) · Route: `/grid-editor`

`FlatEditableGrid`, `FlatEmptyState`, `FlatGridEditResult`, `FlatInfoItem`, `FlatPage`.

![Grid Editor showcase](docs/images/showcase/grid-editor.png)

</details>

<details>
<summary>Grid Preferences — /grid-preferences</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/GridPreferences.razor) · Route: `/grid-preferences`

`FlatDataGrid`, `FlatGridCellContext`, `FlatGridPreferencesPanel`, `FlatPage`, `FlatPanel`.

![Grid Preferences showcase](docs/images/showcase/grid-preferences.png)

**Advanced Grid Preferences**

![Advanced Grid Preferences component panel](docs/images/showcase/grid-preferences-panel-1.png)

**Advanced Grid Preferences**

![Advanced Grid Preferences component panel](docs/images/showcase/grid-preferences-panel-2.png)

</details>

<details>
<summary>Grouped Data Grid — /grouped-data-grid</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/GroupedDataGrid.razor) · Route: `/grouped-data-grid`

`FlatGroupedDataGrid`, `FlatGroupedGridGroup`, `FlatInfoItem`, `FlatPage`.

![Grouped Data Grid showcase](docs/images/showcase/grouped-data-grid.png)

</details>

<details>
<summary>Hierarchy Designer — /hierarchy-designer</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/HierarchyDesigner.razor) · Route: `/hierarchy-designer`

`FlatHierarchyDesigner`, `FlatHierarchyDesignerItem`, `FlatPage`, `FlatPanel`.

![Hierarchy Designer showcase](docs/images/showcase/hierarchy-designer.png)

</details>

<details>
<summary>Home — /</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/Home.razor) · Route: `/`

`FlatPage`, `FlatPanel`, `FlatStatCard`.

![Home showcase](docs/images/showcase/dashboard.png)

**Ticket Trend**

![Ticket Trend component panel](docs/images/showcase/dashboard-panel-1.png)

**Recent Activity**

![Recent Activity component panel](docs/images/showcase/dashboard-panel-2.png)

**Priority Assets**

![Priority Assets component panel](docs/images/showcase/dashboard-panel-3.png)

</details>

<details>
<summary>Job Landing — /job-landing</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/JobLanding.razor) · Route: `/job-landing`

`FlatEmptyState`, `FlatJobEmailApplicationDialog`.

![Job Landing showcase](docs/images/showcase/job-landing.png)

</details>

<details>
<summary>Jobs — /jobs</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/Jobs.razor) · Route: `/jobs`

`FlatCardGrid`, `FlatFormModal`, `FlatJobCard`, `FlatPage`, `FlatPanel`, `FlatVacancyActions`.

![Jobs showcase](docs/images/showcase/jobs.png)

**Hiring trend**

![Hiring trend component panel](docs/images/showcase/jobs-panel-1.png)

**Hiring trend**

![Hiring trend component panel](docs/images/showcase/jobs-panel-2.png)

**Recent activity**

![Recent activity component panel](docs/images/showcase/jobs-panel-3.png)

**Open roles**

![Open roles component panel](docs/images/showcase/jobs-panel-4.png)

</details>

<details>
<summary>Kanban — /kanban</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/Kanban.razor) · Route: `/kanban`

`FlatFab`, `FlatKanbanBoard`, `FlatKanbanCard`, `FlatPage`.

![Kanban showcase](docs/images/showcase/kanban.png)

</details>

<details>
<summary>Login — /login</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/Login.razor) · Route: `/login`

![Login showcase](docs/images/showcase/login.png)

</details>

<details>
<summary>Model Crud — /model-crud</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ModelCrud.razor) · Route: `/model-crud`

`FlatEntityLookup`, `FlatFileUploadResult`, `FlatGridEditResult`, `FlatImageUpload`, `FlatModelCrud`, `FlatModelFieldDefinition`, `FlatPage`.

![Model Crud showcase](docs/images/showcase/model-crud.png)

</details>

<details>
<summary>Model Form Designer — /model-form-designer</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ModelFormDesigner.razor) · Route: `/model-form-designer`

`FlatModelFieldDefinition`, `FlatModelFormDesigner`, `FlatPage`.

![Model Form Designer showcase](docs/images/showcase/model-form-designer.png)

</details>

<details>
<summary>Monitoring — /monitoring</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/Monitoring.razor) · Route: `/monitoring`

`FlatInfoItem`, `FlatPanel`, `FlatStatCard`.

![Monitoring showcase](docs/images/showcase/monitoring.png)

**Live endpoint status**

![Live endpoint status component panel](docs/images/showcase/monitoring-panel-1.png)

**Incident feed**

![Incident feed component panel](docs/images/showcase/monitoring-panel-2.png)

**Notebook Finance 01**

![Notebook Finance 01 component panel](docs/images/showcase/monitoring-panel-3.png)

**Notebook HR 02**

![Notebook HR 02 component panel](docs/images/showcase/monitoring-panel-4.png)

**Production Scanner Gate**

![Production Scanner Gate component panel](docs/images/showcase/monitoring-panel-5.png)

**Warehouse Packing**

![Warehouse Packing component panel](docs/images/showcase/monitoring-panel-6.png)

**Developer Mobile Rig**

![Developer Mobile Rig component panel](docs/images/showcase/monitoring-panel-7.png)

**Quality Station**

![Quality Station component panel](docs/images/showcase/monitoring-panel-8.png)

</details>

<details>
<summary>Monitoring Computers — /monitoring/computers</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/MonitoringComputers.razor) · Route: `/monitoring/computers`

`FlatEmptyState`, `FlatInfoItem`, `FlatMobileGrid`, `FlatPage`.

![Monitoring Computers showcase](docs/images/showcase/monitoring-computers.png)

</details>

<details>
<summary>Monitoring Database — /monitoring-database</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/MonitoringDatabase.razor) · Route: `/monitoring-database`

`FlatEmptyState`, `FlatInfoItem`, `FlatMobileGrid`, `FlatPage`.

![Monitoring Database showcase](docs/images/showcase/monitoring-database.png)

</details>

<details>
<summary>Not Found — /not-found</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/NotFound.razor) · Route: `/not-found`

![Not Found showcase](docs/images/showcase/not-found.png)

</details>

<details>
<summary>Operations Workspace — /operations-workspace</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/OperationsWorkspace.razor) · Route: `/operations-workspace`

`FlatEmptyState`, `FlatInfoItem`, `FlatOperationalWorkItem`, `FlatPage`, `FlatStatusChip`.

![Operations Workspace showcase](docs/images/showcase/operations-workspace.png)

**VPN access is unavailable**

![VPN access is unavailable component panel](docs/images/showcase/operations-workspace-detail-1.png)

**Replace warehouse scanner**

![Replace warehouse scanner component panel](docs/images/showcase/operations-workspace-detail-2.png)

</details>

<details>
<summary>Pdf Viewer — /pdf-viewer</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/PdfViewer.razor) · Route: `/pdf-viewer`

`FlatPage`, `FlatPdfViewer`.

![Pdf Viewer showcase](docs/images/showcase/pdf-viewer.png)

</details>

<details>
<summary>Pivot — /pivot</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/Pivot.razor) · Route: `/pivot`

`FlatFormModal`, `FlatInfoItem`, `FlatPage`, `FlatPivotGrid`.

![Pivot showcase](docs/images/showcase/pivot.png)

</details>

<details>
<summary>Product Detail — /product-detail</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ProductDetail.razor) · Route: `/product-detail`

`FlatFormModal`, `FlatPage`, `FlatProductDetail`, `FlatProductMetric`.

![Product Detail showcase](docs/images/showcase/product-detail.png)

</details>

<details>
<summary>Product Editor — /product-editor</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ProductEditor.razor) · Route: `/product-editor`

`FlatEditorSection`, `FlatEditorWorkspace`, `FlatFileUpload`, `FlatFileUploadItem`, `FlatMultiSelect`, `FlatMultiSelectOption`, `FlatPage`, `FlatUnsavedChangesGuard`.

![Product Editor showcase](docs/images/showcase/product-editor.png)

</details>

<details>
<summary>Product Management — /product-management</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ProductManagement.razor) · Route: `/product-management`

`FlatDataGrid`, `FlatEmptyState`, `FlatFilterWorkspace`, `FlatFormModal`, `FlatInfoItem`, `FlatMobileGrid`, `FlatPage`, `FlatPager`.

![Product Management showcase](docs/images/showcase/product-management.png)

</details>

<details>
<summary>Profile Grid — /profile-grid</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ProfileGrid.razor) · Route: `/profile-grid`

`FlatCardGrid`, `FlatFab`, `FlatFormModal`, `FlatPage`, `FlatProfileCard`, `FlatProfileCardStat`, `FlatProfileListItem`, `FlatStatusChip`.

![Profile Grid showcase](docs/images/showcase/profile-grid.png)

</details>

<details>
<summary>Reports — /reports</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/Reports.razor) · Route: `/reports`

`FlatFormModal`, `FlatInfoItem`, `FlatOperationalReportViewer`, `FlatPage`, `FlatStatCard`.

![Reports showcase](docs/images/showcase/reports.png)

</details>

<details>
<summary>Reset Password — /reset-password</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/ResetPassword.razor) · Route: `/reset-password`

![Reset Password showcase](docs/images/showcase/reset-password.png)

</details>

<details>
<summary>Sales Pipeline — /sales-pipeline</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/SalesPipeline.razor) · Route: `/sales-pipeline`

`FlatKanbanBoard`, `FlatPage`, `FlatPipelineCard`.

![Sales Pipeline showcase](docs/images/showcase/sales-pipeline.png)

</details>

<details>
<summary>Scheduler — /scheduler</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/Scheduler.razor) · Route: `/scheduler`

`FlatPage`, `FlatScheduler`, `FlatSchedulerCalendar`, `FlatSchedulerItem`.

![Scheduler showcase](docs/images/showcase/scheduler.png)

</details>

<details>
<summary>Simple Crud — /crud-simple</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/SimpleCrud.razor) · Route: `/crud-simple`

`FlatPage`.

![Simple Crud showcase](docs/images/showcase/crud-simple.png)

</details>

<details>
<summary>Spatial Operations — /spatial-operations</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/SpatialOperations.razor) · Route: `/spatial-operations`

`FlatMapPoint`, `FlatPage`, `FlatSpatialGeofence`, `FlatSpatialLayer`, `FlatSpatialWorkspace`, `FlatVectorMap`, `FlatVectorMapMarker`, `FlatVectorMapRegion`, `FlatVectorMapRoute`.

![Spatial Operations showcase](docs/images/showcase/spatial-operations.png)

</details>

<details>
<summary>Static Data — /static-data</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/StaticData.razor) · Route: `/static-data`

`FlatEmptyState`, `FlatInfoItem`, `FlatMobileGrid`, `FlatPage`.

![Static Data showcase](docs/images/showcase/static-data.png)

</details>

<details>
<summary>Timeline — /timeline</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/Timeline.razor) · Route: `/timeline`

`FlatPage`, `FlatProfileAvatar`, `FlatTimeline`.

![Timeline showcase](docs/images/showcase/timeline.png)

</details>

<details>
<summary>Tree Grid — /tree-grid</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/TreeGrid.razor) · Route: `/tree-grid`

`FlatEmptyState`, `FlatPage`, `FlatPanel`, `FlatTreeGrid`, `FlatTreeGridMoveResult`.

![Tree Grid showcase](docs/images/showcase/tree-grid.png)

</details>

<details>
<summary>Two Step Verification — /two-step-verification</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/TwoStepVerification.razor) · Route: `/two-step-verification`

![Two Step Verification showcase](docs/images/showcase/two-step-verification.png)

</details>

<details>
<summary>Vector Map — /vector-map</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/VectorMap.razor) · Route: `/vector-map`

`FlatMapPoint`, `FlatPage`, `FlatVectorMap`, `FlatVectorMapMarker`, `FlatVectorMapRegion`, `FlatVectorMapRoute`.

![Vector Map showcase](docs/images/showcase/vector-map.png)

</details>

<details>
<summary>Website Home — /website</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/WebsiteHome.razor) · Route: `/website`

`FlatCatalogCard`, `FlatCatalogGrid`.

![Website Home showcase](docs/images/showcase/website.png)

</details>

<details>
<summary>Widgets — /widgets</summary>

[Canonical source](samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/Widgets.razor) · Route: `/widgets`

`FlatActionMetricWidget`, `FlatActivityItem`, `FlatCompactMetric`, `FlatMetricWidget`, `FlatPage`, `FlatProgressWidget`, `FlatSegmentProgressWidget`, `FlatTaskItem`, `FlatWidget`.

![Widgets showcase](docs/images/showcase/widgets.png)

**Tile boxes**

![Tile boxes component panel](docs/images/showcase/widgets-detail-1.png)

**Compact metrics**

![Compact metrics component panel](docs/images/showcase/widgets-detail-2.png)

**Statistics**

![Statistics component panel](docs/images/showcase/widgets-detail-3.png)

**Other widgets**

![Other widgets component panel](docs/images/showcase/widgets-detail-4.png)

</details>

<details>
<summary>Open dialogs and command palette</summary>

**Question message box** · `/components`

![Question message box](docs/images/showcase/message-box-question.png)

**Warning message box** · `/components`

![Warning message box](docs/images/showcase/message-box-warning.png)

**Information message box** · `/components`

![Information message box](docs/images/showcase/message-box-info.png)

**Error message box** · `/components`

![Error message box](docs/images/showcase/message-box-error.png)

**Form modal** · `/components`

![Form modal](docs/images/showcase/form-modal.png)

**Command palette** · `/experience-toolkit`

![Command palette](docs/images/showcase/command-palette.png)

</details>

<!-- END GENERATED SHOWCASE GALLERY -->

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
| `Opx.MudBlazor.FlatUi` | `2.1.27` |
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

The Web template produces sibling `MyOpxApp` (thin executable host) and `Opx.MudBlazor.FlatUi.Showcase` (shared page composition) projects. The first run cleans both projects' exact `bin` and `obj`, restores reusable OPX UI 2.1.27 from NuGet.org, and starts with the canonical Light theme, Settings menu, default navigation, package-owned CSS, responsive rules, first-paint typography/density restoration, and runtime OPX attribution.

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

The MAUI template pins MAUI `10.0.90`, CommunityToolkit.Maui `15.0.1`, MudBlazor `9.9.0`, and OPX Flat UI `2.1.27`. It replaces stock .NET/MAUI splash artwork with a neutral white-on-white invisible launch asset, then hands off to the continuous `Memuat` spinner. It also includes first-paint Device/Manual font and density restoration, the native status-bar bridge, root-before-`Router` authorization gate, Settings, default sidebar/Bottom navigation, Device typography, no-bounce WebView handlers, textbox-only text selection, package-only reusable CSS, a machine-readable mobile contract, and its audit script. Android 12+ still owns a mandatory system splash frame; the template removes its stock artwork rather than claiming that OS frame can be eliminated. Replace the sample authorization validator and sample business data before production use.

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
