# Repository knowledge

## MAUI/Web Back ownership decision

- Shared UI does not imply shared native navigation. Mobile browser/PWA remains Web: browser/Blazor history plus package Web overlay/dirty guards, never MAUI native dispatch or app-exit logic.
- Select native adapters through explicit host configuration/capability registration, not screen width or device appearance. MAUI owns IME/native Back/WebView history; retain one event owner and one action per Back.
- Follow `docs/AUTH-AND-NAVIGATION.md` (MAUI versus Web Back ownership). Test Web Back/Forward separately from Android native Back; documentation or successful builds do not prove runtime behavior.

Copyright (c) 2026 opx. All rights reserved.

This repository-local ledger preserves accepted OPX Flat UI knowledge for agents and generated consumers. It travels with the repository. User-folder memory and ChatGPT handoff files are supplementary recall only; they never replace this file, current source, compiled samples, package inspection, Git history, or live/device evidence.

## Maintenance contract

- Read this file after root `RULES.md` and `.agents/RULES.md`, before selecting a PageId or editing UI.
- After an accepted material change to package version, contract, PageId, behavior, showcase, responsive design, diagnosis, or host boundary, update the canonical source/rules/reference first and then refresh the relevant entry here.
- Record durable decisions and verified current state, not conversations, source dumps, secrets, credentials, personal data, assumptions, temporary experiments, or consumer-specific workarounds.
- Reverify drift-prone facts such as NuGet versions, routes, package assets, sample composition, and native runtime behavior. Mark unverified boundaries explicitly.
- If this ledger conflicts with compiled source or normative rules, stop and reconcile the conflict in the same change; do not silently choose or let this ledger override source.

## Current canonical snapshot

- 2026-09-24 guidance import for unchanged NuGet 2.1.42: merged source single/headerless chat, AI Chat-only 2px composition, MAUI table chaining, DIV CRUD scroll containment, root-only overlay locking and Horizontal typography/safe-area rules. See references/upstream-2.1.42.md. Restored chat API properties verified; package CSS matches upstream. No new runtime/sample/native code, global user skill or package pins changed; preserve Back separation and pending legacy host migration. Source historical tests are not consumer evidence.

- Current dependency: latest stable NuGet.org version verified on 2026-09-23 is 2.1.42. Repository signature valid; nupkg SHA-256 59B649F6C85AE7AA203DD3570E1B4FF0E579F4D96D875719D98D4B64F132E06E; CSS SHA-256 DF655DC5B0AB9B4C453C178C86E6F81276DA67A46A250DF2D0DC1FD2F1D29A57. Dependencies remain MudBlazor 9.10.0 and Blazor Components 10.0.12. This package/contract upgrade does not import new upstream samples or rules; preserve earlier guidance, Web/MAUI Back ownership and pending legacy native safe-area migration.

- Previous dependency: official NuGet.org 2.1.38; signature verified. Nupkg SHA-256 D3106E47CC93F726501ED586F3FFDEF940DC026D425F581826ED8456B536EB7F; CSS SHA-256 809DFDFDDE770E116A577588A753B207CB07DC1157789920FEC4A51F3B5A5EC6. Dependencies remain MudBlazor 9.10.0 and Blazor Components 10.0.12. This is a package/contract upgrade only; previous imported guidance, Back separation and pending legacy safe-area migration are preserved, with no new upstream sample or skill import.

- Previous dependency: official NuGet.org 2.1.37, signature verified. Nupkg SHA-256 D8745476494054E9C5A1B268F712EC19A792DD394628EC42276501C5E518C42E; CSS SHA-256 5F23B308CD5788491EF63B5F49A26526A39F3E7EBF3F7887C9ACB57B9780EA1D. Dependencies unchanged. Source guidance at c3d1f91 merged through references/upstream-2.1.37.md; official DLL verifies forms/card/choice-list APIs and AppBarUserContent/AppBarUserInfoVisible/Visible. Package repository metadata still records 0f6c95f. Keep local samples, Back separation and legacy safe-area migration boundaries unchanged.

- Previous dependency: official NuGet.org 2.1.36; signature verified; nupkg SHA-256 2C812D6E7B1FEFEBF6DE90AA325A2994843DE2A527FC8680741A36B2B91A3E59; CSS SHA-256 2F07805CF752EC0D62B40D05BA3F3DC41BC5D7208A15E4E937EBA7415FD7B2E4. DLL metadata confirms FlatUserMenu, FlatUserMenuItem and FlatRibbon. Dependencies unchanged from 2.1.35. Source working-tree guidance based on 0f6c95f merged into rules/agent/skill/docs and template mirrors; newer upstream ShowcaseUserMenu/preview integrations are not copied. Preserve Back host separation and the pending legacy MAUI safe-area migration.

- Previous dependency: official NuGet.org 2.1.35; repository signature verified; nupkg SHA-256 FB1D96F29FD85A13475D7D47C08A01D726956469A36A7B4538B3ACC362A9A5A6, CSS SHA-256 4E6F3C8C14ECAA33FD4D4F0116B8296C3C58BDAA32CE3D2984B4E28D50521676. MudBlazor 9.10.0 and Blazor Components 10.0.12 remain. Source guidance imported from working tree based on 0f6c95f: package-owned MAUI safe areas, native/env alternative inset ownership, explicit zero versus missing values, and limited native evidence. Read docs/HYBRID-SAFE-AREA.md; legacy MAUIHost app.css overrides and newer upstream iOS adapters require a separate host migration, not an assumed package-only fix.

- Previous dependency: official NuGet.org 2.1.34, MudBlazor 9.10.0, Blazor Components Authorization/Web 10.0.12. NU1605 from older direct pins requires aligning dependencies, not suppressing warnings. Repository signature verified; nupkg SHA-256 E8B15C903AAC143EEF8535DCA0F4827FD6FF3D2A6059D731F6962FAE47BC03AB; CSS unchanged from 2.1.33 (EE8519C20EF637D586C2F6254B7DB8C79F18AF6D52590998571786ED72D8A9B1). Package repository metadata points to 4cd157abfa823476504b898d95451f361104f44e. Prior imported guidance and Web/MAUI Back separation remain; no new upstream sample import in this upgrade.

- Previous dependency was official NuGet.org 2.1.33; repository signature verified, nupkg SHA-256 D4F77AC2C2BAE3B00384EABCC55D72A660C92242808A77A49D384885B898E725; CSS SHA-256 EE8519C20EF637D586C2F6254B7DB8C79F18AF6D52590998571786ED72D8A9B1. DLL metadata confirms rich chat Blocks, FlatChatBlockView, Compact, Portrait and PortraitAvatar. New transitive dependencies: Markdig 1.3.2 and HtmlSanitizer 9.2.1039. Source working tree remains based on e7c743d; stale unpublished-candidate notes are not release authority.
- Imported rich-chat, compact-metric and portrait guidance into repository agent/rules/skill and docs. Preserve host-specific Web versus MAUI Back ownership. Source previews/tests are not automatically local sample additions or native proof; local 72 shared + 4 native routes and historical gallery evidence remain unchanged.

- Previous dependency: NuGet.org 2.1.32. Imported footer/summary rules from the source working tree based on e7c743d; new FlatPanel.Footer, existing FlatWidget.Footer and .flat-content-note own responsive body inset without padding edge-to-edge tables or reserving absent-footer space. Previous source/sample import boundaries remain unchanged.
- Official repository signature verified. Nupkg SHA-256 0FCC871F26D16594D95068371CE61BB0189D98741878848975947108B50B1B7C; CSS SHA-256 1F7D9ECB9C94EBAB1125A0C7981C8F207F2BF530F734CC1D1253334BC9930CF1.

- Previous dependency was NuGet.org 2.1.31, source commit e7c743d. Rules/skill deltas are routed through references/upstream-2.1.31.md, including non-overlap, input/sidebar behavior and new component/layout references. New upstream pages and host integrations are not imported by this package/guidance change; local coverage remains 72 shared + 4 MAUI-only routes.
- Official NuGet repository signature verified. Nupkg SHA-256 61B1E1C8960C2163FEDDBF812B359E992DB365BBB0F74FA6F0D01E87F95CF83F; CSS SHA-256 724A258069E71A73F592B6406C4E7FD714448D0EE4EB94876F4542B6DA7CF832. Web/MAUI snackbar fade-out is 200ms; visible duration is unchanged.

- Previous dependency was NuGet.org 2.1.30. Official repository signature verified; nupkg SHA-256 775FC1666E55CBA1864721F0D643C973E5FDE390ADC6C4EC1CF1D9D128CD5BF9; CSS SHA-256 E9D5108276D87FAB3A43BD945A812221AAC85E677B2BF485CC764FE285CFD2D8 matches the upstream working-tree CSS. Lookup sticky headers keep an opaque resolved background in Light/Dark.
- Historical 2.1.30 provenance: upstream HEAD remained 26d476b with uncommitted 2.1.30 package/CSS changes; its agent/rules/skill files have no new delta. Preserve the previous import and consumer-specific rules, rather than replacing them with package-development defaults. Native device verification remains separate.

- Previous dependency: public NuGet 2.1.29; imported source commit `26d476b`. Reporting preserves package-owned responsive toolbar and bounded mobile-card scrolling with a fixed sibling pager. See docs/REPORTING.md.
- Official 2.1.29 repository signature verified. Nupkg SHA-256: 8E5823D31FC620F194B2C3B0529CE713937017D0A0E6956C43A147406AD9B433. CSS SHA-256: EFBBB7475A05C6ED0B82CDC380E6DC36F374E8879CABAFF9F94899C40009C684.
- Document transfer/hybrid operations rules are imported; newer transfer adapters and example wiring require separate consumer integration. NuGet contains shared APIs, not automatic host registrations. Existing gallery screenshots remain 2.1.27 evidence.

- Previous patch 2.1.27 adds shared PDF printing contracts, explicitly registered Web service and sample-owned Android/Windows adapters. Use authorized materialized bytes, preserve Submitted as unknown final outcome, and keep printer UI/storage/authorization host-owned. iOS printing requires an explicit adapter; thermal transport is not included.
- Official 2.1.27 signature verified; nupkg SHA-256: 7CC6157571C9035F7E32D0903B49B7DB5668E60B90656CAB3914C2345AA122BA. CSS remains 195B0111B3F1F8592034C1B123DC8B977607FA293F49A02D1A034EAFAC483FA3. Prior source/browser/native evidence is not exact-consumer runtime certification.

- Previous patch 2.1.26 fixes double status-bar inset in native fullscreen editor headers. Keep the panel as sole inset owner, header height 60px, Back target 40px and leading gutter 6px at <=760px. Verify absolute header top and long processing forms; native proof remains artifact/device-specific.
- Official NuGet 2.1.26 signature verified. Nupkg SHA-256: 786AB21B276D10548D2F73D4790C3E9B7A82FCB8A98E756739395208A96A2BA0. CSS SHA-256: 195B0111B3F1F8592034C1B123DC8B977607FA293F49A02D1A034EAFAC483FA3.

- Previous patch 2.1.25 added retained Bottom menu history and host-controlled hybrid recovery; follow docs/HYBRID-RECOVERY.md and docs/AUTH-AND-NAVIGATION.md. Draft recovery requires explicit consent and deep links require host authorization. DLL and matching JavaScript must deploy together.
- All 12 functional payload entries match source artifact `20260910-203021-2.1.25`. JavaScript SHA-256 is `999725AFF8F22261FB42578065D49C99DE7C08A13C0A8C1392489DDAFA6CEC29`; minified JavaScript is `63FB390ED43388B3521043AD44FC32B424F9CF484D84AC869FACFEBD562EEFA5`. Prior source Debug/emulator evidence does not certify this consumer Release package.
- Official 2.1.25 NuGet signature verified; nupkg SHA-256: 9D9B050005C125B26AA4E30907959E3280C60DE3012CDB2F51CB58D1E5B25929. Original CSS remains unchanged from 2.1.22/2.1.23.

- Patch 2.1.23 imports the shared resolver/builder URL-normalization contract from `D:\projects\git\mudblazor-flat-ui`. Single-leading-slash local routes are accepted before absolute URI parsing on Unix/Android; Unicode normalization precedes rejection of protocol-relative URLs and backslashes. Dynamic Url values need no business mapping; consumers reuse the package implementation.
- Official 2.1.23 nupkg SHA-256: `A5BA761FC1BB2C1BB969CAE2AA1C9E7A5E772970D3A6FB86A0043DB02F9645C5`. NuGet.org repository signature verified. CSS SHA-256 remains `43283F075176C584A8AE7EC4D60846CF8BFA4959A09384082D48CE206474BDD2`; device and Linux evidence remain separate from Windows builds.

- Consumer UI authority: this repository and shared `samples/Opx.MudBlazor.FlatUi.Showcase` composition.
- Reusable UI dependency: public NuGet `Opx.MudBlazor.FlatUi` `2.1.42`; package source checkout is inspection authority only, never a consumer `ProjectReference`.
- MudBlazor baseline: `9.10.0`; consumer contract schema: `3.1`; default theme: Light.
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

# 2026-09-06 - NuGet 2.1.20 Tree Grid and IconPicker patch

- Public/signed NuGet `2.1.20` was the consumer baseline. Official nupkg SHA-256 is `3FC315ADBDD72A38822A8F61DFC2027033B0DBD11A2A59D59354D4FAC6290BC3`; package CSS SHA-256 is `3FF9B8E8C3E1769F02BFCC68C0EC485C65A1B90E0E159B888297756D8509C37B`.
- The official package functional payload matches the local source artifact. Package JavaScript and build-transitive props remain unchanged from 2.1.19; the DLL/public API and CSS changed for Tree Grid reordering and IconPicker configuration.
- `FlatTreeGrid.AllowReorder` is opt-in. Stable item keys own expansion and keyed DOM identity; `DefaultExpanded` seeds newly observed nodes only. `Before`/`After` provides `TargetKey` plus post-removal `NewSiblingIndex`; the host persists parent and sibling order atomically and refreshes `Items`.
- `FlatMaterialIconPicker` adds `SelectText`, `CancelText`, `EmptyTitle`, `EmptyMessage`, and `ShowMoreText`. Icon keys remain case-sensitive, and the host persists stable `Name`/`Style` rather than copied SVG.
- MAUI template source must protect the real `#if ANDROID` WebView-history block with `cnd:noEmit`; otherwise `dotnet new` consumes the block as a template condition and generated apps lose `CanGoBack()`/`GoBack()`. Fresh generated output, not a direct template-folder build alone, proves this contract.

# 2026-09-10 - NuGet 2.1.22 hybrid reliability and productivity baseline

- Public/signed NuGet `2.1.22` was the consumer baseline. Official nupkg SHA-256 is `08CE66780D1ECA664043F2A506D7EAC1BAD71224C9EB9A809A282B3880032BEB`; CSS SHA-256 is `43283F075176C584A8AE7EC4D60846CF8BFA4959A09384082D48CE206474BDD2`; DLL SHA-256 is `46990AD2F812602CDB84633B09703966AB280DE5C6714B11EDCE78F718C80D96`.
- The official archive has a valid NuGet.org repository signature and its functional payload is byte-identical to canonical local artifact `20260909-213441-2.1.22`; the local archive itself is unsigned. Readable JavaScript SHA-256 is `F8FB8DE2E1824EA9767C70A999E99349F80365053D9A6B2749F08719E5BCFCBD`; minified JavaScript SHA-256 is `9544D02B8D17E0FCDE72038B5CE4BFA3AFD17A4C0CAE0F7E3188B50430D9A9AF`.
- `FlatRefreshMode.Auto` coordinates native MAUI refresh versus Web gesture refresh; `Disabled` overrides legacy native/Web/dashboard flags without disabling ordinary scrolling. Native Android still needs the canonical host handler, per-gesture scroll-boundary gate, overlay coordination, and exact Back pipeline.
- Model CRUD uses per-session value snapshots, revert-to-clean behavior, single-flight Delete, and separates committed persistence success from later callback failures. Shared editors use the default discard question and keep clean guards out of `NavigationLock`.
- Hybrid Back order is IME, topmost overlay, explicit WebView history, then root. Responsive Vertical drawers and sheets participate in overlay coordination and suspend native refresh while active. Native Settings uses measured top/bottom insets; standalone `FlatPage` forms and CRUD modals use visual-viewport keyboard avoidance.
- P1/P2 productivity remains on `opx.page.reference.enterprise-toolkit`: saved views keep query/layout snapshots, nested `FilterTree` is authoritative, context changes guard unsaved work, record selection uses stable keys, and bulk retry targets failed retryable items only. Host authorization, scoped persistence, query execution, cancellation, and idempotency remain authoritative.
- Browser tests and Android compilation do not prove physical-device/iOS behavior. Native refresh, edge/predictive Back, IME, safe areas, lifecycle, notifications, screen readers, and performance require matching emulator/device evidence.
