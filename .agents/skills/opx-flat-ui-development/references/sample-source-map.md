# Sample source map

Current import: 2.1.31 at upstream commit e7c743d. See [upstream-2.1.31.md](upstream-2.1.31.md) for new PageIds and component previews; those additional routes remain upstream-only. Existing local route/profile registry still describes the compiled consumer. Earlier import notes below are historical provenance.

2.1.31 verification: source HEAD is still `26d476b`; the package/CSS bump is in the upstream working tree. No newer skill/rule/agent delta exists there. Current lookup-header guidance is derived from its CSS and exact NuGet stylesheet; prior imported reporting and transfer references remain applicable.

2.1.31 import source: `D:\projects\git\mudblazor-flat-ui`, commit `26d476b`. Reporting maps to `opx.page.reporting.operational`, local `Reports.razor` and `docs/REPORTING.md`; the responsive correction is package CSS, not consumer styling. Hybrid-operations/document-transfer maps to `opx.page.reference.experience-toolkit` / `opx.page.reporting.pdf-viewer` and `docs/HYBRID-OPERATIONS.md`. New transfer adapters/examples remain upstream references, not yet wired into this consumer by this dependency/rules import.

PDF printing: `opx.page.reporting.pdf-viewer` -> `PdfViewer.razor` and shared `SamplePdfDocument.cs`; use `docs/PRINT-SUPPORT.md`. Web registers `FlatWebPrintService`; MAUIHost uses `MauiPrintService`, `AndroidPdfPrintAdapter`, and `WindowsPdfPrintPage`. These native adapters are host-owned, not installed by NuGet or the minimal MAUI template.

Hybrid recovery: `HybridRecoveryExamples.razor`, composed by `MobileReliabilityExamples.razor` under `opx.page.reference.experience-toolkit`; see `docs/HYBRID-RECOVERY.md`. Bottom Back acceptance uses `opx.page.erp.finance.general-ledger` and `docs/AUTH-AND-NAVIGATION.md`; follow actual visited menu history, not inferred route parents.

- Mobile reliability P0/P1/P2: `ExperienceToolkit.razor` embeds `MobileReliabilityExamples.razor` using `FlatPage.RefreshMode`, `FlatScrollRestoration`, `FlatSearchComboBox`, `FlatFormModal`, and opt-in `FlatMobileDiagnostics`. Read `docs/MOBILE-RELIABILITY.md`; native adapters and scoped durable workspace persistence remain host-owned.

- Multipurpose ERP/HR/IoT: `EnterpriseToolkit.razor` embeds `MultiPurposeExamples.razor`, reusing `FlatMasterDetailWorkspace`, `FlatScheduler`, `FlatOfflineSyncPanel`, `FlatDocumentWorkspace`, and `FlatDashboardComposer` with work-inbox, freshness, scanner, telemetry, relations, and personal-workspace contracts. See `docs/MULTIPURPOSE-TOOLKIT.md` for host ownership and validation limits.

Copyright (c) 2026 opx. All rights reserved.

Resolve paths from the repository root. Read only the archetypes relevant to the requested change, but read each selected file completely.

First resolve the request to a stable `PageId` in [page-registry.md](page-registry.md), then apply its canonical interaction/state profile from [showcase-behavior-registry.md](showcase-behavior-registry.md). This source map explains implementation ownership after page identity and behavior are known.

## Shell, navigation, and configuration

- MAUI Blazor Hybrid host reference: `samples/Opx.MudBlazor.FlatUi.MauiHost.Sample`, especially `MauiProgram.cs`, Android `MainActivity`, native `MainPage`, `Components/RootStartupGate.razor`, `Components/Layout/MainLayout.razor`, `Services`, and its project README. Android uses edge-to-edge, a transparent host-owned `CommunityToolkit.Maui` status bar, measured `WindowInsets`, and a `60px + inset` AppBar; Web/Windows remain unchanged.
- Shared pages, sample services, sample usage, page CSS, and typed navigation catalog: `samples/Opx.MudBlazor.FlatUi.Showcase`
- Web application root/reconnect: `samples/Opx.MudBlazor.FlatUi.Sample/Components/App.razor`
- Web service/configuration binding: `samples/Opx.MudBlazor.FlatUi.Sample/Program.cs` and `samples/Opx.MudBlazor.FlatUi.Sample/appsettings.json`
- Web admin shell, AppBar actions, and settings: `samples/Opx.MudBlazor.FlatUi.Sample/Components/Layout/MainLayout.razor`; reusable Settings composition/localization: package `FlatDisplaySettings`, `FlatDisplaySettingsConfiguration`, and `docs/DISPLAY-SETTINGS.md`
- Shared recursive menu and search metadata: `samples/Opx.MudBlazor.FlatUi.Showcase/ShowcaseNavigationCatalog.cs`
- Public website shell: `samples/Opx.MudBlazor.FlatUi.Showcase/Components/Layout/WebsiteLayout.razor`
- Authentication shell: `samples/Opx.MudBlazor.FlatUi.Showcase/Components/Layout/AuthLayout.razor`

## Page archetypes

- P1/P2 saved views, company/branch/site context, advanced nested filters, record sections, and bulk progress: `samples/Opx.MudBlazor.FlatUi.Showcase/Components/ProductivityExamples.razor`, composed by `Components/Pages/EnterpriseToolkit.razor`; contracts in `docs/P1-P2-PRODUCTIVITY.md`.

- Full responsive CRUD/grid/filter/paging/FAB/modal: `samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/Crud.razor`
- Compact/simple CRUD: `samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/SimpleCrud.razor`
- Static responsive data list: `samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/StaticData.razor`
- Large two-axis scrolling DataGrid with responsive cards: `samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/DataGridLarge.razor`
- Expandable grouped DataGrid with host-owned summaries and responsive grouped cards: `samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/GroupedDataGrid.razor`, `src/Opx.MudBlazor.FlatUi/Components/Grid/FlatGroupedDataGrid.razor`
- Inline Add/Edit/Delete grid with responsive editor cards: `samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages/GridEditor.razor`
- Dashboard/widgets/charts: `Home.razor`, `Widgets.razor`, and ERP overview pages under `Components/Pages`
- Complete MudBlazor chart gallery with copy-ready code: `Charts.razor` and `Components/ChartCode.razor`
- Host-owned file/image upload with preview, autoscale, progress/cancel/retry, and opt-in camera/gallery adapter buttons: `FileUpload.razor`, `Components/FlatFileUpload.razor`, `Models/FlatFileUploadModels.cs`, and `Components/FlatImageUpload.razor`
- Versioned grid presentation state and saved views: `GridPreferences.razor`, `Components/Grid/FlatGridPreferencesPanel.razor`, and `Models/FlatGridPreferences.cs`
- Hierarchical Tree Grid with host-owned parent persistence: `TreeGrid.razor`, `Components/Grid/FlatTreeGrid.razor`, and `Models/FlatTreeGridModels.cs`
- Compact hierarchy/outline design with sibling ordering and JSON snapshots: `HierarchyDesigner.razor`, `Components/FlatHierarchyDesigner.razor`, and `Models/FlatHierarchyDesignerModels.cs`
- Monitoring and reports: `Monitoring.razor`, `MonitoringComputers.razor`, `MonitoringDatabase.razor`, `Reports.razor`, `Pivot.razor`, `Components/Reporting/FlatOperationalReportViewer.razor`, and `Components/Reporting/FlatPivotGrid.razor`
- Responsive PDF.js preview with host-owned native print/share/open adapters: `PdfViewer.razor`, `Components/Reporting/FlatPdfViewer.razor`, `Models/FlatPdfViewerModels.cs`, and `docs/PDF-VIEWER.md`
- Enterprise 1.2-1.5 showroom and contracts: `EnterpriseToolkit.razor`, `docs/ENTERPRISE-TOOLKIT.md`, `Components/FlatDataImport.razor`, `FlatMasterDetailWorkspace.razor`, `FlatAuditTrail.razor`, `FlatSchemaForm.razor`, `FlatWorkflowPanel.razor`, `FlatBulkActionBar.razor`, `FlatScheduler.razor`, `FlatDashboardComposer.razor`, `FlatNotificationCenter.razor`, `FlatOfflineSyncPanel.razor`, `FlatDocumentWorkspace.razor`, and `FlatPrintLayout.razor`
- Application experience 1.6-2.3: `ExperienceToolkit.razor`, `docs/APPLICATION-EXPERIENCE-2.0.md`, `docs/GLOBAL-APPLICATION-FEATURES.md`, `FlatCommandPalette`, `FlatSchemaForm`, `FlatCollaborationPanel`, `FlatConflictResolver`, `FlatUnsavedChangesGuard`, `FlatPermissionView`, `FlatFeatureView`, `FlatOperationState`, `FlatSessionTimeout`, and `FlatAccessibilitySettings`.
- Operational compositions 2.0: `OperationsWorkspace.razor` and the host-owned typed contracts in `Models/FlatExperienceModels.cs`
- Business composition controls: `BusinessToolkit.razor`, `docs/BUSINESS-COMPONENTS.md`, the eight `Flat*` business components, and `Models/FlatBusinessComponentModels.cs`; hosts own persistence, validation, permissions, routing engines, and business mutation.
- ERP release sequencing and gap ownership: `ROADMAP.md` and `docs/ERP-RELEASE-TRAIN.md`; extend the mapped foundations per milestone rather than introducing duplicate page-local components.
- ERP 2.1-3.0 compiled showroom: `ErpReleaseTrain.razor`, `Models/FlatErpReleaseModels.cs`, `FlatTransactionEngine`, `FlatInventoryAllocationWorkspace`, `FlatWorkflowDesigner`, `FlatApprovalInbox`, `FlatIntegrationCenter`, `FlatMrpCapacityWorkspace`, and `FlatGovernancePanel`.
- Standalone Advanced Editable Grid showroom: `AdvancedEditableGrid.razor` and `Grid/FlatAdvancedEditableGrid.razor`; use PageId `opx.page.operations.advanced-editable-grid`.
- Reusable controls and modal/message-box/reconnect previews: `ComponentsGallery.razor`; disclosure variants and usage: `Accordions.razor`, `Components/FlatAccordion.razor`, and `FlatAccordionItem.razor`
- Concise executable summary of repository rules and development workflow: `DevelopmentRules.razor`; canonical details remain in root `RULES.md`, `.agents/RULES.md`, this skill, `page-registry.md`, and this source map.
- Route-wide sample-code disclosure: `samples/Opx.MudBlazor.FlatUi.Showcase/Components/SamplePageUsage.razor`, mounted once by `MainLayout`, `AuthLayout`, and `WebsiteLayout`; detailed component-specific examples remain page-local.
- Account editor and multi-select: `EditAccount.razor`
- Kanban, calendar, scheduler, chat, AI chat, email, jobs, timeline: `Kanban.razor`, `Calendar.razor`, `Scheduler.razor`, `Components/FlatCalendar.razor`, `Components/FlatScheduler.razor`, `Chat.razor`, `AiChat.razor`, `Email.razor`, `Jobs.razor`, and `Timeline.razor`
- Provider-neutral SVG floor plan, projected location tracking, and route presentation: `VectorMap.razor`, `Components/FlatVectorMap.razor`, `Models/FlatVectorMapModels.cs`, and `docs/VECTOR-MAP.md`
- Positioned machine/computer/device workspace: `AssetLayout.razor`, package `FlatAssetLayout`, `FlatVectorMap`, `FlatAssetLayoutModels`, and `docs/ASSET-LAYOUT.md`
- Profile card and compact people-directory list: `ProfileGrid.razor`, package `FlatCardGrid`, `FlatProfileCard`, `FlatProfileListItem`, and `FlatProfileAvatar`
- Public landing/storefront/content: `WebsiteHome.razor`, `JobLanding.razor`, `Catalog.razor`, and `Blog.razor`; filter-heavy administration workspace: `ProductManagement.razor`; media/detail composition: `ProductDetail.razor`; large editor/settings rail: `ProductEditor.razor`
- Authentication: `Login.razor`, `TwoStepVerification.razor`, and `ResetPassword.razor`
- ERP modules: files prefixed with `Erp` under `samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages`; reusable transaction, lookup, journal, reconciliation, planning, lifecycle, and background-operation composition: `ErpToolkit.razor` and `Models/FlatErpModels.cs`

## Reusable source ownership

- Page shell, automatic initial skeleton, toolbar, FAB, responsive helpers: `src/Opx.MudBlazor.FlatUi/Components/FlatPage.razor`, `FlatPageSkeleton.razor`, `FlatPanel.razor`, and `FlatFab.razor`
- Grid/paging/filter/loading state: `src/Opx.MudBlazor.FlatUi/Components/Grid`, including `FlatDataGridSkeleton.razor`, and related grid models/components
- Spatial operations workspace: `src/Opx.MudBlazor.FlatUi/Components/FlatSpatialWorkspace.razor`, `FlatVectorMap.razor`, and `Models/FlatSpatialModels.cs`; canonical sample: `SpatialOperations.razor`; contract: `docs/SPATIAL-OPERATIONS.md`
- Machine/computer/device layout workspace: package `FlatAssetLayout`, `FlatVectorMap`, and `FlatAssetLayoutModels`; canonical sample: `AssetLayout.razor`; contract: `docs/ASSET-LAYOUT.md`
- Metadata-driven list and CRUD: `src/Opx.MudBlazor.FlatUi/Components/FlatModelCrud.razor`, `FlatModelForm.razor`, and `Models/FlatModelMetadata.cs`; canonical sample: `ModelCrud.razor`
- Visual metadata form design: `src/Opx.MudBlazor.FlatUi/Components/FlatModelFormDesigner.razor`, `Models/FlatModelFormDesignerModels.cs`, and `FlatModelForm.razor`; canonical sample: `ModelFormDesigner.razor`
- CRUD editor/modal/processing: `CrudEditorShell.razor`, `FlatFormModal.razor`, and `FlatProcessingContainer.razor`
- App shell/navigation: `FlatAppShell.razor`, `FlatAppBar.razor`, `FlatSidebar.razor`, `FlatNavigationBadge.razor`, `FlatHorizontalNavigation.razor`, and `FlatBottomNavigation.razor`
- Dynamic navigation autoload: `FlatDynamicMenu.razor`, `FlatDynamicMenuNodeView.razor`, and `Models/FlatDynamicMenuModels.cs`; canonical sample: `DynamicMenu.razor`. See `docs/DYNAMIC-MENU.md` for the 2.1.31 shared resolver/builder URL-normalization contract and cross-platform verification boundary.
- Theme/configuration/preferences/loading defaults: `src/Opx.MudBlazor.FlatUi/Models/FlatUiTheme.cs`, `FlatUiDisplayPreferences.cs`, `FlatLoadingOptions.cs`, and `Services/FlatUiPreferencesService.cs`
- Shared styling/interop: `src/Opx.MudBlazor.FlatUi/wwwroot/opx-flat-ui.css` and canonical source `opx-flat-ui.js`; `opx-flat-ui.min.js` is Release/Pack output and must not be edited manually.
- Asset selection/build: `src/Opx.MudBlazor.FlatUi/Models/FlatAssetOptions.cs`, the RCL project targets, root `package.json`/`package-lock.json`, and the host `Components/App.razor`.

## Documentation routing

- Release sequence, feature scope, test/compatibility gates: `ROADMAP.md`
- Release 2.1 contracts and quality gates: `docs/RELEASE-2.1.md`; canonical sample: `ReleaseQuality.razor`
- `1.0.x` to `1.1.0` host migration and validation: `docs/MIGRATION-1.1.md`
- `1.1.x` to `1.5.0` additive migration: `docs/MIGRATION-1.2-1.5.md`
- Enterprise components and host boundaries: `docs/ENTERPRISE-TOOLKIT.md`
- Accessibility, command palette, advanced schema form, collaboration, conflict, and operational compositions: `docs/APPLICATION-EXPERIENCE-2.0.md`
- `1.5.x` to `2.0.0` additive migration: `docs/MIGRATION-2.0.md`
- Grid/API/loading: `docs/API-GRID-LOADING.md`
- Automatic model list/grid/form CRUD: `docs/MODEL-CRUD.md`
- Operational reporting: `docs/REPORTING.md`
- Pivot analysis: `docs/PIVOT-GRID.md`
- MudBlazor chart types and data contracts: `docs/CHARTS.md`
- Test gates: `docs/TESTING.md`
- File upload: `docs/FILE-UPLOAD.md`
- Grid preferences and virtualization: `docs/GRID-PREFERENCES.md`
- Tree Grid hierarchy and parent-key persistence: `docs/TREE-GRID.md`
- JavaScript source/minification/host selection: `docs/ASSET-PIPELINE.md`
- Forms/modals/processing: `docs/FORM-MODAL.md` and `docs/PROCESSING-STATE.md`
- Navigation/auth/backdrop: `docs/AUTH-AND-NAVIGATION.md` and `docs/BACKDROP-AND-SCROLL-LOCK.md`
- Dynamic menu loading and hierarchy: `docs/DYNAMIC-MENU.md`
- Domain templates: use the matching `docs/*TEMPLATE.md`, `docs/WIDGETS.md`, `docs/TIMELINE.md`, or `docs/JOBS-DASHBOARD.md`.

When documentation disagrees with an accepted, compiled sample behavior, verify the intended contract and update stale documentation in the same task.
