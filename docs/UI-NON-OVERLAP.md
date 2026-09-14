# UI composition: spacing and non-overlap

Applies whenever adding or changing any UI element: label, helper/error text, icon, input, button, badge, toolbar, panel, widget or nested component.

## Required composition checks

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

> Import scope (2.1.31): upstream documentation from `D:\projects\git\mudblazor-flat-ui` at `e7c743d`. New showcase pages, preview launchers, host registrations and upstream test results described here are not automatically installed or certified in this consumer by a package/rules upgrade. Follow the local source map before invoking a route or script.
