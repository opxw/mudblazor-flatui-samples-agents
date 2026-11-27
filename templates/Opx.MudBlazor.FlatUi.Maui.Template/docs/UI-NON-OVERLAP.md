# UI composition: spacing and non-overlap

> Imported guidance 2026-10-06 from upstream working tree based on a0742d4. Sample wiring and regression scripts described below are upstream references, not local additions or executed consumer/native tests. See the local upstream-2.1.46.md skill reference for scope.

Applies whenever adding or changing any UI element: label, helper/error text, icon, input, button, badge, toolbar, panel, widget or nested component.

The `FlatPanel.Footer` API and shared footer inset are packaged starting with 2.1.32. Earlier artifacts, including 2.1.31, do not contain this addition. Upgrade package DLL and static assets together before using the new slot.

## Page and grid edge clearance

- Measure from the usable content boundary after accounting for the shell and fixed UI. Keep equal start/end gutters for regions that share an alignment axis. Standard no-FAB mobile pages use `16px` on all four sides. Use the mapped OPX spacing on desktop and for specialized layouts. Apply each safe-area inset once and leave the last item, pager, and actions reachable above fixed UI.
- Give each boundary one owner. The page sets the outer gutter, the grid sets row and column gaps, and each panel, card, toolbar, or cell sets its internal inset. Align the toolbar, grid, and pager to the same content axis. Use logical padding for RTL and keep child margins from adding to grid gaps. Documented edge-to-edge table or media surfaces still need internal clearance for readable text, controls, and empty/error states.
- Apply this geometry to form, card, and data grids. Use shrinkable tracks, consistent alignment, and content-driven row heights. Use equivalent cards for standard record grids at `900px` and below. Keep wide desktop table overflow inside the grid and leave the toolbar and pager outside its scroll region.

## Standard record grid defaults

- **Sortable.** Enable ascending and descending sorting for data columns with meaningful ordering. Use accessible sortable headers on desktop and a labeled sort control on mobile cards. Show the active field and direction. Selection and row-action columns are exempt.
- **Searchable.** Provide a labeled search input and a way to clear it on desktop and mobile. Search the configured fields across the result set before paging. For server-paged grids, apply search, sort, and filters in the host query before loading each page.
- **Word wrap.** Set `WordWrap=true` explicitly for readable text columns. Allow row height to grow, top-align all cells in wrapping rows, and give mobile card text equivalent wrapping. Check long unbroken values. Keep short atomic values such as amounts and dates intact where needed and preserve access to full values.
- **Filters.** Enable `FilterEnabled` for applicable data columns and use criteria appropriate to the data type. Use desktop column filters or the mapped filter rail and the mobile filter sheet. Share one `GridColumnDefinition` collection and the same committed `GridViewState`. Indicate active filters and let users clear them. Where the sheet stages edits, Apply commits them and dismissing the sheet discards them.
- Preserve committed search, sort, and filter criteria across responsive transitions. Reset to the first page on query changes, drop criteria for disabled or removed columns, and show the same ordered results and totals for the same query. Preserve documented specialized-grid behavior and Exact Sample Mode.


## Required composition checks

- At <=900px, when a page with a table footer places its FAB in normal flow, use16px bottom padding instead of the floating-FAB88px reserve. Add bottom safe area only when Bottom navigation does not already own that clearance. Floating FABs and desktop retain their existing rules.

- Full-height desktop modules are conditional: if content follows the page or follows its panel, use natural bounded panel height instead. Hidden nodes, scripts/styles, fixed editor overlays and FAB hosts do not count. The showroom Sample code disclosure is real following content; regression tests temporarily hide it only to exercise the final-grid composition.

- Desktop (>900px) direct module pages inside `.monitor-main` use the remaining viewport height: 60px AppBar or104px horizontal shell, native insets once, and16px bottom gutter. The page is flex-column; actions/BeforePanel retain intrinsic height and `.module-panel` fills the remainder. Keep toolbar/footer outside the data scroller. Do not use88vh to size these module panels. Mobile and non-module/custom panels retain their existing contracts. Run scripts/test-desktop-grid-height.mjs against the current source preview.

- The full-height selector is structurally direct-child based. Render `FlatPageKind.Module` without a consumer wrapper between `.monitor-main` and `.page-content.module-page`; `display: contents` does not alter DOM ancestry and therefore is not a workaround. The page owns the outer gutters and bottom clearance, so direct filters/results do not repeat side or bottom margins. Use one inter-section gap, keep filter/action height intrinsic, let the direct module panel consume the remainder, and retain responsive/natural flow at `<=900px`.

- Desktop horizontal navigation joins the 60px AppBar without a gap and shares its surface. The AppBar owns one subtle 1px accent-tinted separator; menu height remains 44px and main/refresh clearance 104px. Native measured insets are applied once by the existing safe-area rules. Verify `scripts/test-horizontal-appbar-seam.mjs` and `scripts/test-package-safe-area.mjs`; this does not certify a native device or update an existing consumer artifact.

- Panel/table summary notes belong in `FlatPanel.Footer` or existing `FlatWidget.Footer`. Their global inset follows Display.PanelBodyPadding / MobilePanelBodyPadding (16/14 defaults), independently of edge-to-edge body content. Footer paragraphs have no extra first/last block margins and long text wraps. For a custom composition use `.flat-content-note` on an explicit note wrapper; do not style all paragraphs or table cells globally. An omitted footer renders no reserved space. Outer separation remains the parent WidgetGap, not footer margin. Existing bare text nodes must be moved into the slot/wrapper; the package cannot infer their semantic role.

- Inspect the actual parent and neighboring elements above, below and on both sides. Reserve space for labels, floating labels, captions, helper/error messages and actions in all relevant states.
- Give spacing one owner: parent gap or deliberate child margin. Use internal padding for readable content, not as a substitute for external separation. Avoid doubled spacing. Preserve documented edge-to-edge groups, such as cells inside a metric strip; separate that group from adjacent widgets.
- Reuse existing OPX tokens and component geometry. The dashboard uses 16px desktop / 12px mobile between blocks and 8px caption spacing; do not impose those numbers universally on fields, menus or other archetypes.
- Allow content-driven heights and wrapping. Use shrinkable grid/flex tracks (for example minmax(0,1fr) and min-width:0) where appropriate. Do not force unrelated controls to equal heights or hide overflow merely to conceal collisions.
- Keep parent/child padding, long text, localized copy, error/helper messages, conditional actions and dynamic data in the test cases. A hidden action must not leave an unintended reserved block; a newly visible action must not cover existing content.
- Preserve normal flow and native scrolling. Fixed/sticky toolbars, footers, pagers and overlays must reserve the necessary content/safe-area clearance. Scope artwork/image CSS so it cannot resize control icons or avatars.
- Desktop grid/report pagers remain one non-wrapping row inside the panel: summary at the logical start, an auto spacer, page-size selector, then First/Previous/current/Next/Last controls at the logical end. Use `--opx-type-metadata` at `400` for summary text and leave control typography/geometry package-owned. Verify vertical centering, one footer border/padding owner, no empty block after the footer, and responsive stacking only when a narrow viewport would clip controls.
- Intentional overlap (badge, overlay, floating label) is allowed only as a documented component behavior with deliberate layering and reserved space. It must not obscure readable text, required controls, focus indicators or touch targets.

## Acceptance evidence

- Measure all four clearances, row and column gaps, and toolbar/grid/pager alignment. Include the first and last items and keyboard focus. For a standard record grid, check above, at, and below `900px` and `600px` with long text and the final action reachable. Apply search, sort, and filters on desktop, resize to mobile and verify the same ordered results, then change or clear the criteria on mobile and verify them back on desktop.
- Inspect the affected composition in the current built preview, including the element immediately above and below it. Verify the URL/build is current rather than a stale preview process.
- Check desktop, tablet and phone composition at the relevant OPX breakpoints, live resize, and Light/Dark. Include text scaling, RTL/localization and real keyboard/safe-area cases where the change can affect them.
- Measure actual bounding boxes, computed gaps and horizontal overflow in addition to taking screenshots. Distinguish intended nested rectangles from unintended overlap; do not blindly flag all intersecting boxes.
- Check enabled/disabled, empty/populated, long/wrapped text, helper/error, expanded/collapsed and focus states as applicable. Verify controls remain clickable, keyboard-accessible and touch-reachable.
- Build/test success alone is not visual proof. Before declaring the UI complete, show a current screenshot and report what was measured; explicitly identify blocked or untested viewport/theme/native cases. Do not claim all-page or native certification from one browser screenshot.

Fix at the correct ownership boundary: reusable component defects belong in the package; page composition spacing belongs in the canonical shared sample/layout. Do not add consumer overrides to hide a package defect.

# CRUD/FormModal two-line headings

When a modal header contains both a mode eyebrow and a title, the header owns their vertical geometry. Use explicit line-height, a small grid/flex gap, vertical padding, and a minimum—not fixed—height that fits supported font scaling. Preserve the Back target and title ellipsis; do not compensate from a consumer with internal `.crud-*`/`.mud-*` selectors. Validate long titles on desktop and mobile at the smallest and largest supported font preferences, with the body and footer still independently reachable.
