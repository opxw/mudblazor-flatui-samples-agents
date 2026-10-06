# UI composition: spacing and non-overlap

> Imported guidance 2026-10-06 from upstream working tree based on a0742d4. Sample wiring and regression scripts described below are upstream references, not local additions or executed consumer/native tests. See the local upstream-2.1.46.md skill reference for scope.

Applies whenever adding or changing any UI element: label, helper/error text, icon, input, button, badge, toolbar, panel, widget or nested component.

The `FlatPanel.Footer` API and shared footer inset are packaged starting with 2.1.32. Earlier artifacts, including 2.1.31, do not contain this addition. Upgrade package DLL and static assets together before using the new slot.

## Required composition checks

- At <=900px, when a page with a table footer places its FAB in normal flow, use16px bottom padding instead of the floating-FAB88px reserve. Add bottom safe area only when Bottom navigation does not already own that clearance. Floating FABs and desktop retain their existing rules.

- Full-height desktop modules are conditional: if content follows the page or follows its panel, use natural bounded panel height instead. Hidden nodes, scripts/styles, fixed editor overlays and FAB hosts do not count. The showroom Sample code disclosure is real following content; regression tests temporarily hide it only to exercise the final-grid composition.

- Desktop (>900px) direct module pages inside `.monitor-main` use the remaining viewport height: 60px AppBar or104px horizontal shell, native insets once, and16px bottom gutter. The page is flex-column; actions/BeforePanel retain intrinsic height and `.module-panel` fills the remainder. Keep toolbar/footer outside the data scroller. Do not use88vh to size these module panels. Mobile and non-module/custom panels retain their existing contracts. Run scripts/test-desktop-grid-height.mjs against the current source preview.

- Desktop horizontal navigation joins the 60px AppBar without a gap and shares its surface. The AppBar owns one subtle 1px accent-tinted separator; menu height remains 44px and main/refresh clearance 104px. Native measured insets are applied once by the existing safe-area rules. Verify `scripts/test-horizontal-appbar-seam.mjs` and `scripts/test-package-safe-area.mjs`; this does not certify a native device or update an existing consumer artifact.

- Panel/table summary notes belong in `FlatPanel.Footer` or existing `FlatWidget.Footer`. Their global inset follows Display.PanelBodyPadding / MobilePanelBodyPadding (16/14 defaults), independently of edge-to-edge body content. Footer paragraphs have no extra first/last block margins and long text wraps. For a custom composition use `.flat-content-note` on an explicit note wrapper; do not style all paragraphs or table cells globally. An omitted footer renders no reserved space. Outer separation remains the parent WidgetGap, not footer margin. Existing bare text nodes must be moved into the slot/wrapper; the package cannot infer their semantic role.

- Inspect the actual parent and neighboring elements above, below and on both sides. Reserve space for labels, floating labels, captions, helper/error messages and actions in all relevant states.
- Give spacing one owner: parent gap or deliberate child margin. Use internal padding for readable content, not as a substitute for external separation. Avoid doubled spacing. Preserve documented edge-to-edge groups, such as cells inside a metric strip; separate that group from adjacent widgets.
- Reuse existing OPX tokens and component geometry. The dashboard uses 16px desktop / 12px mobile between blocks and 8px caption spacing; do not impose those numbers universally on fields, menus or other archetypes.
- Allow content-driven heights and wrapping. Use shrinkable grid/flex tracks (for example minmax(0,1fr) and min-width:0) where appropriate. Do not force unrelated controls to equal heights or hide overflow merely to conceal collisions.
- Keep parent/child padding, long text, localized copy, error/helper messages, conditional actions and dynamic data in the test cases. A hidden action must not leave an unintended reserved block; a newly visible action must not cover existing content.
- Preserve normal flow and native scrolling. Fixed/sticky toolbars, footers, pagers and overlays must reserve the necessary content/safe-area clearance. Scope artwork/image CSS so it cannot resize control icons or avatars.
- Intentional overlap (badge, overlay, floating label) is allowed only as a documented component behavior with deliberate layering and reserved space. It must not obscure readable text, required controls, focus indicators or touch targets.

## Acceptance evidence

- Inspect the affected composition in the current built preview, including the element immediately above and below it. Verify the URL/build is current rather than a stale preview process.
- Check desktop, tablet and phone composition at the relevant OPX breakpoints, live resize, and Light/Dark. Include text scaling, RTL/localization and real keyboard/safe-area cases where the change can affect them.
- Measure actual bounding boxes, computed gaps and horizontal overflow in addition to taking screenshots. Distinguish intended nested rectangles from unintended overlap; do not blindly flag all intersecting boxes.
- Check enabled/disabled, empty/populated, long/wrapped text, helper/error, expanded/collapsed and focus states as applicable. Verify controls remain clickable, keyboard-accessible and touch-reachable.
- Build/test success alone is not visual proof. Before declaring the UI complete, show a current screenshot and report what was measured; explicitly identify blocked or untested viewport/theme/native cases. Do not claim all-page or native certification from one browser screenshot.

Fix at the correct ownership boundary: reusable component defects belong in the package; page composition spacing belongs in the canonical shared sample/layout. Do not add consumer overrides to hide a package defect.
