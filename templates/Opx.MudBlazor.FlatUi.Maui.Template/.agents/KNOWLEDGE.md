# Repository knowledge

Copyright (c) 2026 opx. All rights reserved.

This repository-local ledger preserves accepted OPX Flat UI knowledge for agents and generated consumers. It travels with the repository. User-folder memory and ChatGPT handoff files are supplementary recall only; they never replace this file, current source, compiled samples, package inspection, Git history, or live/device evidence.

## Maintenance contract

- Read this file after root `RULES.md` and `.agents/RULES.md`, before selecting a PageId or editing UI.
- After an accepted material change to package version, contract, PageId, behavior, showcase, responsive design, diagnosis, or host boundary, update the canonical source/rules/reference first and then refresh the relevant entry here.
- Record durable decisions and verified current state, not conversations, source dumps, secrets, credentials, personal data, assumptions, temporary experiments, or consumer-specific workarounds.
- Reverify drift-prone facts such as NuGet versions, routes, package assets, sample composition, and native runtime behavior. Mark unverified boundaries explicitly.
- If this ledger conflicts with compiled source or normative rules, stop and reconcile the conflict in the same change; do not silently choose or let this ledger override source.

## Current canonical snapshot

- Consumer UI authority: this repository and shared `samples/Opx.MudBlazor.FlatUi.Showcase` composition.
- Reusable UI dependency: public NuGet `Opx.MudBlazor.FlatUi` `2.1.18`; package source checkout is inspection authority only, never a consumer `ProjectReference`.
- MudBlazor baseline: `9.9.0`; consumer contract schema: `3.1`; default theme: Light.
- Default color palette is the built-in package ID `fluent-blue`; Restore returns to it, while an explicitly saved user palette remains authoritative until restored.
- Web and MAUI load the shared Showcase routes/navigation; native-only diagnostics remain host-owned.
- The canonical registry has 76 unique PageIds and routes. Every PageId maps exactly once to one of 45 declared profiles in `showcase-behavior-registry.md`.
- Prompt resolution is requirements/job -> PageId -> behavior profile -> mapped sample/archetype -> implementation. The user does not need to supply PageId, form layout, CRUD mechanics, grid behavior, spacing, or standard responsive transformation.
- `.agents/PROMPTING.md` is the canonical shortcut contract: a short business phrase is enough, routine UI decisions remain agent-owned, and at most one question is asked only for a material workflow/authority/native distinction.
- ERP, HR, and enterprise prompts use `enterprise-domain-layout-decision.md` to choose a dominant operating mode before components. The agent decides the canonical layout from role, job, data sensitivity, lifecycle, transaction consequence, action risk, and viewport. Distinct HR jobs are not collapsed into generic CRUD, and authoritative policy, formulas, approvals, payroll/accounting/inventory effects, permissions, persistence, and audit remain host-owned.
- Package-first reuse is mandatory: inspect the supported NuGet public API and mapped canonical sample, use an existing capability through its public seam, and never duplicate package behavior or assets in a consumer. A verified missing domain-neutral capability is proposed as a package addition; a domain, authorization, persistence, integration, or native need is proposed as a host-owned seam. Package changes and publication require explicit approval.
- When analysis finds a material improvement, report it as `Saran UI/UX` with need/risk, one concrete recommendation, user/business impact, priority (`Wajib`, `Disarankan`, or `Opsional`), and scope/approval boundary. Do not add filler suggestions or silently expand scope.

## Imported 2.1.16 package capabilities

- Settings/About modals now own complete resolved semantic surface tokens as portal-like roots. Light mode keeps neutral/white panel, header, body, and footer surfaces rather than inheriting a palette accent-subtle color.
- MudBlazor date/time picker portal paper remains square and the selected calendar day keeps the resolved primary-contrast foreground on its primary background across Light, Dark/Night, and Auto.

- `FlatEmptyState` owns full-region centering: it spans grid columns `1 / -1` when mounted directly in a multi-column CSS grid and remains full-width centered in block, flex, table, and responsive-card contexts. Consumers must not compensate with local offsets.
- Public careers remain PageId `opx.page.public.careers-landing` at `/job-landing` under `WebsiteLayout`. `FlatJobEmailApplicationDialog<TJob>` validates candidate identity/email and consent, then returns `FlatJobEmailApplication<TJob>` with the exact selected job; email delivery, applicant/resume storage, consent lifecycle, retention, workflow, authorization, and audit remain host-owned.
- Vacancy administration remains PageId `opx.page.operations.jobs` at `/jobs`. `FlatVacancyActions<TJob>` supplies typed edit, publish/close, and delete intents while `FlatFormModal` owns create/edit composition; persistence, authorization, concurrency, audit, public indexing, and delete policy remain host-owned.
- `FlatDataGrid<TItem>` can generate a native `.xlsx` from effective visible columns and localized formatted values when `ExportVisible=true` and no `OnExport` override is supplied. `Items` is the displayed-view default; `ExcelExportItems` must already be materialized in the host-owned filtered/sorted order. Server, virtualized, unbounded, permission-sensitive, background, or native-file exports stay on the compatible `OnExport`/result seams.

## Durable UI and behavior decisions

- Exact Sample Mode applies to requests for the same, exact, canonical, sample-matching, or source-of-truth UI. Preserve geometry, hierarchy, responsive transformations, typography, spacing, states, actions, and scroll ownership; adapt host-owned data/integration seams only.
- Source-to-destination parity is an acceptance gate, not an aspiration. Every destination pins the public NuGet/assets, starts from or compares against a clean generated template, passes `-ExactSample` before integration, preserves canonical structure/classes/responsive/spacing/state behavior, then passes the standard audit and same-state desktop/tablet/phone visual/computed comparison after host integration. Every intentional deviation is recorded and approved; accidental drift is `bug integrasi aplikasi`.
- Destination CSS has zero package-override authority. Outside the untouched canonical sample composition file, local stylesheets cannot target `.flat-*`/`.mud-*`, declare `--opx-*`, copy package rules, or use specificity/`!important` as a workaround. App/domain CSS uses newly owned classes and may consume resolved tokens without redefining them. Reusable visual changes belong in the source/package public contract.
- Responsive CRUD/list cards use package `FlatMobileGrid`, `article.mobile-card`, and the mapped facts/body/footer classes. A bare manual `div.mobile-grid-list`, a classless card article, or local card geometry CSS is forbidden when that package pattern exists; losing the required class is a consumer integration defect because package selectors own padding, hierarchy, alignment, scrolling, and touch behavior.
- Sidebar brand hierarchy is content-aware: when title/eyebrow is empty and subtitle is present, the subtitle becomes the primary line; populated two-line branding remains unchanged.
- Responsive composition uses desktop/table behavior above `900px`, responsive/two-column behavior from `601-900px`, and phone/one-column refinement at `<=600px`, subject to documented component-specific boundaries.
- Content-panel bodies have a positive logical horizontal inset: default `padding-inline:14px` desktop and `12px` at `<=900px`, unless the mapped compiled sample defines another positive value. Edge-to-edge table/media shells may use outer zero padding only when immediate readable children own a positive inset.
- Spacing ownership is singular: parent layout owns gaps, panel body owns inner padding, and widgets do not add compensating outer margins or duplicate padding at the same boundary.
- The initial spacing preset is the package density value `Default`, configured as `OpxFlatUi:Display:DefaultDensity="Default"`. There is no separate `DefaultSpacing` key. Compact/Comfortable remain persisted Settings choices; Restore returns to Default without changing canonical gutters, panel insets, safe areas, or component-specific spacing.
- Ordinary buttons default to a `7px` corner radius through package-owned `OpxFlatUi:Display:DefaultRoundedSizePx`. The same bounded `0-12` token controls bottom-sheet top corners; cards, panels, inputs, dialogs, menus, grids, toolbars, and workspaces remain square. Do not create consumer/page-local radius overrides. Package 2.1.16 excludes `.flat-system-loading-spinner` from broad zero-radius resets, so startup/reconnect spinners remain circular inside shells, dialogs, and portals without consumer CSS.
- CRUD uses the visible verb `Edit`, not `Ubah`. Forms preserve validation, dirty-state guard, functional Add/Edit/Save/Cancel/Delete, desktop compact multi-column layout, and mobile one-column/fullscreen editing where appropriate.
- Back behavior is layered and Blazor-first: an open CRUD/form modal consumes the first Back and keeps the route/application alive; the next Back navigates through prior Blazor WebView history. MAUI Android delegates to native Back/app exit only when no package modal/overlay and no prior WebView history entry remain. Package 2.1.16 owns modal interception; WebView-history fallback is host-owned.
- Grids use compact search, hidden metadata icons, type-aware alignment/formatting, one bounded desktop scroll owner, and equivalent responsive cards/lists sharing query, filter, sort, paging, selection, permission, loading, validation, and mutation state.
- On responsive/mobile search or filter toolbars with at least two secondary actions, the action row defaults to collapsed/hidden because package `FlatPage.MobileToolbarActionsExpandedByDefault` defaults to `false`. The full-width text field and accessible Apps toggle remain visible; desktop toolbar actions remain visible. Initial expansion is opt-in.
- Initialized admin consumers include Settings, default searchable navigation, Light/Dark/Auto preferences, and right-aligned Logout. Root session validation completes before `Router` is created.
- Bottom navigation requests default child/overflow navigation to the package `Sheet` presentation through `OpxFlatUi:Display:DefaultBottomNavigationChildPresentation="Sheet"`. `MainView` is opt-in only; both presentations reuse the same recursive navigation state and neither authorizes routes.
- Default typography means both font ownership and font face stay with the device/browser: `UseAppFontSize=false`, ordinary UI inherits the system UI font stack and `1rem` plus accessibility scaling, and consumers do not bundle, download, or force an app/custom font. Manual is an explicit size override with a `16px` baseline and does not replace the system font family. Package-owned numeric, code, and icon tokens are the only intentional face exceptions; text buttons inherit Device typography and grow or wrap without clipping.
- MAUI keeps that Device typography/button scaling, Toolkit status bar synchronized with AppBar/theme, no native bounce, selectable text only in text-bearing editors, and static-to-interactive `Memuat` loading. Native claims require emulator/device evidence.

## Defect classification vocabulary

- Write the exact phrase **"bug package"** only when an unchanged canonical sample on the same supported NuGet version reproduces a package-owned component/API/CSS/JavaScript defect.
- Write **"bug integrasi aplikasi"** for consumer markup, local CSS, configuration, host service, stale asset, or integration defects.
- Write **"belum terklasifikasi"** when ownership is not proven and state the missing reproduction/comparison. Never infer ownership merely from the visual location of a symptom.

## Canonical detail indexes

- Normative contract: `RULES.md`
- Repository workflow: `.agents/RULES.md`
- Development skill: `.agents/skills/opx-flat-ui-development/SKILL.md`
- Page identities: `.agents/skills/opx-flat-ui-development/references/page-registry.md`
- Interaction/state profiles: `.agents/skills/opx-flat-ui-development/references/showcase-behavior-registry.md`
- Archetype/source ownership: `.agents/skills/opx-flat-ui-development/references/sample-source-map.md`
- Exact reproduction: `.agents/skills/opx-flat-ui-development/references/exact-sample-mode.md`
- Layout decisions: `.agents/skills/opx-flat-ui-development/references/layout-decision.md`
- ERP/HR/enterprise layout decisions: `.agents/skills/opx-flat-ui-development/references/enterprise-domain-layout-decision.md`
- MAUI deployment: `.agents/skills/opx-flat-ui-development/references/maui-mobile-deployment.md`
- Simple prompts and safe defaults: `.agents/PROMPTING.md`
# 2026-08-30 - FlatFileUpload camera/gallery adapter

- Consumer composition may opt into `FlatFileUpload` camera/gallery buttons with a host-provided `IFlatFilePickerAdapter`; selected media must reuse the standard validation/upload lifecycle and browse fallback.
- Web capture requires secure-context media APIs and complete track cleanup; MAUI native picker behavior remains device-tested host capability.

# 2026-08-30 - Composable display settings

- `FlatDisplaySettingsConfiguration` selects and orders sections, locks host-controlled values, localizes component-owned copy, and permits explicit per-section templates without duplicating package markup.
- Omitted configuration preserves the complete compatibility surface. `IndonesianEssentials` renders only Tema, Palet warna, Ukuran font, and Target sentuh in that order.
- The host owns the modal, draft/live preview, Save/Cancel/Restore, persistence, authorization, and policy; locked presentation is not server-side authorization.

# 2026-08-31 - Shared navigation route resolver

- Canonical PageId: `opx.page.reference.dynamic-menu`.
- `IFlatNavigationRouteResolver` applies consumer-owned label mappings before validating fallback URLs, so Web and MAUI consume identical resolved menu records without package domain coupling.
- Labels use NFKC, Unicode format/zero-width removal, alphanumeric filtering, and invariant uppercase. Fallbacks accept local routes and absolute HTTP(S); empty, fragment-only, protocol-relative, and unsafe-scheme values fail closed.
- Menu visibility is not authorization. Mapping semantics and route authorization remain consumer-owned.

# 2026-09-01 - Android native refresh indicator inset

- Android edge-to-edge MAUI positions the native `SwipeRefreshLayout` indicator from measured status-bar `WindowInsets` plus the canonical `60dp` AppBar and an `8dp` resting gap.
- Reapply the offset after load, resize/orientation, and status-bar changes. Keep the persistent `BlazorWebView` stationary; do not compensate with page padding or translation.
- This is host-owned native integration. Browser previews do not prove its runtime geometry.

# 2026-09-02 - NuGet 2.1.16 Login and grouped-grid contracts

- Public consumer baseline is `Opx.MudBlazor.FlatUi` `2.1.16`; reusable CSS must resolve from that NuGet package and match SHA-256 `9960B55C5DE921957960496B6342776267070FE404B47C74569C043347EFA57F`.
- `FlatApplicationOptions.LoginBrandPanelVisible` defaults to `true`. With `LoginLayout=Default`, `false` centers the unboxed Login form without rendering the brand panel; `Boxed` remains a separate bounded composition.
- `FlatGroupedDataGrid<TItem>.GroupHeaderAlignment` defaults to `Left` and accepts `Center` or `Right`; the package owns text and content-axis alignment for desktop and responsive headings.

# 2026-09-03 - NuGet 2.1.16 responsive card scroll chaining

- Public/signed NuGet 2.1.16 has the same payload as the supplied local artifact; the official archive additionally contains `.signature.p7s`.
- Package CSS SHA-256 is `9960B55C5DE921957960496B6342776267070FE404B47C74569C043347EFA57F`.
- At `<=900px`, `.mobile-grid-list` contains horizontal overscroll but lets vertical gestures chain to the page when the list is not overflowed or reaches its boundary. Consumer CSS must not reintroduce `overscroll-behavior:contain`.

# 2026-09-03 - Binary computer connectivity status

- `SampleConnectionStatus` is the canonical sample composition for a binary computer-connection Status column: green `Link` means Connected and gray `LinkOff` means Disconnected.
- Desktop cells and responsive card headers use the same renderer. Tooltip, native title, and accessible label preserve the meaning without depending on color; non-binary states such as Pending retain visible `FlatStatusChip` text.
- PageId `opx.page.monitoring.computer` maps to `/monitoring/computers` and `MonitoringComputers.razor`. Connectivity and Master Asset membership are distinct states.
- A computer already linked to Master Asset uses the Success-green outlined `Inventory` icon with its built-in check. Clicking it opens package `FlatMessageBoxService.QuestionAsync` with title exactly `Registrasi Ulang ?`; only confirmation emits the host-owned re-registration intent. Unregistered uses neutral `Inventory2`.

# 2026-09-03 - NuGet 2.1.16 AppBar search visibility

- Public package 2.1.16 adds `FlatAppShell.SearchVisible` and `FlatAppBar.SearchVisible`; both default to `true` for compatibility.
- Bind the host default from `OpxFlatUi:Display:AppBarSearchVisible`. When false, the package omits search input, result popup, reserved width, and keyboard focus target rather than visually hiding them.
- An empty search catalog is data state, not a visibility setting. Consumer CSS must not conceal package-owned search markup.

# 2026-09-05 - NuGet 2.1.16 compact profile list

- Public/signed NuGet 2.1.16 is the consumer baseline. Package CSS SHA-256 is `9960B55C5DE921957960496B6342776267070FE404B47C74569C043347EFA57F`; the official archive matches the supplied local functional payload and adds NuGet signature metadata.
- `FlatProfileListItem` is the package-owned compact directory row for `FlatCardGrid` List mode. It presents the circular `FlatProfileAvatar`, identifier, subtitle, metadata, host-defined badges, chevron, disabled state, accessible label, and host navigation callback without page-local row CSS.
- `/profile-grid` defaults to List mode and demonstrates `FlatProfileListItem`; Grid mode continues to use `FlatProfileCard`. Rows, controls, and badges remain square while only the semantic avatar remains circular.
- `FlatCardGrid.SearchTrailingActions` owns compact search-related actions such as a filter-sheet toggle inside the search field; unrelated commands remain in `ToolbarActions`, whose container is omitted when empty.

# 2026-09-06 - NuGet 2.1.16 panel and Settings spacing

- Public/signed NuGet `2.1.16` is the active consumer baseline. Official nupkg SHA-256 is `F95A9DFF825A676A4297187662B0BD1548473796B54223CA7F5B0E90DFF70638`; package CSS SHA-256 is `9960B55C5DE921957960496B6342776267070FE404B47C74569C043347EFA57F`.
- `FlatUiDisplayOptions.PanelHeaderMinHeight` defaults to `48` and `PanelHeaderPaddingY` defaults to `10`; `FlatMudProviders` publishes their bounded package CSS tokens. Headers retain intrinsic growth, existing horizontal gutters, and package ownership.
- Settings Theme, Density, and Input Style headings/helper text align with their controls at `16px` horizontal inset and `14px` at `<=520px`. The inset is scoped to previously unpadded sections and must not be duplicated in consumer CSS.
- Package `2.1.15` introduced the Settings alignment and an `8px` logical gap between AppBar menu icons and text; `2.1.16` adds configurable global panel-header minimum height/padding. Consumers upgrade directly from the previous public baseline; version `2.1.14` is not published on NuGet.org.

# 2026-09-06 - NuGet 2.1.17 provider precedence patch

- Public/signed NuGet `2.1.17` is the active consumer baseline. Official nupkg SHA-256 is `E142F896F33C6FF88D01163625E53DEE268CCFCB514451A6612E5231B6D41A12`; package CSS SHA-256 remains `9960B55C5DE921957960496B6342776267070FE404B47C74569C043347EFA57F`.
- The official DLL, CSS, readable/minified JavaScript, and build props match the source artifact. Compared with public 2.1.16, static assets, dependencies, and public component API are unchanged; the DLL contains the provider-resolution fix.
- This fixes a **bug package** in `FlatMudProviders`: resolve a directly registered `FlatUiDisplayOptions` instance first, then `IOptions<FlatUiDisplayOptions>`, then defaults. An implicit unconfigured wrapper created by `AddOptions()` must not mask the canonical singleton options used by Web/MAUI hosts.

# 2026-09-06 - NuGet 2.1.18 FlatCardGrid search-action patch

- Public/signed NuGet `2.1.18` is the active consumer baseline. Official nupkg SHA-256 is `4FDE5FD1D18667B51E5FBF77DF66BE02FA33C9DD1551217D20FC9F6F1A4863AC`; package CSS SHA-256 is `6930F27E9FB55C80B4AAD858F6A89D698BDFF4CCB2346D0C035C66FC16FB1136`.
- Version 2.1.18 adds the public `FlatCardGrid.SearchTrailingActions` slot and package-owned input-boundary layout: reserved search-input space, trailing icon placement, hover/focus styling, and full-width responsive behavior. The toolbar action container is omitted when it has no view, overflow, custom, or Add action.
- This closes a **bug package** integration gap for the canonical compact profile-directory filter toggle. Consumers use the slot and must not reproduce `.flat-card-grid-search-*` geometry with local CSS. JavaScript and build props remain unchanged from 2.1.17.

# 2026-09-06 - NuGet 2.1.19 multipurpose operational and first-paint patch

- Public/signed NuGet `2.1.19` is the active consumer baseline. Official nupkg SHA-256 is `78FC3C81CF0F91EE6AF46DD8B68320CE3EDB8C932F41F998A9103D4C3F502BC1`; package CSS SHA-256 is `1EC4650E101D814B9F17CA3840A5DE25C63150D1EBAF12BB851B32447413BACB`.
- The official package functional payload matches the local source artifact: DLL `400B099E7F75A815A8D14E1D846D0E403987D7E5F26C60C11EF44A2DF3C06840`, readable JavaScript `E2A50CCFCC7F5C3B74F5334DF7E095765FF8C0D5B6D442D2461DF92FE981ADF4`, minified JavaScript `ECE1E26FDD1C0CBBC6AEF8BBEBFA5C3A9B0C8471DD85FDCBC821F3E0BEC9E9C5`, and theme bootstrap `190688E03BE1297D69C59BE7FB6851E31D6F08E1029F57A4BEB544EA55F34DA9`.
- Package 2.1.19 adds domain-neutral `FlatWorkInbox`, `FlatDataFreshnessIndicator`, `FlatScanInput`, `FlatTelemetryPanel`, `FlatRecordRelations`, and `FlatPersonalWorkspace` contracts. Canonical PageId remains `opx.page.reference.enterprise-toolkit`; `MultiPurposeExamples.razor` composes them with existing master-detail, document, scheduler, offline-sync, and dashboard foundations.
- Package JavaScript owns semantic filled-surface auto contrast and first-paint restoration of saved Device/Manual font mode, bounded font size, and density. Web and static MAUI documents seed the bootstrap data attributes before styles; theme and reconnect synchronization must preserve the restored typography.
- Scanning, authorization, persistence, per-item actions/results, telemetry transport, device command completion, alarm authority, storage, and native adapters remain host-owned. `Sent` or `Accepted` is not `Succeeded`; online, data quality, freshness, and sync state remain separate signals.
