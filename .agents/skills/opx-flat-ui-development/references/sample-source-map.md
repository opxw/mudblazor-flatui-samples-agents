# Sample source map

Copyright (c) 2026 opx. All rights reserved.

Resolve paths from the repository root. Read only the archetypes relevant to the requested change, but read each selected file completely.

## Shell, navigation, and configuration

- Application root/reconnect: `samples/Opx.MudBlazor.FlatUi.Sample/Components/App.razor`
- Service/configuration binding: `samples/Opx.MudBlazor.FlatUi.Sample/Program.cs` and `samples/Opx.MudBlazor.FlatUi.Sample/appsettings.json`
- Admin shell, AppBar actions, settings: `samples/Opx.MudBlazor.FlatUi.Sample/Components/Layout/MainLayout.razor`
- Sidebar tree: `samples/Opx.MudBlazor.FlatUi.Sample/Components/Layout/SampleSidebarMenu.razor`
- Public website shell: `samples/Opx.MudBlazor.FlatUi.Sample/Components/Layout/WebsiteLayout.razor`
- Authentication shell: `samples/Opx.MudBlazor.FlatUi.Sample/Components/Layout/AuthLayout.razor`

## Page archetypes

- Full responsive CRUD/grid/filter/paging/FAB/modal: `samples/Opx.MudBlazor.FlatUi.Sample/Components/Pages/Crud.razor`
- Compact/simple CRUD: `samples/Opx.MudBlazor.FlatUi.Sample/Components/Pages/SimpleCrud.razor`
- Static responsive data list: `samples/Opx.MudBlazor.FlatUi.Sample/Components/Pages/StaticData.razor`
- Large two-axis scrolling DataGrid with responsive cards: `samples/Opx.MudBlazor.FlatUi.Sample/Components/Pages/DataGridLarge.razor`
- Inline Add/Edit/Delete grid with responsive editor cards: `samples/Opx.MudBlazor.FlatUi.Sample/Components/Pages/GridEditor.razor`
- Dashboard/widgets/charts: `Home.razor`, `Widgets.razor`, and ERP overview pages under `Components/Pages`
- Complete MudBlazor chart gallery with copy-ready code: `Charts.razor` and `Components/ChartCode.razor`
- Host-owned file upload with progress/cancel/retry: `FileUpload.razor` and `Components/FlatFileUpload.razor`
- Versioned grid presentation state and saved views: `GridPreferences.razor`, `Components/Grid/FlatGridPreferencesPanel.razor`, and `Models/FlatGridPreferences.cs`
- Hierarchical Tree Grid with host-owned parent persistence: `TreeGrid.razor`, `Components/Grid/FlatTreeGrid.razor`, and `Models/FlatTreeGridModels.cs`
- Monitoring and reports: `Monitoring.razor`, `MonitoringDatabase.razor`, `Reports.razor`, `Pivot.razor`, `Components/Reporting/FlatOperationalReportViewer.razor`, and `Components/Reporting/FlatPivotGrid.razor`
- Reusable controls and modal/message-box/reconnect previews: `ComponentsGallery.razor`
- Account editor and multi-select: `EditAccount.razor`
- Kanban, chat, AI chat, email, jobs, timeline: `Kanban.razor`, `Chat.razor`, `AiChat.razor`, `Email.razor`, `Jobs.razor`, and `Timeline.razor`
- Public landing/storefront/content: `WebsiteHome.razor`, `Catalog.razor`, and `Blog.razor`
- Authentication: `Login.razor`, `TwoStepVerification.razor`, and `ResetPassword.razor`
- ERP modules: files prefixed with `Erp` under `samples/Opx.MudBlazor.FlatUi.Sample/Components/Pages`

## Reusable source ownership

- Page shell, automatic initial skeleton, toolbar, FAB, responsive helpers: `src/Opx.MudBlazor.FlatUi/Components/FlatPage.razor`, `FlatPageSkeleton.razor`, `FlatPanel.razor`, and `FlatFab.razor`
- Grid/paging/filter/loading state: `src/Opx.MudBlazor.FlatUi/Components/Grid`, including `FlatDataGridSkeleton.razor`, and related grid models/components
- CRUD editor/modal/processing: `CrudEditorShell.razor`, `FlatFormModal.razor`, and `FlatProcessingContainer.razor`
- App shell/navigation: `FlatAppShell.razor`, `FlatAppBar.razor`, `FlatSidebar.razor`, `FlatNavigationBadge.razor`, `FlatHorizontalNavigation.razor`, and `FlatBottomNavigation.razor`
- Theme/configuration/preferences/loading defaults: `src/Opx.MudBlazor.FlatUi/Models/FlatUiTheme.cs`, `FlatUiDisplayPreferences.cs`, `FlatLoadingOptions.cs`, and `Services/FlatUiPreferencesService.cs`
- Shared styling/interop: `src/Opx.MudBlazor.FlatUi/wwwroot/opx-flat-ui.css` and canonical source `opx-flat-ui.js`; `opx-flat-ui.min.js` is Release/Pack output and must not be edited manually.
- Asset selection/build: `src/Opx.MudBlazor.FlatUi/Models/FlatAssetOptions.cs`, the RCL project targets, root `package.json`/`package-lock.json`, and the host `Components/App.razor`.

## Documentation routing

- Release sequence, feature scope, test/compatibility gates: `ROADMAP.md`
- Grid/API/loading: `docs/API-GRID-LOADING.md`
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
- Domain templates: use the matching `docs/*TEMPLATE.md`, `docs/WIDGETS.md`, `docs/TIMELINE.md`, or `docs/JOBS-DASHBOARD.md`.

When documentation disagrees with an accepted, compiled sample behavior, verify the intended contract and update stale documentation in the same task.
