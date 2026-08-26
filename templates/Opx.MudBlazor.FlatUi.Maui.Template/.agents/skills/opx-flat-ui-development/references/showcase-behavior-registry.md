# Canonical showcase behavior registry

Copyright (c) 2026 opx. All rights reserved.

Use this registry after resolving a prompt through `page-registry.md`. The user does not choose a behavior profile: infer the `PageId` from the job, workflow, data, shell, and device, then apply the profile mapped below and inspect the canonical source. Exact Sample Mode still requires copying the compiled sample structure rather than reconstructing it from this summary.

## Rules shared by every profile

- Preserve the Light default theme, Device/browser `1rem` typography, Manual `16px` baseline, package-owned CSS, Settings, default navigation, root-before-`Router` session gate, and the canonical OPX shell for the selected page.
- Treat `>900px` as desktop/table composition, `601-900px` as responsive/two-column composition, and `<=600px` as phone/one-column refinement unless the mapped component documents a narrower boundary. Responsive views share query, filter, sort, paging, selection, permission, loading, validation, and mutation state with desktop.
- Keep panel/widget spacing container-owned. Do not combine child outer margins with a parent gap or duplicate padding at the same boundary. An ordinary content-panel body must never start at a zero left inset: use logical `padding-inline` on the body, defaulting to `14px` desktop and `12px` at `<=900px`, unless the mapped compiled sample defines another positive value. An edge-to-edge table/media shell may keep outer `padding:0` only when its immediate readable content, empty/error state, toolbar, cards, or editor owns a positive logical inset; text and controls may never touch the panel border. Use logical properties so RTL receives the same protection. Widgets use the exact spacing contract in `docs/WIDGETS.md`.
- Keep loading, skeleton, empty, error, disabled, success, unsaved, conflict, permission, offline, and recovery states proportional to the workflow. Preserve visible focus, semantic names, keyboard/touch operation, reduced motion, text scaling, and no unintended document-level horizontal overflow.
- On responsive/mobile search or filter toolbars with at least two secondary actions, keep the full-width text field visible while the icon-action row defaults to collapsed/hidden (`MobileToolbarActionsExpandedByDefault=false`). Preserve the accessible Apps/Close toggle; desktop actions remain visible, and initial mobile expansion is explicit opt-in.
- Preserve layered Back behavior for modal workflows: the topmost modal/overlay consumes Back first without leaving the route, the next Back uses prior Blazor history, and MAUI native exit is possible only at the true root after both layers decline the event.
- The host owns authentication, authorization, domain data, formulas, validation authority, persistence, transactions, concurrency, audit, integrations, notifications, and native adapters. UI visibility is never authorization. Reusable components return exact typed intents and do not simulate successful business mutations.
- CRUD uses the visible verb `Edit`, never `Ubah`. Forms use one continuous theme-resolved field surface and one softened Primary one-pixel focus border. Guard dirty drafts; focus the first invalid field and expose a useful validation summary. Desktop forms are compact and multi-column when the data permits; phone forms become one column or a fullscreen editor without changing the draft.
- Data grids use compact search, hidden metadata icons, type-aware formatting/alignment, proportional/fixed column widths, opt-in wrapping, and exactly one bounded desktop scroll owner. At `<=900px`, render equivalent cards/lists when a table would become unreadable. Add/Edit/Save/Cancel must be functional; icon-only commands require tooltip and accessible name, and Undo/Redo is absent without a real history controller.
- In Exact Sample Mode, preserve geometry, hierarchy, responsive transformations, typography, spacing, states, actions, and scroll ownership. Adapt only host-owned branding, wording, records, permissions, callbacks, endpoints, and persistence through existing seams.
- Classify defects from evidence. If the defect reproduces in the unchanged canonical sample using the same supported NuGet version and comes from package-owned component/API/CSS/JavaScript behavior, write the exact phrase **"bug package"** in the diagnosis. If it occurs only in consumer markup, local CSS, configuration, host services, stale assets, or integration, write **"bug integrasi aplikasi"**. If the boundary is not yet proven, write **"belum terklasifikasi"** and state the missing comparison; never guess or use **"bug package"** merely because the symptom appears inside a package component.

## Behavior profiles

### `dashboard-overview`

Decision-oriented KPI and exception overview. Show units, period/freshness, comparison, trend, and drill-down only where they support a named decision. Desktop uses a compact widget grid; tablet uses two columns; phone uses one prioritized column. No KPI formula or threshold is invented by the UI.

### `native-host`

MAUI Hybrid capability summary and host diagnostics. Present real adapter snapshots and explicit capability actions; report unsupported, denied, failed, and successful states truthfully. Native permissions, lifecycle, secure storage, notifications, status bar, safe area, and hardware behavior remain host-owned and require device evidence.

### `native-performance`

Current-process startup and route-render checkpoints. Display named stages and repeated measurements without implying benchmark certainty. Compare Release runs only on the same named target; never substitute build time or browser timing for native runtime evidence.

### `native-compatibility`

Compatibility inspection for viewport, theme, lifecycle, WebView, status-bar inset, no-bounce, and selection contracts. Values are diagnostic observations, not inferred platform support. Keep tests compact, scrollable on short landscape screens, and truthful about unverified iOS/device behavior.

### `native-adapters`

User-initiated demonstrations of secure storage, camera, file picker, share, connectivity, and notification adapters. Gate permissions at the point of use, expose cancellation/denial/failure, and never auto-trigger intrusive native prompts on page load.

### `reference-showroom`

Component or token demonstration with compact sections, meaningful variants/states, and copy-ready sample disclosure. Preserve the component's real behavior and accessibility; do not turn showroom data into an application business contract.

### `settings-form`

Account/application settings editor with grouped fields, explicit Save/Cancel, validation, permission-aware sections, and dirty-state protection. Use a compact desktop form and one-column mobile/fullscreen editor where necessary; the host owns identity and persistence.

### `auth-form`

Focused authentication/recovery flow under the auth shell. Keep one primary action, clear validation/error/retry states, password/OTP accessibility, and safe return navigation. Desktop may use the configured split or boxed layout; phone uses the bounded compact form. Session validation remains server-owned.

### `public-content`

Public editorial or landing composition with semantic headings, readable measure, progressive one-column collapse, and accessible calls to action. Do not mount the admin shell or imply live CMS, analytics, recruitment, or submission integrations.

### `public-catalog`

Public browse/filter/detail discovery with resilient image/content states, visible price/unit semantics, and host-owned availability. Desktop may keep filter/category rails; phone moves filters into a locked sheet and retains the same committed query state.

### `full-crud`

Search/filter/paging grid plus Add FAB/action, Edit/Delete row intents, confirmation, and modal editor. Desktop uses the bounded table and compact form; responsive uses equivalent cards and a mobile editor. Save/Delete only complete after host confirmation and canonical reload/result.

### `simple-crud`

Small master-data CRUD with minimal fields and actions. Keep the same functional Add/Edit/Save/Cancel/Delete lifecycle as full CRUD but omit unnecessary filters, dashboards, and complexity.

### `static-master-list`

Mostly stable reference data shown as a responsive list/grid. Search and lightweight row actions share one state; mutations are included only when requested and host-backed.

### `bounded-grid`

High-density two-axis data exploration. Desktop owns one internally scrolling table with sticky/meaningful headers; tablet/phone use equivalent cards or a deliberately bounded surface. Sorting, filtering, paging, and selection stay synchronized.

### `grouped-grid`

Stable-key expandable groups with host-supplied rows and summaries. Preserve expansion across sort/filter changes, compact desktop rhythm, exact toggle/selection results, and equivalent grouped tablet/phone cards. The component never invents authoritative totals.

### `editable-grid`

Functional inline Add/Edit/Save/Cancel/Delete draft lifecycle with typed callbacks and responsive editor cards. Native editors use one focus border; numeric fields align/format by type. A rejected save preserves the draft and surfaces the host error.

### `advanced-editable-grid`

Spreadsheet-like editing with only working icon commands, keyboard/focus continuity, validation, and a real draft lifecycle. Omit Undo/Redo until connected to history; keep mobile interactions deliberate rather than squeezing the desktop command surface.

### `metadata-crud`

Model-derived list/grid/form through `FlatModelCrud<TItem>` and `FlatModelForm<TItem>`. DataAnnotations provide ordinary defaults; typed field definitions own lookups/custom editors. Standard pages route Add through `FlatPage`; Cancel does not mutate, and successful host results drive refresh.

### `form-designer`

Visual metadata layout editing with stable keys, drag/drop plus accessible move actions, visibility/span controls, bounded `0..48px` spacing, safe class tokens, and exact desktop/mobile preview. Return normalized layout state; never accept raw CSS, HTML, or script.

### `dynamic-navigation`

Recursive navigation loading from stable menu records with validation for duplicate/missing IDs, parents, and cycles. Search remains recursive, active ancestors expand, and all navigation layouts consume one tree. Menu visibility never replaces route authorization.

### `operational-workspace`

Task/transaction workspace in natural content flow with compact summaries, explicit lifecycle/actions, and 12px desktop/10px mobile internal rhythm. Preserve review, confirmation, failure, concurrency, and recovery boundaries while keeping accounting/workflow/inventory mutations host-owned.

### `kanban-pipeline`

Stage-based work with controlled item selection/move intents, counts, loading/empty states, and horizontal containment on desktop. Phone prioritizes one stage/list context with accessible move alternatives; ordering, workflow rules, and persistence remain host-owned.

### `calendar-scheduler`

Host-owned date/items with exact select/create/move/view intents. Desktop uses the bounded calendar/time grid; `<=900px` uses grouped agendas and the shared options sheet. Recurrence, timezone, conflicts, permissions, reminders, and persistence stay outside the UI.

### `chat-ai-email`

Bounded desktop list/thread or history/thread workspace and separate mobile list/thread states. Preserve send/compose single-flight, errors, typing/responding/Stop where applicable, attachment metadata, and back-to-list behavior without route drift. Transport, providers, storage, authorization, and AI inference remain host-owned.

### `monitoring`

Operational health/status presentation with freshness, severity plus text/icon cues, last known state, retry, and drill-down. Responsive cards preserve the same filters and facts. A UI sample never claims live health without current evidence.

### `operational-report`

Host-owned filters/query, explicit KPI, grouped rows, subtotal/grand total, drill-down, refresh/print/export intents, and equivalent grouped mobile cards. Large generation, scheduling, delivery, storage, authorization, and export engines remain host-owned.

### `pivot-analysis`

Typed row/column/value selectors, explicit aggregate/totals, internally scrolling desktop matrix, and exact-cell drill-down. At `<=900px`, analysis controls move to a transactional bottom sheet and results become equivalent cards. Supplied items are the aggregation boundary.

### `pdf-document`

Bounded PDF preview with search, thumbnails, zoom, navigation, and print. At `<=900px`, secondary actions move into the header menu while page navigation and Print stay reachable in the bottom bar. Secure access, generation, storage, and native print/share/open remain host-owned.

### `product-detail`

Media-first detail composition with clear identity, variants/options, availability, price/unit, primary action, and resilient image/empty/error states. Phone orders decision-critical content before secondary details.

### `product-editor`

Large product/content editor with compact multi-section desktop layout, clear Save/Cancel, validation, media state, and dirty guard. Phone uses one-column/fullscreen editing; catalog rules, storage, publishing, and persistence remain host-owned.

### `product-management`

Filter-heavy administration workspace with bounded results, inventory/status facts, bulk/row intents only when host-backed, and shared query state. Desktop may use a filter rail; responsive uses a committed filter sheet and cards/list.

### `card-grid`

Responsive entity cards with stable identity, aligned metadata/actions, and container-owned gaps. Use desktop multi-column, tablet two-column, and phone one-column composition; do not add card margins or duplicate inner padding.

### `timeline`

Chronological activity/audit presentation with timestamp, actor/source, state, and accessible non-color cues. Mobile keeps a continuous readable sequence; event truth, retention, authorization, and audit storage remain host-owned.

### `tree-grid`

Hierarchical records with stable keys/parents, expansion, exact parent-change intents, cycle rejection, Web drag/drop, and touch-accessible move actions. Desktop uses columns; `<=900px` uses an Explorer-style continuous list with bounded indentation and connectors.

### `hierarchy-designer`

Compact outline designer with stable key/parent/order, exact before/inside/after moves, accessible reorder/promote/child actions, cycle rejection, and deterministic `schemaVersion: 1` JSON. Editing authority, migration, concurrency, persistence, and audit are host-owned.

### `vector-map`

Bounded theme-aware SVG regions/routes/markers with keyboard selection, viewport state, responsive containment, and reduced motion. It is a schematic renderer; GPS, geocoding, tiles, routing, history, geofencing, and persistence remain host-owned.

### `spatial-workspace`

Synchronized work list and vector map with controlled selection, layers, viewport, and route playback state across resize. Phone stacks list/map without document overflow. Playback is an intent; telemetry, routing, alerts, geofence decisions, and persistence stay host-owned.

### `erp-overview`

Role-oriented ERP summary with decision KPIs, exceptions, module entry points, period/unit/freshness, and drill-down. Avoid decorative metrics and never infer accounting or inventory truth.

### `erp-module`

ERP module overview or operational grid using compact data density, typed filters/actions, lifecycle/status cues, and responsive cards. Posting, fiscal, inventory, HR, manufacturing, authorization, and persistence rules remain host-owned.

### `erp-toolkit`

Reusable transaction, entity lookup, composite money/quantity/UOM, journal, reconciliation, planning, lifecycle, and operation-center patterns. Return exact typed intents; all fiscal, posting, conversion, allocation, matching, capacity, audit, and persistence authority remains in the host.

### `enterprise-toolkit`

Showroom for import, master-detail, audit, schema form, workflow, bulk action, scheduler, dashboard composer, notification center, offline sync, documents, and print. Demonstrate exact states/callbacks without implying backend engines or durable storage.

### `experience-toolkit`

Showroom for accessibility, command palette, conditional/wizard forms, collaboration, conflicts, unsaved changes, permissions, feature flags, operation failures, session timeout, and workspace state. Preserve visible focus and exact host intent; presentation never becomes authority.

### `business-toolkit`

Domain-neutral traceability, BOM/routing, rule, approval, attachment, recurrence, query, and comparison controls. Use typed state/callbacks and compact business typography; business execution, storage, scheduling, and validation remain host-owned.

### `erp-release-train`

Compiled ERP roadmap showroom that extends existing transaction/inventory/finance/workflow/integration/MRP/governance foundations. Follow the active milestone and gates; do not duplicate components or claim milestone completion from a visual sample.

### `system-state`

Minimal fatal, not-found, or recovery state with a plain explanation and one safe recovery action. Do not expose diagnostics or loop navigation; the fatal Blazor surface remains outside the circuit with Restart.

## PageId to behavior profile matrix

Every PageId in `page-registry.md` must occur exactly once here.

| PageId | Behavior profile | Canonical source |
|---|---|---|
| `opx.page.dashboard.overview` | `dashboard-overview` | `Home.razor` |
| `opx.page.reference.maui-host` | `native-host` | `MauiHost.razor` |
| `opx.page.reference.maui-performance` | `native-performance` | `MauiPerformance.razor` |
| `opx.page.reference.maui-compatibility` | `native-compatibility` | `Compatibility.razor` |
| `opx.page.reference.maui-native-adapters` | `native-adapters` | `NativeAdapters.razor` |
| `opx.page.reference.accordions` | `reference-showroom` | `Accordions.razor` |
| `opx.page.account.profile-edit` | `settings-form` | `EditAccount.razor` |
| `opx.page.assistant.ai-chat` | `chat-ai-email` | `AiChat.razor` |
| `opx.page.content.blog-index` | `public-content` | `Blog.razor` |
| `opx.page.schedule.calendar` | `calendar-scheduler` | `Calendar.razor` |
| `opx.page.schedule.scheduler` | `calendar-scheduler` | `Scheduler.razor` |
| `opx.page.commerce.catalog` | `public-catalog` | `Catalog.razor` |
| `opx.page.reference.charts` | `reference-showroom` | `Charts.razor` |
| `opx.page.collaboration.chat` | `chat-ai-email` | `Chat.razor` |
| `opx.page.reference.colors` | `reference-showroom` | `Colors.razor` |
| `opx.page.reference.components` | `reference-showroom` | `ComponentsGallery.razor` |
| `opx.page.reference.development-rules` | `reference-showroom` | `DevelopmentRules.razor` |
| `opx.page.operations.asset-crud` | `full-crud` | `Crud.razor` |
| `opx.page.operations.simple-crud` | `simple-crud` | `SimpleCrud.razor` |
| `opx.page.reference.large-data-grid` | `bounded-grid` | `DataGridLarge.razor` |
| `opx.page.reference.grouped-data-grid` | `grouped-grid` | `GroupedDataGrid.razor` |
| `opx.page.collaboration.email` | `chat-ai-email` | `Email.razor` |
| `opx.page.reference.enterprise-toolkit` | `enterprise-toolkit` | `EnterpriseToolkit.razor` |
| `opx.page.reference.experience-toolkit` | `experience-toolkit` | `ExperienceToolkit.razor` |
| `opx.page.reference.business-toolkit` | `business-toolkit` | `BusinessToolkit.razor` |
| `opx.page.erp.release-train` | `erp-release-train` | `ErpReleaseTrain.razor` |
| `opx.page.operations.advanced-editable-grid` | `advanced-editable-grid` | `AdvancedEditableGrid.razor` |
| `opx.page.erp.overview` | `erp-overview` | `ErpOverview.razor` |
| `opx.page.erp.toolkit` | `erp-toolkit` | `ErpToolkit.razor` |
| `opx.page.erp.finance.overview` | `erp-module` | `ErpFinance.razor` |
| `opx.page.erp.finance.general-ledger` | `erp-module` | `ErpFinance.razor` |
| `opx.page.erp.finance.payables` | `erp-module` | `ErpFinance.razor` |
| `opx.page.erp.finance.receivables` | `erp-module` | `ErpFinance.razor` |
| `opx.page.erp.hr.overview` | `erp-module` | `ErpHr.razor` |
| `opx.page.erp.hr.attendance` | `erp-module` | `ErpHr.razor` |
| `opx.page.erp.hr.employees` | `erp-module` | `ErpHr.razor` |
| `opx.page.erp.inventory.overview` | `erp-module` | `ErpSupplyChain.razor` |
| `opx.page.erp.procurement.overview` | `erp-module` | `ErpSupplyChain.razor` |
| `opx.page.erp.production.overview` | `erp-module` | `ErpProduction.razor` |
| `opx.page.erp.production.quality` | `erp-module` | `ErpProduction.razor` |
| `opx.page.erp.production.work-orders` | `erp-module` | `ErpProduction.razor` |
| `opx.page.erp.sales.overview` | `erp-module` | `ErpSales.razor` |
| `opx.page.erp.sales.orders` | `erp-module` | `ErpSales.razor` |
| `opx.page.system.error` | `system-state` | `Error.razor` |
| `opx.page.reference.file-upload` | `reference-showroom` | `FileUpload.razor` |
| `opx.page.reference.grid-editor` | `editable-grid` | `GridEditor.razor` |
| `opx.page.reference.model-crud` | `metadata-crud` | `ModelCrud.razor` |
| `opx.page.reference.model-form-designer` | `form-designer` | `ModelFormDesigner.razor` |
| `opx.page.reference.dynamic-menu` | `dynamic-navigation` | `DynamicMenu.razor` |
| `opx.page.operations.workspace` | `operational-workspace` | `OperationsWorkspace.razor` |
| `opx.page.reference.grid-preferences` | `reference-showroom` | `GridPreferences.razor` |
| `opx.page.public.careers-landing` | `public-content` | `JobLanding.razor` |
| `opx.page.operations.jobs` | `operational-workspace` | `Jobs.razor` |
| `opx.page.operations.kanban` | `kanban-pipeline` | `Kanban.razor` |
| `opx.page.auth.login` | `auth-form` | `Login.razor` |
| `opx.page.monitoring.service` | `monitoring` | `Monitoring.razor` |
| `opx.page.monitoring.database` | `monitoring` | `MonitoringDatabase.razor` |
| `opx.page.system.not-found` | `system-state` | `NotFound.razor` |
| `opx.page.reporting.pivot` | `pivot-analysis` | `Pivot.razor` |
| `opx.page.commerce.product-detail` | `product-detail` | `ProductDetail.razor` |
| `opx.page.commerce.product-editor` | `product-editor` | `ProductEditor.razor` |
| `opx.page.commerce.product-management` | `product-management` | `ProductManagement.razor` |
| `opx.page.reference.profile-grid` | `card-grid` | `ProfileGrid.razor` |
| `opx.page.reporting.operational` | `operational-report` | `Reports.razor` |
| `opx.page.reporting.pdf-viewer` | `pdf-document` | `PdfViewer.razor` |
| `opx.page.auth.reset-password` | `auth-form` | `ResetPassword.razor` |
| `opx.page.sales.pipeline` | `kanban-pipeline` | `SalesPipeline.razor` |
| `opx.page.reference.static-data` | `static-master-list` | `StaticData.razor` |
| `opx.page.reference.timeline` | `timeline` | `Timeline.razor` |
| `opx.page.reference.tree-grid` | `tree-grid` | `TreeGrid.razor` |
| `opx.page.reference.hierarchy-designer` | `hierarchy-designer` | `HierarchyDesigner.razor` |
| `opx.page.reference.vector-map` | `vector-map` | `VectorMap.razor` |
| `opx.page.operations.spatial-workspace` | `spatial-workspace` | `SpatialOperations.razor` |
| `opx.page.auth.two-step-verification` | `auth-form` | `TwoStepVerification.razor` |
| `opx.page.public.website-home` | `public-content` | `WebsiteHome.razor` |
| `opx.page.reference.widgets` | `dashboard-overview` | `Widgets.razor` |

## Resolution sequence

1. Infer one `PageId` from the user's job, workflow, data, shell, and device context.
2. Apply its mapped behavior profile and shared rules.
3. Open the canonical source and every directly used shared component.
4. If the request says same/exact/canonical/source of truth, activate Exact Sample Mode and establish an unchanged audited baseline.
5. Adapt host-owned content and integration seams only; preserve the profile's interaction, state, responsive, accessibility, spacing, and ownership boundaries.
