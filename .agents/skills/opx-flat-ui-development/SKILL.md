---
name: opx-flat-ui-development
description: Create or update Razor pages, layouts, navigation, responsive grids, CRUD editors, reusable MudBlazor components, theme behavior, and host configuration in Opx.MudBlazor.FlatUi. Use for development in this repository or when deriving a consumer implementation from its sample source of truth.
---

# OPX Flat UI development

Use the repository's compiled sample as the behavioral source of truth and the RCL source as the reusable API source of truth. Do not introduce another UI framework.

## Start every task

1. Read repository `RULES.md` and `.agents/RULES.md` completely.
2. Read [sample-source-map.md](references/sample-source-map.md) and select the closest archetype.
3. Open that sample page/layout and every shared component it directly uses.
4. Inspect nearby repository instructions and the current worktree before editing.
5. State any assumption that materially changes page type, permissions, data ownership, or responsive behavior.

## Roadmap gate

- Read repository `ROADMAP.md` before work that changes tests, uploads, grid preferences, virtualization, public APIs, versions, or packaging.
- Follow the approved order: automated test foundation, FlatFileUpload, then advanced grid preferences.
- Do not introduce phase 2/3 public APIs before unit, bUnit, responsive Playwright, accessibility, and public API compatibility baselines protect current behavior.
- Treat the feature set as minor release `1.1.0`, not patch `1.0.17`. Do not bump the package version or publish merely because roadmap documentation changed.
- Keep native adapters, upload/storage/security, per-user persistence, and virtualized data access host-owned through explicit interfaces/callbacks.

## Choose the implementation surface

- Add page composition and domain examples under `samples/Opx.MudBlazor.FlatUi.Sample`.
- Add or change `src/Opx.MudBlazor.FlatUi` only for domain-neutral reusable behavior.
- Extend an existing shared component before duplicating its markup in several pages.
- Keep services, authorization, persistence, API clients, and native platform adapters owned by the host through explicit interfaces/callbacks.
- Treat `wwwroot/opx-flat-ui.js` as the only JavaScript source to edit. Release/Pack generates `opx-flat-ui.min.js` through the pinned repository toolchain. Bind `FlatAssetOptions`; Debug must select source and Release defaults to minified while allowing an explicit appsettings override.

## Build a page from a sample

1. Copy the structural pattern, not the sample's business text or records.
2. Add an exact `@page` route and update route-aware AppBar title/search/navigation sources.
3. Keep operational pages free of duplicate title/description blocks unless explicitly requested.
4. Use `FlatPage`, shared toolbar actions, desktop table, responsive cards, shared pager/query state, and the correct FAB/no-FAB contract.
5. Use shared modal, processing, message-box, settings, notification, and reconnect components instead of page-local alternatives.
6. Keep all field controls dense and theme synchronized; include disabled, loading, empty, error, and narrow viewport states. Make an outlined field container own one continuous theme-resolved surface across its value and adornment areas, including autofill; keep adornment wrappers, glyphs, and icon buttons transparent, borderless, and shadowless over that shared surface without changing unrelated icon buttons.
7. Establish application metadata and Login branding during initial host scaffolding, before feature-page development. Bind typed `OpxFlatUi:Application` options and seed `AppName`, `CompanyName`, `Author` (default `opx`), copyright, `LoginBrandBackgroundColor`, `LoginBrandBackgroundImageUrl`, `LoginBrandOverlayColor`, and `LoginBrandOverlayOpacity` in appsettings. Render `ApplicationOptions.ResolvedAuthor` once as `<meta name="author">` in the host document `<head>` so every route inherits it; do not repeat metadata in individual pages. Treat both `Logo` and `LogoUrl` as optional; omit the logo wrapper and reserved gap when neither resolves, and keep a configured logo compact. Validate colors and opacity in the library, allow only relative/HTTP(S) image URLs, and render images as `<img>` instead of raw configured CSS. Follow the operational split desktop/mobile composition, omit the duplicate top identity row, lock fields during a single-flight submit, omit static security/sample banners below the form, and show required/invalid credential feedback through the shared Error MessageBox with generic wording. Do not import or imply the reference application's live auth/session contract.
8. Give Not Found content standard page gutters and map unknown routes to the AppBar PageTitle `Not found`.
9. Mark Login/auth password controls with a show/hide action using `opx-password-visibility-field`; keep the eye icon white in resolved Dark/Night and `#212529` in resolved Light regardless of whether the input currently renders as password or text.
10. Preserve English reusable/sample defaults and copyright headers.

## CRUD and data rules

- Configure the standard CRUD create action once through `FlatPage.PrimaryActionVisible`, `PrimaryActionLabel`, `PrimaryActionIcon`, `PrimaryActionAriaLabel`, and `OnPrimaryAction`. Let `FlatPage` render the Filled desktop button above `900px` and the icon-only FAB at `900px` and below; do not pair the automatic API with manual `HeaderActions` or `MobilePrimaryAction` markup.
- Keep filter/search/sort/paging state shared between desktop and mobile views. Table-grid filters default to the `GridColumnDefinition` contract: pass the same `Columns` collection and exact `GridViewState` to `FlatDataGrid` and `MobileGridFilterSheet`, and derive toolbar Filter visibility from whether any column has `FilterEnabled=true`. Do not duplicate mobile filter metadata/state; clear stale criteria when columns are disabled or removed.
- Bind reusable paging defaults from `OpxFlatUi:Grid` into `FlatGridOptions`, register the options with the host, and initialize each page's `GridViewState` from them before the first local/API load. Preserve `SetPageSize(...)` and `FlatPager.PageSizes` for intentional page-specific overrides.
- Hide Filter when no actionable filter UI exists. Keep import/export/download/refresh/custom actions icon-only in one toolbar row.
- Keep one scroll owner per desktop grid: `FlatDataGrid` provides the bounded vertical/horizontal region, while toolbar and pager stay fixed. A custom direct `div` host under `.module-panel` is supported without a package-specific class name; it must resolve shrinkable on desktop and disappear when the equivalent mobile grid is active. Do not add a competing active wrapper scroller; verify `scrollHeight > clientHeight` and `scrollWidth > clientWidth` cases with `overflow:auto` and visible theme-synchronized scrollbars, including while a modal locks document scrolling. Repeat that verification after a no-reload desktop -> tablet/mobile -> desktop resize cycle and after changing viewport height.
- Bind each `FlatPage` initial empty request to `InitialLoading`. Let `FlatPageKind` choose the default skeleton (`Module` grid, `CrudForm`/`Settings` form, `Dashboard` dashboard, other kinds list/detail); use `SkeletonTemplate`, count overrides, or `LoadingContent` only when automatic geometry needs refinement. Global defaults come from `OpxFlatUi:Loading`, while `SkeletonEnabled` is the page-level opt-out. On later refresh, filter, sort, paging, or CRUD reload, retain existing content and use the AppBar loading line; never reuse the initial-loading flag for those operations.
- Return modal result false for Back, Cancel, or permitted backdrop close without caller refresh. Return true only after successful submit; refresh CRUD callers through their existing query-preserving load pipeline.
- Make mobile CRUD editors fullscreen and safe-area/keyboard aware. Consume system/browser Back in the editor before page navigation.
- Make API loading single-flight, cancellation-aware where supported, and truthful about failures. Never present HTTP 200 alone as business success when the host contract has its own result/status envelope.
- Build inline row Add/Edit/Delete with `FlatEditableGrid<TItem>`: one cloned draft, host-owned cancellable persistence, validation that retains the draft, Cancel without source mutation, and explicit destructive confirmation. Prefer `SaveRow` returning `FlatGridEditResult<TItem>` for the canonical persisted row and consume `RowResult` for exact per-row Create/Update/Delete success, failure, validation, and cancellation outcomes. Use the page primary action for standard Add/FAB behavior and grid Add only when embedded. Supply equivalent mobile templates.

## Responsive and theme rules

- Enable pull-to-refresh only on eligible pages with a real handler. Reuse `FlatPage`'s shared native-like vertical direction lock, resistant finger-following indicator, pull/release/refresh states, held refresh position, and snap-back. Do not duplicate the gesture or indicator in a page. Browser simulation is not native MAUI proof.
- Use `14.5px` as the configured OPX base-font baseline for new hosts; keep it bounded and overridable through `OpxFlatUi:Display:DefaultFontSizePx`.
- Drive every textual surface from `--opx-ui-font-size`, preserving each component's ratio to the `14.5px` baseline. Do not scale icons, spacing, or control geometry when Font size changes; those remain owned by the selected density preset.
- Preserve equal 16px mobile outer gutters and viewport/AppBar/safe-area-aware panel height.
- In phone Bottom navigation, keep the hamburger absent and apply `16px` left/right AppBar toolbar gutters; do not let AppName/PageTitle or trailing actions inherit the compact drawer-mode edge spacing.
- Switch operational tables to equivalent cards at 900px and below; desktop tables start above 900px. Keep the transition reversible during live resize, preserve one query state, and do not use page-level horizontal scrolling as the mobile solution.
- Keep Light and Dark/Night surfaces, portals, selection, placeholder/floating-label typography, disabled states, snackbars, backdrops, and reconnect UI on shared tokens/options. Dark administrative components use the shared graphite hierarchy (`#1a1d21`, `#212529`, `#262a2f`, `#2a2d31`, `#292e32`, `#32383e`) and must not retain legacy pure-black islands. For `Auto`, verify the host loads `opx-flat-ui-theme-bootstrap.js` before stylesheets, first paint matches `prefers-color-scheme`, and later device-theme changes update the active shell without reload.
- Keep default checkbox state explicit: checked/indeterminate uses the active accent, unchecked remains readable, enabled labels use normal foreground, and disabled glyph/label contrast is substantially quieter in both themes. Keep checkbox icon surfaces transparent and do not override explicit semantic checkbox colors.
- Preserve `#004a77` as the built-in `blue` palette's enabled Filled Primary surface in both Light and Dark/Night, with white content and the documented hover/subtle/emphasis family. Apply primary changes through `FlatUiColorPaletteOption` and shared tokens, not page-local button CSS; appsettings may intentionally replace the built-in palette.
- Verify theme resolution as one atomic state: root uses isolated `opx-root-theme-*` first-paint classes, the active shell uses `theme-*`, and explicit Light/Dark must override a conflicting device preference without mixed root/card/control surfaces. Never reuse the shell `theme-dark` class on `<html>`.
- Expose sidebar menu background and foreground as validated six-digit Light/Dark host options under `OpxFlatUi:Display`; pass normalized values to `FlatAppShell` CSS variables and preserve semantic hover/active contrast.
- Add sidebar status/counts with `FlatNavigationBadge`. Place it in a leaf link's child content or a parent group's `TitleContent`, while keeping the parent `Title` populated for accessibility. Use a meaningful `AccessibleLabel` for dot-only badges and verify that badge presence does not shift the established icon, text, connector, or chevron coordinates across expand/active/responsive states.
- Keep nested sidebar font/icon/row/padding selectors depth-based and independent from transient expand classes. Verify the first expand/collapse click does not change computed typography or text coordinates.
- Treat the sidebar search placeholder as compact navigation copy: approximately `9-10px`, weight `400`, scoped to `.sidebar-search-input` so global form and AppBar placeholder typography is unaffected.
- Keep native placeholders, empty/non-floating labels, floating labels, entered text, and selected combo values at normal `400` weight without changing responsive size, color, dense height, gap, outline, or label geometry.
- Keep browser autofill theme-synchronized globally: standard `:autofill` and Chromium `:-webkit-autofill` hover/focus/active states must retain the resolved field surface, foreground, and caret colors without splitting the input area from its adornment. Do not change control geometry or scope the correction only to Login.
- When a layout contains `FlatProfileAvatar`, target adjacent copy through an explicit class rather than a broad direct-`span` selector. Preserve the avatar root's `display:grid`, fixed geometry, clipping, and centered initials/image; verify narrow and desktop rendering.
- Treat browser breakpoint tests as Web proof only. Require emulator/device validation for MAUI system Back, IME, safe areas, lifecycle, permissions, notifications, and native gestures.

## Chart samples

- Build chart samples with real `MudChart` components. Keep `/charts` synchronized with every `ChartType` exposed by the pinned MudBlazor package, include expandable copy-ready Razor for each standard and specialized data contract, and verify every chart renders without document overflow on desktop and mobile in Light/Dark themes.

## Reporting

- Compose operational result pages with `FlatOperationalReportViewer<TItem>`: host-owned filters/query, explicit KPI, grouped desktop rows, optional subtotal/grand-total templates, row drill-down, and equivalent grouped mobile cards. Keep refresh/print/export callbacks host-owned and use the three-dot export menu on constrained widths. Large report generation, authorization, scheduling, storage, delivery, and PDF/Excel engines never belong inside the reusable viewer.
- Compose pivot analysis with `FlatPivotGrid<TItem>`: typed row/column/value selectors, explicit aggregate, labels/formatter, totals, and exact-cell drill-down. Keep one internally scrolling sticky matrix above `900px` and equivalent cards at/below it. Scale headings, dimensions, totals, and values from compact `--opx-ui-font-size` ratios and use a smaller phone ratio at `600px`; never let Pivot inherit the full body size or use fixed pixel typography. Treat supplied items as the aggregation boundary; protected or large datasets require host/backend aggregation, authorization, query bounds, units, export, persistence, and OLAP integration.

## Roadmap components

- Implement hierarchy through `FlatTreeGrid<TItem,TKey>`; keep source collections/persistence host-owned, return exact old/new parent keys, reject self/descendant moves, and pair Web drag/drop with touch-accessible promote/indent actions.
- At mobile/tablet breakpoints render Tree Grid as a Windows Explorer-style continuous list: folder/file icon, expansion chevron, bounded indentation, dotted branch connector, secondary metadata, pressed feedback, and a three-dot menu for move actions. Keep desktop grid columns and Web drag/drop above `900px` only.

- Run xUnit, bUnit, public API compatibility, responsive Playwright, and axe gates before accepting additive APIs.
- Implement file upload UI through `FlatFileUpload`; keep transport, storage, authorization, scanning, retry policy, and native picker implementation host-owned.
- Implement grid presentation state through versioned `FlatGridPreferenceState`, scoped `IFlatGridPreferenceProvider`, deterministic normalization, and cancellation-aware `FlatGridVirtualLoader<TItem>`.
- Keep dense showcase matrices within their panel using responsive layout or internal scrolling. Add a browser containment assertion when fixing overlap.

## AI chat templates

- Compose `FlatChatShell`, conversation items, messages, and typing indicators; keep prompt/history/model/provider state in the host.
- Use a bounded desktop history/thread split and separate mobile history/thread states at `900px` and below. Back returns to history without route navigation.
- Keep sending single-flight with explicit responding and cooperative Stop states. Static samples must state that responses are local and must not imply external inference, upload, retrieval, authorization, or persistence.
- Route real AI traffic through a secured backend. Never place provider keys or privileged tokens in Razor, browser storage, query strings, or client configuration.

## Synchronize and validate

Update implementation, sample composition, root rules, relevant documentation, and this local agent package whenever their contract changes.

Run:

```powershell
& .\.agents\skills\opx-flat-ui-development\scripts\audit_flat_ui_repo.ps1
dotnet build .\samples\Opx.MudBlazor.FlatUi.Sample\Opx.MudBlazor.FlatUi.Sample.csproj -c Release --nologo
git diff --check
```

Verify recursive Release/package PDB count is zero. For asset changes, additionally prove Debug did not generate/select the minified script, Release generated/selected it, and the NuGet package contains both source and minified assets. For visible changes, validate the affected interaction and representative desktop/mobile geometry. Report unverified external/native boundaries explicitly.
