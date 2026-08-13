# OPX Flat UI repository development rules

Copyright (c) 2026 opx. All rights reserved.

## Source-first development

- Treat `samples/Opx.MudBlazor.FlatUi.Sample` as the page-development source of truth. Start from the nearest sample archetype and preserve its shell, state ownership, responsive switching, loading, modal result, toolbar, FAB, and theme behavior.
- Treat `src/Opx.MudBlazor.FlatUi` as the reusable-component source of truth. Reuse an existing component before adding page-local markup. Move a pattern into `src` only when it is genuinely domain-neutral and reusable.
- Never copy sample business wording or static records into a reusable component. Samples may demonstrate IT, ERP, ecommerce, content, and operations; shared APIs remain domain-neutral.
- Do not create a new page from memory when a matching sample exists. Read the sample and the components it invokes before editing.

## New or changed pages

- Register an exact route, route-aware `PageTitle`, sidebar item, horizontal navigation/search entry where applicable, and permission boundary owned by the host.
- Do not render a duplicate page title or description by default. The AppBar owns `AppName` and current `PageTitle`.
- Use `FlatPage` for operational pages. Keep grid actions in its toolbar and hide unavailable actions. Standard writable CRUD pages define their single create action once with the `PrimaryAction*` parameters and `OnPrimaryAction`; `FlatPage` automatically produces the desktop button and icon-only mobile FAB without duplicate markup or an empty responsive action row.
- Use desktop tables above `900px` and equivalent responsive cards at `900px` and below; preserve one shared query/filter/sort/paging state. The switch must remain reversible during live window resize without reload, restore both internal table scroll axes when returning to desktop, and never create document-level horizontal overflow.
- Bind first empty requests to `FlatPage.InitialLoading`; the package chooses a responsive skeleton from `FlatPageKind`. Override with `SkeletonTemplate` or `LoadingContent` only when automatic geometry does not match, and keep global defaults in `OpxFlatUi:Loading`. Skeletons are initial-empty-state feedback only; refresh, filter, paging, sort, and CRUD reload keep current data visible and use the shared AppBar loading line.
- Desktop `FlatDataGrid` owns a single bounded two-axis scroll region. A direct `div` wrapper under `.module-panel` may use any host class; the package makes it shrinkable on desktop and hides it when the equivalent mobile grid is active. Keep toolbar and pager outside the grid scroll region, let intrinsic wide columns create horizontal overflow, let excess rows create vertical overflow, and do not add a second active scroller around the component.
- For table grids, derive default filters from the grid's `GridColumnDefinition` collection. Desktop headers and `MobileGridFilterSheet` use the same `Columns` and exact `GridViewState`; toolbar Filter visibility follows `Columns.Any(column => column.FilterEnabled)`. Never create separate mobile filter metadata/state, and remove stale criteria when a column becomes unavailable.
- Bind global paging defaults from typed `OpxFlatUi:Grid` appsettings and construct `GridViewState` from `FlatGridOptions` before initial loading. Keep page-specific page size and pager choices as explicit overrides.
- Use `FlatEditableGrid<TItem>` for inline Add/Edit/Delete. Keep one cloned draft and prefer `SaveRow` with `FlatGridEditResult<TItem>` so generated IDs/version values return as the canonical persisted row. Emit `RowResult` for every Create/Update/Delete success, failure, validation failure, and cancellation with the exact affected row. Retain failed operations in edit mode, discard Cancel without source mutation, and confirm Delete explicitly. Standard pages use `FlatPage.PrimaryAction*`; the grid Add toolbar is only for embedded grids. Switch to equivalent editor cards at `900px` and below. Authorization, collection mutation, persistence, concurrency, idempotency, and refresh remain host-owned.
- Keep 16px mobile outer gutters. Use no-FAB bottom 16px or safe-area-aware FAB clearance as defined in root `RULES.md`.
- In phone Bottom navigation, the hidden hamburger must not collapse AppBar content against the viewport; keep the AppBar toolbar at `16px` left/right gutters while preserving the standard 64px header rhythm.
- Use `FlatFormModal`/`CrudEditorShell` for CRUD editors. Mobile editors are fullscreen; cancel/back returns false without refresh, while successful CRUD submit may refresh through the caller pipeline.
- Enable pull-to-refresh only on eligible pages with a real handler. Reuse the shared native-like resistant gesture, pull/release/refresh indicator, held refresh position, and snap-back; do not build page-local variants. Browser simulation is not native MAUI proof.
- Keep Light, Dark/Night, Auto, palette, density, font, disabled state, portal, snackbar, reconnect, and backdrop behavior synchronized with shared settings. Dark component surfaces must use the shared graphite hierarchy and must not reintroduce legacy pure-black component islands. Hosts using `Auto` load the OPX theme bootstrap in `<head>` before stylesheets so first paint already matches the device and remains subscribed to later system-theme changes.
- Keep the built-in `blue` palette's enabled Filled Primary surface at reference `#004a77` in Light and Dark/Night, with white content and palette-derived hover/subtle/emphasis states. Change it through typed host palette configuration, never a page-local button selector.
- Use `14.5px` as the OPX base-font baseline through `OpxFlatUi:Display:DefaultFontSizePx`; retain host bounds and persisted user overrides until Restore application defaults clears them.
- Scale all shell, navigation, page, grid, dialog, menu, Settings, and reusable-component text from `--opx-ui-font-size`. Keep icons and density-owned spacing/control geometry independent so Font size never changes the selected spacing preset.
- Keep first-paint root classes (`opx-root-theme-light`/`opx-root-theme-dark`) separate from component shell classes (`theme-light`/`theme-dark`). Auto follows the device as one coherent resolved theme; explicit Light or Dark overrides the device for root background, shell, cards, controls, and portals together.
- Keep default enabled checkboxes accent-colored when checked/indeterminate, readable when unchecked, and paired with normal foreground labels. Disabled checkbox glyphs and labels use a clearly quieter neutral in both themes; checkbox icon surfaces remain transparent/shadowless and explicit semantic checkbox colors remain intact.
- Configure sidebar menu Light/Dark background and foreground through typed `OpxFlatUi:Display` options and shared shell variables. Validate six-digit hex input, retain safe defaults, and preserve semantic hover/active contrast.
- Keep the sidebar search placeholder compact and regular (`9-10px`, weight `400`) through a selector scoped to `.sidebar-search-input`; do not let the larger form-placeholder rule enlarge or bold it.
- Keep native placeholders, empty/non-floating labels, floating labels, entered textbox/textarea values, and selected combo values at normal `400` weight. Preserve their responsive size, color, dense height, gap, outline, and label geometry.
- Make each outlined field container own one continuous theme-resolved background across the value and adornment areas, including autofill. Keep adornment wrappers, glyphs, and icon buttons transparent, borderless, and shadowless over that surface; ordinary icon buttons retain their component-specific surfaces and interaction states.
- Apply `opx-password-visibility-field` to Login/auth password controls with show/hide. Keep the visibility icon white in resolved Dark/Night and `#212529` in resolved Light regardless of the current password/text input type; retain a transparent icon surface and accessible toggle semantics.
- Keep browser-autofilled inputs, textareas, and selects on the same resolved field surface, foreground, and caret colors as ordinary values in Light, Dark/Night, and Auto. Enforce both standard `:autofill` and Chromium `:-webkit-autofill` globally for hover/focus/active states; do not patch Login alone or let autofill create a separate block beside an adornment. Preserve field geometry, labels, outlines, and disabled behavior.
- Treat application metadata and authentication branding as mandatory initial host setup. Before implementing feature pages, bind typed `OpxFlatUi:Application` options and seed appsettings with `AppName`, `CompanyName`, `Author` (default `opx`), copyright, `LoginBrandBackgroundColor`, `LoginBrandBackgroundImageUrl`, `LoginBrandOverlayColor`, and `LoginBrandOverlayOpacity`. Render the resolved author once in the host document `<head>` as `<meta name="author">`; it applies to every route and must not be duplicated page by page. Keep `Logo` and `LogoUrl` optional: when neither resolves, omit every logo wrapper and its spacing; when configured, validate the URL and keep the mark compact. Render the validated brand-panel color/image/overlay from host configuration. Use the operational split desktop/mobile Login pattern, omit the duplicate top mobile identity row, and disable inputs during a single-flight submit. Do not inject raw CSS from configuration or copy the reference application's API/session contracts into the reusable sample.
- Do not add a static security/integration or `Sample only` banner below Login. Route required-field and invalid-credential feedback through `FlatMessageBoxService.ErrorAsync` using generic wording. Keep sample credentials explicit and local-only; the host owns real authentication/session behavior.
- Give Not Found content standard page gutters and resolve unknown routes to the AppBar PageTitle `Not found`.
- Derive nested sidebar typography and geometry from tree depth rather than expanded/collapse transition classes. Font size, icon size, row height, and text position must remain identical before and after first click.
- Use `FlatNavigationBadge` for compact sidebar counts/statuses on leaf links or `MudNavGroup.TitleContent`. Preserve the group's plain `Title` for `aria-label`; dot-only badges require a meaningful `AccessibleLabel`. Badge appearance must follow semantic Light/Dark tokens and may not shift sidebar icon/text/connector/chevron geometry.
- Scope Email sender-copy selectors to `.flat-email-sender-copy`; never let a broad direct-`span` rule override the span root of `FlatProfileAvatar`. Verify initials remain centered and fully visible at desktop/mobile widths.
- AI chat pages compose the shared Chat shell/components and keep prompts, history, model/provider, streaming, persistence, and authorization host-owned. Use a bounded desktop history/thread split and separate mobile history/thread states at `900px` and below; Back returns to history. Keep sending single-flight with responding/Stop states and clearly identify static responses as local simulation. Never expose provider keys or privileged tokens in Razor, browser storage, query strings, logs, or client configuration.

## Chart samples

- Keep the `/charts` showroom aligned with every `ChartType` in the pinned MudBlazor dependency. Render real `MudChart` instances, provide expandable copy-ready Razor for each data contract, and keep chart/code overflow internal at desktop/mobile widths and in Light/Dark themes.

## Roadmap components

- Tree Grid hierarchy is host-owned: use typed key/parent selectors, reject cycles, return old/new parent keys from move callbacks, and provide touch-accessible promote/indent actions in addition to Web drag/drop.
- Mobile Tree Grid uses a Windows Explorer-style continuous list with folder/file icons, chevrons, bounded indentation, dotted branch connectors, secondary metadata, pressed feedback, and a three-dot action menu. It must not reuse desktop columns, drag affordances, or large standalone cards.

- Run unit, bUnit, public API, responsive Playwright, and axe gates before accepting additive public APIs.
- Keep `FlatFileUpload` transport/storage/security and native picker adapters host-owned.
- Keep report query, authorization, subtotal business rules, PDF/Excel generation, scheduling, storage, and delivery host-owned. `FlatOperationalReportViewer<TItem>` owns only responsive presentation and interaction callbacks.
- Build pivot pages with `FlatPivotGrid<TItem>` and typed row/column/value selectors. Keep aggregation scope explicit, return exact source items on cell selection, use one internal desktop matrix scroller, and switch to equivalent cards at `900px` and below. Derive matrix and card typography from compact `--opx-ui-font-size` ratios, and reduce those ratios again at the phone breakpoint instead of inheriting full body text or using fixed pixels. Server aggregation, authorization, units, export, persistence, and OLAP remain host-owned.
- Keep saved grid views scoped per user through `IFlatGridPreferenceProvider`; normalize state by schema and load virtual windows through cancellation-aware host callbacks.
- Keep wide showcase controls contained within their panel with internal overflow instead of cross-card overlap.

## Configuration and state

- Put reusable defaults in typed options bound from `OpxFlatUi` appsettings sections. Normalize unsafe or out-of-range values in the library.
- Keep `opx-flat-ui.js` canonical and readable. Generate, never hand-edit, `opx-flat-ui.min.js` during Release/Pack with the pinned build-time toolchain. Debug loads source; Release resolves source/minified through typed `OpxFlatUi:Assets` settings, defaulting to minified. Validate both assets inside the NuGet package.
- Keep user-specific preferences/session state scoped. Never use static/singleton mutable state shared between users.
- Keep sample data explicitly static/in-memory unless a real integration is implemented and verified.
- Preserve query state during refresh. Do not hard-reload a page after a successful CRUD operation; use the existing load pipeline.

## Roadmap and compatibility

- Follow `ROADMAP.md` in order: automated test foundation, FlatFileUpload, then advanced grid preferences.
- Do not add the phase 2/3 public component APIs before unit, bUnit, responsive Playwright, accessibility, and public API compatibility baselines exist for current behavior.
- Target the additive feature set as `1.1.0`, not `1.0.17`; roadmap documentation alone never authorizes a source-version bump or package publication.
- Keep native file picking, upload/storage/security, saved-view persistence, and virtualized data loading host-owned through explicit contracts.

## Required synchronization

For every accepted reusable change, update together:

- implementation under `src` and/or composition under `samples`;
- root `RULES.md`;
- relevant `docs`/`README.md`;
- `.agents` rules, source map, or local skill when the development contract changes;
- global `opx-flat-ui-rules` skill when available in the working environment.

## Validation

- Run `.agents/skills/opx-flat-ui-development/scripts/audit_flat_ui_repo.ps1`.
- Build the sample project in Release.
- Verify recursive Release/package PDB count is zero.
- Run `git diff --check`.
- For UI changes, verify the affected interaction and representative desktop/mobile computed geometry in a browser when available.
- For native MAUI behavior, require emulator/device evidence.
