# Repository agent instructions

NuGet 2.1.29 import: use `opx.page.reporting.operational` (`/reports`) and `docs/REPORTING.md` for responsive reporting. In a bounded `.module-panel`, keep the viewer shrinkable, its mobile cards as the vertical scroll owner, and a non-shrinking sibling pager outside it. Toolbar copy/actions share one mobile row; optional toolbar content occupies the next. Unbounded viewers keep natural flow. Reuse package CSS; never add consumer overrides.

For document Save/Share/Open, reuse `FlatDocumentTransferService` with explicit host adapters; read `docs/HYBRID-OPERATIONS.md` and use `opx.page.reporting.pdf-viewer`. Web Open is PDF-only; unsupported Share/Open offers Download, not a silent external fallback. Keep submitted handoff distinct from completed delivery and retain native shared files for the documented cache lifetime. This rules import does not automatically register newer transfer adapters in this consumer or its minimal MAUI template.

Hybrid operations use `opx.page.reference.experience-toolkit`: distinguish network/API/session and capability/permission; keep scans inert, preserve retry idempotency, and reconcile unknown dispatch outcomes. In-memory coordination is not durable offline storage; optional print contracts do not prove native support. Use the upstream source checkout for the new adapters/examples and require separate device evidence.

For PDF printing use PageId `opx.page.reporting.pdf-viewer` and `docs/PRINT-SUPPORT.md`. Reuse `IFlatPrintService` through `FlatPdfViewer.OnPrint` with authorized materialized PDF bytes. Web explicitly registers scoped `FlatWebPrintService`; MAUI must register its host-owned adapter separately. NuGet does not install native adapters. `Submitted` means final outcome unknown, including browser dialog closure or Android OnFinish without a terminal job state; never relabel it Completed/Cancelled. Capabilities do not discover printers or authorize printing. Host adapters own files, native UI, document policy and cleanup; thermal/ESC-POS is separate. Ship matching DLL/source/minified JS and distinguish exact-package tests from earlier browser stubs/native artifacts.

For native fullscreen CRUD/FormModal headers at <=760px, read `docs/NATIVE-EDITOR-HEADER.md`. The panel alone consumes measured status-bar top inset; the header must not add another safe-area inset. Preserve the 60px toolbar axis, 40px Back target and 6px leading gutter, plus ordinary Web/desktop defaults. Verify absolute header top against the measured inset, processing fieldsets, long content and footer reachability. Consume the NuGet 2.1.29 CSS; do not add consumer overrides. Simulated browser geometry and upstream tests are separate from rebuilt consumer APK/device evidence.

NuGet 2.1.29 includes Bottom-menu history and hybrid recovery. Read `docs/AUTH-AND-NAVIGATION.md` and `docs/HYBRID-RECOVERY.md`; use `opx.page.erp.finance.general-ledger` for Back and `opx.page.reference.experience-toolkit` for recovery. Both Sheet/MainView restore the visited submenu, parent, then actual origin; preserve Forward and IME/modal/dirty priority. Direct URLs never invent a trail, and replaced authorized menu collections invalidate snapshots. Retain inactive Bottom history across sidebar transitions but release overlay/refresh leases. Reuse `FlatWorkspaceRecovery`, `FlatDraftRecovery<T>` and `FlatDeepLinkGate`: scoped/versioned storage, explicit draft consent and mandatory host authorization. Encryption, data validation and persistence remain host-owned. Upgrade DLL and matching source/minified JavaScript together; stale static assets can break Back. Keep native evidence tied to its exact package/APK, separate from browser/source checks.

For dynamic navigation, use the NuGet 2.1.29 shared URL normalization contract in `docs/DYNAMIC-MENU.md`. Single-leading-slash routes must survive the resolver-to-builder path on Unix/Android; no domain mapping is required for valid dynamic Url values. Do not add a consumer URL-normalization workaround.

For mobile reliability, hybrid hardening, refresh, native Back, Settings safe areas, or keyboard avoidance, read `docs/MOBILE-RELIABILITY.md` and `docs/HYBRID-HARDENING.md` plus the mapped Experience Toolkit sample before editing. Preserve the canonical host adapters; package-only upgrades do not replace native integration work.

Model CRUD and shared editor samples use per-session value snapshots, immediate focused-change detection, revert-to-clean behavior, the default discard question, and single-flight mutations. Keep committed persistence success separate from later notification/reload failures.

Android Back is layered and paired-key single-flight: IME, topmost overlay, explicit WebView history, then root fallback. Responsive Vertical drawers and sheets participate in the shared overlay coordinator and suspend native refresh while open.

`FlatRefreshMode.Auto` chooses native MAUI refresh or the package Web gesture. An unqualified request to disable pull-to-refresh means `FlatRefreshMode.Disabled`, which overrides legacy gesture flags without disabling ordinary scrolling or unrelated loading.

For P0 compatibility, test the exact restored/packed binary. For P1/P2 productivity, use the shared enterprise-toolkit saved-view, context, nested-filter, record-workspace, and bulk-progress contracts while keeping host authorization, persistence, queries, and idempotency outside the UI package.

Copyright (c) 2026 opx. All rights reserved.

These instructions apply to every file in this repository.

## Required reading order

Before creating or changing a page, layout, reusable component, CSS rule, navigation item, or host configuration:

1. Read the user request and preserve its explicit decisions.
2. Translate it into the user or role, primary job, information hierarchy, action/risk/permission needs, device/input context, required states, accessibility, localization/RTL, and responsive behavior.
3. For a layout request, state the chosen shell, regions/hierarchy, desktop and tablet/phone composition, action placement, states, and UX rationale; infer ordinary OPX layout details when the intent is sufficient.
4. Read the repository root `RULES.md` completely.
5. Read `.agents/RULES.md` completely.
6. Read `.agents/KNOWLEDGE.md` completely; treat it as the portable accepted-decision ledger, not as a replacement for current source or evidence.
7. Read `.agents/PROMPTING.md` and resolve short natural-language prompts without requiring OPX terminology.
8. Use `.agents/skills/opx-flat-ui-development/SKILL.md`.
9. Resolve the request to one stable `PageId` using `.agents/skills/opx-flat-ui-development/references/page-registry.md`, then apply its canonical CRUD/form/grid/state/responsive profile from `showcase-behavior-registry.md`; the user does not need to choose either value.
10. Open the closest matching page under `samples/Opx.MudBlazor.FlatUi.Showcase` from the skill's sample source map.
11. Treat reusable package APIs as NuGet-owned; use `D:\projects\git\mudblazor-flat-ui` only to inspect package internals, never as a consumer `ProjectReference`.

## Authority and source of truth

- Explicit user decisions have highest authority.
- Root `RULES.md` is the normative product/UI contract.
- `.agents/RULES.md` defines the repository development workflow.
- `.agents/KNOWLEDGE.md` is the repository-local durable decision ledger and must stay synchronized with accepted current contracts.
- `.agents/PROMPTING.md` is the simple natural-language request contract; it keeps OPX/PageId/component decisions agent-owned unless one material workflow question remains.
- `samples/Opx.MudBlazor.FlatUi.Showcase` is the shared behavioral and composition source of truth for page development.
- For initialized admin consumers, host `MainLayout.razor` plus shared `ShowcaseNavigationCatalog` are the source of truth for mandatory Settings and the default searchable navigation scaffold.
- NuGet `Opx.MudBlazor.FlatUi` is the only consumer dependency for reusable components; the package-source checkout is inspection authority, not a local reference.
- The accepted public baseline is NuGet `Opx.MudBlazor.FlatUi` 2.1.29. Import additive package contracts into rules, skills, templates, and audits while preserving this repository's NuGet-only consumer boundary.
- `docs` and `README.md` explain the implemented contract but do not override compiled source.

When source, rules, and documentation disagree, do not silently choose one. Preserve the accepted behavior, update stale documentation/rules in the same change, and report any unresolved conflict.

## Delivery boundary

- For Tree Grid changes, read `docs/TREE-GRID.md`: `AllowReorder` is opt-in; persist destination sibling index after removing the source together with parent in the host. Expand/collapse follows stable keys and must survive reorder and collapse-all.
- IconPicker requests reuse `FlatMaterialIconPicker` and `docs/ICON-PICKER.md`. Keep case-sensitive style/name keys and configurable button/empty-state text. Test zero matches, clearing, and style changes; a canonical picker test does not prove an unrelated consumer circuit defect is fixed.
- Keep reusable source domain-neutral and keep domain examples in the sample project.
- Keep `FlatEmptyState` centered against the complete available content region. A direct child of a multi-column grid spans all columns; do not center it inside only the first grid track.
- Preserve copyright headers on new source, scripts, rules, and documentation.
- Preserve unrelated worktree changes. Do not reset, stash, or overwrite user work.
- Do not claim API, authentication, persistence, Cloudflare, IIS, WebSocket, or native MAUI behavior without matching live evidence.
- Build and validate in proportion to the change. Browser responsive checks do not prove native MAUI behavior.
