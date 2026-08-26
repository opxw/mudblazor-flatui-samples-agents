# Canonical page registry

Copyright (c) 2026 opx. All rights reserved.

Use this registry before creating or changing a page. Resolve the user's wording to one canonical `PageId`, then read the listed source and its archetype dependencies from `sample-source-map.md`. A `PageId` is stable agent metadata; it is not the AppBar `PageTitle`, route, component class, permission, or business identifier.

Naming rules:

- Format IDs as `opx.page.<area>.<purpose>` in lowercase dot notation.
- Keep every ID and route unique. A Razor component with several routes receives one ID per route.
- Preserve an existing ID when display text or route wording changes; update its route/source mapping deliberately.
- Register a new page in this file in the same change that adds `@page`.
- Choose the nearest existing archetype from prompt cues; do not combine unrelated page geometries merely because several keywords match.

| PageId | Canonical page name | Route | Prompt cues | Shell / archetype | Source |
|---|---|---|---|---|---|
| `opx.page.dashboard.overview` | Dashboard Overview | `/` | dashboard, overview, KPI | Admin / dashboard widgets | `Home.razor` |
| `opx.page.reference.maui-host` | MAUI Hybrid Host | `/maui-host` | MAUI host, native adapters, device capabilities | Admin / native host reference | `MauiHost.razor` |
| `opx.page.reference.maui-performance` | MAUI Performance | `/maui-performance` | startup timing, route render, performance measurement | Admin / runtime diagnostics | `MauiPerformance.razor` |
| `opx.page.reference.maui-compatibility` | MAUI Compatibility | `/compatibility` | WebView compatibility, viewport, theme, lifecycle, status bar | Admin / native compatibility reference | `Compatibility.razor` |
| `opx.page.reference.maui-native-adapters` | MAUI Native Adapters | `/native-adapters` | secure storage, camera, file picker, share, notification | Admin / native capability reference | `NativeAdapters.razor` |
| `opx.page.reference.accordions` | Accordion Showcase | `/accordions` | accordion, FAQ, disclosure | Admin / component showroom | `Accordions.razor` |
| `opx.page.account.profile-edit` | Account Profile Editor | `/account/edit` | edit account, profile, permissions | Admin / settings form | `EditAccount.razor` |
| `opx.page.assistant.ai-chat` | AI Chat Workspace | `/ai-chat` | AI chat, assistant, streaming prompt | Admin / AI chat | `AiChat.razor` |
| `opx.page.content.blog-index` | Blog Index | `/blog` | blog, article cards, content | Website / public content | `Blog.razor` |
| `opx.page.schedule.calendar` | Calendar Workspace | `/calendar` | calendar, year, month, week, agenda | Admin / calendar | `Calendar.razor` |
| `opx.page.schedule.scheduler` | Work Week Scheduler | `/scheduler` | scheduler, appointments, work week, timeline, resources | Admin / scheduler time grid | `Scheduler.razor` |
| `opx.page.commerce.catalog` | Product Catalog | `/catalog` | ecommerce catalog, storefront, price filter | Website / public catalog | `Catalog.razor` |
| `opx.page.reference.charts` | Chart Showcase | `/charts` | charts, MudBlazor charts, sample code | Admin / component showroom | `Charts.razor` |
| `opx.page.collaboration.chat` | Realtime Chat Workspace | `/chat` | chat, conversation, typing | Admin / chat | `Chat.razor` |
| `opx.page.reference.colors` | Color Token Reference | `/colors` | palette, semantic colors, theme tokens | Admin / component showroom | `Colors.razor` |
| `opx.page.reference.components` | Component Gallery | `/components` | components, controls, message box, modal | Admin / component showroom | `ComponentsGallery.razor` |
| `opx.page.reference.development-rules` | Development Rules | `/development-rules` | rules, skill, source of truth, page contract | Admin / developer reference | `DevelopmentRules.razor` |
| `opx.page.operations.asset-crud` | Asset Management CRUD | `/crud` | CRUD, asset grid, filter, paging | Admin / full CRUD | `Crud.razor` |
| `opx.page.operations.simple-crud` | Simple CRUD | `/crud-simple` | simple CRUD, add form | Admin / compact CRUD | `SimpleCrud.razor` |
| `opx.page.reference.large-data-grid` | Large Data Grid | `/data-grid-large` | many rows, vertical horizontal scroll | Admin / bounded grid | `DataGridLarge.razor` |
| `opx.page.reference.grouped-data-grid` | Grouped Data Grid | `/grouped-data-grid` | grouped grid, expandable rows, count sum average | Admin / bounded grouped grid | `GroupedDataGrid.razor` |
| `opx.page.collaboration.email` | Email Workspace | `/email` | email, inbox, compose | Admin / email | `Email.razor` |
| `opx.page.reference.enterprise-toolkit` | Enterprise Toolkit | `/enterprise-toolkit` | enterprise components, workflow, audit, import | Admin / enterprise showroom | `EnterpriseToolkit.razor` |
| `opx.page.reference.experience-toolkit` | Experience Toolkit | `/experience-toolkit` | accessibility, command palette, schema form, collaboration, conflict | Admin / application experience showroom | `ExperienceToolkit.razor` |
| `opx.page.reference.business-toolkit` | Business Toolkit | `/business-toolkit` | traceability, BOM, routing, rules, approval, attachments, recurrence, query, compare | Admin / business component showroom | `BusinessToolkit.razor` |
| `opx.page.erp.release-train` | ERP Release Train | `/erp-release-train` | transaction engine, inventory allocation, finance, workflow, integration, MRP, governance | Admin / ERP release showroom | `ErpReleaseTrain.razor` |
| `opx.page.operations.advanced-editable-grid` | Advanced Editable Grid | `/advanced-editable-grid` | advanced grid, inline add/edit/save/cancel, spreadsheet commands | Admin / editable grid showroom | `AdvancedEditableGrid.razor` |
| `opx.page.erp.overview` | ERP Overview | `/erp` | ERP dashboard, modules | Admin / ERP dashboard | `ErpOverview.razor` |
| `opx.page.erp.toolkit` | ERP Application Toolkit | `/erp-toolkit` | ERP transaction workspace, lookup, journal, reconciliation, planning | Admin / ERP component showroom | `ErpToolkit.razor` |
| `opx.page.erp.finance.overview` | ERP Finance Overview | `/erp/finance` | finance overview | Admin / ERP module | `ErpFinance.razor` |
| `opx.page.erp.finance.general-ledger` | ERP General Ledger | `/erp/finance/general-ledger` | general ledger, journal | Admin / ERP finance grid | `ErpFinance.razor` |
| `opx.page.erp.finance.payables` | ERP Payables | `/erp/finance/payables` | AP, payable | Admin / ERP finance grid | `ErpFinance.razor` |
| `opx.page.erp.finance.receivables` | ERP Receivables | `/erp/finance/receivables` | AR, receivable | Admin / ERP finance grid | `ErpFinance.razor` |
| `opx.page.erp.hr.overview` | ERP Human Resources Overview | `/erp/hr` | HR overview, workforce | Admin / ERP module | `ErpHr.razor` |
| `opx.page.erp.hr.attendance` | ERP Attendance | `/erp/hr/attendance` | attendance, timesheet | Admin / ERP HR grid | `ErpHr.razor` |
| `opx.page.erp.hr.employees` | ERP Employees | `/erp/hr/employees` | employee master, HR grid | Admin / ERP HR grid | `ErpHr.razor` |
| `opx.page.erp.inventory.overview` | ERP Inventory Overview | `/erp/inventory` | inventory, stock | Admin / ERP supply chain | `ErpSupplyChain.razor` |
| `opx.page.erp.procurement.overview` | ERP Procurement Overview | `/erp/procurement` | procurement, purchase | Admin / ERP supply chain | `ErpSupplyChain.razor` |
| `opx.page.erp.production.overview` | ERP Production Overview | `/erp/production` | production dashboard | Admin / ERP production | `ErpProduction.razor` |
| `opx.page.erp.production.quality` | ERP Production Quality | `/erp/production/quality` | production quality, inspection | Admin / ERP production grid | `ErpProduction.razor` |
| `opx.page.erp.production.work-orders` | ERP Work Orders | `/erp/production/work-orders` | work order, manufacturing jobs | Admin / ERP production grid | `ErpProduction.razor` |
| `opx.page.erp.sales.overview` | ERP Sales Overview | `/erp/sales` | sales overview | Admin / ERP sales | `ErpSales.razor` |
| `opx.page.erp.sales.orders` | ERP Sales Orders | `/erp/sales/orders` | sales order, order grid | Admin / ERP sales grid | `ErpSales.razor` |
| `opx.page.system.error` | Application Error | `/Error` | unhandled error, error boundary | System / error state | `Error.razor` |
| `opx.page.reference.file-upload` | File Upload Showcase | `/file-upload` | upload, image upload, multiple preview, autoscale, drag drop, progress, retry | Admin / upload showroom | `FileUpload.razor` |
| `opx.page.reference.grid-editor` | Editable Grid Showcase | `/grid-editor` | add row, inline edit, row result | Admin / editable grid | `GridEditor.razor` |
| `opx.page.reference.model-crud` | Model CRUD Showcase | `/model-crud` | automatic list grid, generated form, DataAnnotations CRUD | Admin / metadata-driven CRUD | `ModelCrud.razor` |
| `opx.page.reference.model-form-designer` | Model Form Designer | `/model-form-designer` | visual WYSIWYG form, drag drop fields, padding, margin, CSS class, live preview | Admin / metadata-driven form designer | `ModelFormDesigner.razor` |
| `opx.page.reference.dynamic-menu` | Dynamic Menu Showcase | `/dynamic-menu` | autoload menu, MenuText, Id, ParentId, Url, Icon | Admin / recursive navigation | `DynamicMenu.razor` |
| `opx.page.operations.workspace` | Operations Workspace | `/operations-workspace` | service desk, approval, procurement, stock transfer, timesheet, POS | Admin / operational composition | `OperationsWorkspace.razor` |
| `opx.page.reference.grid-preferences` | Grid Preferences | `/grid-preferences` | column visibility, order, width, saved view | Admin / grid settings | `GridPreferences.razor` |
| `opx.page.public.careers-landing` | Careers Landing | `/job-landing` | job landing, careers, recruitment portal | Website / public landing | `JobLanding.razor` |
| `opx.page.operations.jobs` | Job Management | `/jobs` | job list, create job, vacancies admin | Admin / jobs workspace | `Jobs.razor` |
| `opx.page.operations.kanban` | Kanban Board | `/kanban` | kanban, task board | Admin / kanban | `Kanban.razor` |
| `opx.page.auth.login` | Login | `/login` | login, sign in | Auth / login | `Login.razor` |
| `opx.page.monitoring.service` | Service Monitoring | `/monitoring` | service monitor, health | Admin / monitoring | `Monitoring.razor` |
| `opx.page.monitoring.database` | Database Monitoring | `/monitoring-database` | database monitor, connection health | Admin / monitoring grid | `MonitoringDatabase.razor` |
| `opx.page.system.not-found` | Not Found | `/not-found` | 404, unknown route | System / not found | `NotFound.razor` |
| `opx.page.reporting.pivot` | Pivot Analysis | `/pivot` | pivot, aggregation, measures | Admin / reporting pivot | `Pivot.razor` |
| `opx.page.commerce.product-detail` | Product Detail | `/product-detail` | product detail, gallery, variants | Admin / product detail | `ProductDetail.razor` |
| `opx.page.commerce.product-editor` | Product Editor | `/product-editor` | create product, edit product, rich editor | Admin / editor workspace | `ProductEditor.razor` |
| `opx.page.commerce.product-management` | Product Management | `/product-management` | product admin, filter rail, inventory list | Admin / filter workspace | `ProductManagement.razor` |
| `opx.page.reference.profile-grid` | Profile Card Grid | `/profile-grid` | profile cards, people grid | Admin / card grid | `ProfileGrid.razor` |
| `opx.page.reporting.operational` | Operational Reports | `/reports` | report, export, filter | Admin / report viewer | `Reports.razor` |
| `opx.page.reporting.pdf-viewer` | PDF Viewer | `/pdf-viewer` | PDF preview, PDF.js, print, share, thumbnails, search | Admin / responsive document viewer | `PdfViewer.razor` |
| `opx.page.auth.reset-password` | Reset Password | `/reset-password` | forgot password, reset password | Auth / recovery | `ResetPassword.razor` |
| `opx.page.sales.pipeline` | Sales Pipeline | `/sales-pipeline` | CRM pipeline, deal stages | Admin / pipeline kanban | `SalesPipeline.razor` |
| `opx.page.reference.static-data` | Static Data Management | `/static-data` | master data, static CRUD | Admin / static responsive list | `StaticData.razor` |
| `opx.page.reference.timeline` | Timeline Showcase | `/timeline` | timeline, audit activity | Admin / timeline | `Timeline.razor` |
| `opx.page.reference.tree-grid` | Tree Grid Showcase | `/tree-grid` | hierarchy, parent key, drag drop tree | Admin / tree grid | `TreeGrid.razor` |
| `opx.page.reference.hierarchy-designer` | Hierarchy Designer | `/hierarchy-designer` | compact outline, hierarchy designer, drag drop reorder, export JSON | Admin / compact hierarchy designer | `HierarchyDesigner.razor` |
| `opx.page.reference.vector-map` | Vector Map Showcase | `/vector-map` | vector map, floor plan, denah, location tracking, route | Admin / component showroom | `VectorMap.razor` |
| `opx.page.operations.spatial-workspace` | Spatial Operations | `/spatial-operations` | layered floor, geofence, work list map, route playback, fleet tracking | Admin / spatial operations workspace | `SpatialOperations.razor` |
| `opx.page.auth.two-step-verification` | Two-Step Verification | `/two-step-verification` | OTP, 2FA, verification code | Auth / verification | `TwoStepVerification.razor` |
| `opx.page.public.website-home` | Website Home | `/website` | frontend, website home, landing page | Website / public home | `WebsiteHome.razor` |
| `opx.page.reference.widgets` | Widget Showcase | `/widgets` | widgets, KPI cards, widget padding, margin, spacing | Admin / widget showroom | `Widgets.razor` |

## Prompt resolution contract

1. Match explicit route or canonical name first.
2. The user does not need to know or mention a `PageId`; infer it from the requested job, business workflow, data shape, shell, and device context, then state the selected ID in the working update.
3. Otherwise analyze the user or role, primary job, information hierarchy, data/action risk, permissions, device/input context, required states, accessibility, localization/RTL, and responsive needs; then match prompt cues and business intent.
4. If one archetype clearly fits, select the simplest composition that completes the job and state the chosen `PageId` plus the relevant assumptions in the working update.
5. If two choices would materially change shell or interaction—for example public Careers Landing versus admin Job Management—ask or infer only from explicit context.
6. For a new concept, create a new unique `PageId`, choose the nearest archetype, and update this registry, navigation, title mapping, docs/rules when relevant, and audit coverage in the same change.
7. For a layout request, state the layout blueprint defined in [layout-decision.md](layout-decision.md) before implementation; infer standard OPX visual structure instead of returning the design decision to the user.
