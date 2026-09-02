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
- Reusable UI dependency: public NuGet `Opx.MudBlazor.FlatUi` `2.1.10`; package source checkout is inspection authority only, never a consumer `ProjectReference`.
- MudBlazor baseline: `9.9.0`; consumer contract schema: `3.1`; default theme: Light.
- Default color palette is the built-in package ID `fluent-blue`; Restore returns to it, while an explicitly saved user palette remains authoritative until restored.
- Web and MAUI load the shared Showcase routes/navigation; native-only diagnostics remain host-owned.
- The canonical registry has 76 unique PageIds and routes. Every PageId maps exactly once to one of 45 declared profiles in `showcase-behavior-registry.md`.
- Prompt resolution is requirements/job -> PageId -> behavior profile -> mapped sample/archetype -> implementation. The user does not need to supply PageId, form layout, CRUD mechanics, grid behavior, spacing, or standard responsive transformation.
- `.agents/PROMPTING.md` is the canonical shortcut contract: a short business phrase is enough, routine UI decisions remain agent-owned, and at most one question is asked only for a material workflow/authority/native distinction.
- ERP, HR, and enterprise prompts use `enterprise-domain-layout-decision.md` to choose a dominant operating mode before components. The agent decides the canonical layout from role, job, data sensitivity, lifecycle, transaction consequence, action risk, and viewport. Distinct HR jobs are not collapsed into generic CRUD, and authoritative policy, formulas, approvals, payroll/accounting/inventory effects, permissions, persistence, and audit remain host-owned.
- Package-first reuse is mandatory: inspect the supported NuGet public API and mapped canonical sample, use an existing capability through its public seam, and never duplicate package behavior or assets in a consumer. A verified missing domain-neutral capability is proposed as a package addition; a domain, authorization, persistence, integration, or native need is proposed as a host-owned seam. Package changes and publication require explicit approval.
- When analysis finds a material improvement, report it as `Saran UI/UX` with need/risk, one concrete recommendation, user/business impact, priority (`Wajib`, `Disarankan`, or `Opsional`), and scope/approval boundary. Do not add filler suggestions or silently expand scope.

## Imported 2.1.10 package capabilities

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
- Ordinary buttons default to a `7px` corner radius through package-owned `OpxFlatUi:Display:DefaultRoundedSizePx`. The same bounded `0-12` token controls bottom-sheet top corners; cards, panels, inputs, dialogs, menus, grids, toolbars, and workspaces remain square. Do not create consumer/page-local radius overrides. Package 2.1.10 excludes `.flat-system-loading-spinner` from broad zero-radius resets, so startup/reconnect spinners remain circular inside shells, dialogs, and portals without consumer CSS.
- CRUD uses the visible verb `Edit`, not `Ubah`. Forms preserve validation, dirty-state guard, functional Add/Edit/Save/Cancel/Delete, desktop compact multi-column layout, and mobile one-column/fullscreen editing where appropriate.
- Back behavior is layered and Blazor-first: an open CRUD/form modal consumes the first Back and keeps the route/application alive; the next Back navigates through prior Blazor WebView history. MAUI Android delegates to native Back/app exit only when no package modal/overlay and no prior WebView history entry remain. Package 2.1.10 owns modal interception; WebView-history fallback is host-owned.
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

# 2026-09-02 - NuGet 2.1.10 Login and grouped-grid contracts

- Public consumer baseline is `Opx.MudBlazor.FlatUi` `2.1.10`; reusable CSS must resolve from that NuGet package and match SHA-256 `3C3BE5D054F89B47EDDC1C0298B3D390BA938F76C66801898DEAE13DCF046FD0`.
- `FlatApplicationOptions.LoginBrandPanelVisible` defaults to `true`. With `LoginLayout=Default`, `false` centers the unboxed Login form without rendering the brand panel; `Boxed` remains a separate bounded composition.
- `FlatGroupedDataGrid<TItem>.GroupHeaderAlignment` defaults to `Left` and accepts `Center` or `Right`; the package owns text and content-axis alignment for desktop and responsive headings.
