# Widgets

Copyright (c) 2026 opx. All rights reserved.

The `/widgets` showroom is the canonical visual archetype for PageId `opx.page.reference.widgets`. Consumer values and status are host-owned; the package owns widget structure, theme behavior, responsive composition, and spacing.

## Reusable components

- `FlatWidget`: domain-neutral shell with optional eyebrow, title, header actions, body, and footer fragments.
- `FlatMetricWidget`: KPI/value tile with semantic icon, caption, and optional positive or negative change.
- `FlatActionMetricWidget`: actionable tile box with value, trend, semantic icon, and host-owned action callback.
- `FlatCompactMetric`: compact strip metric for dense dashboard summaries.
- `FlatProgressWidget`: bounded 0-100 progress summary with native progressbar semantics.
- `FlatSegmentProgressWidget`: project/status distribution with completed, in-progress, and to-do segments.
- `FlatActivityItem` and `FlatTaskItem`: compact schedule/task rows with host-owned state.

## Canonical spacing

Spacing is container-owned and follows the package CSS shipped by `Opx.MudBlazor.FlatUi` `2.1.3`:

| Surface | Desktop | Mobile at `600px` and below |
| --- | ---: | ---: |
| Gap between widgets in `.flat-widget-grid` | `12px` | `10px` |
| Individual widget outer margin | `0` | `0` |
| `.flat-widget-body` padding | `12px` | `12px` |
| Header padding, block / inline | `9px / 12px` | `9px / 12px` |
| Footer padding, block / inline | `8px / 12px` | `8px / 12px` |
| Gap between showcase sections | `18px` | `16px` |
| Section heading bottom margin | `8px` | `8px` |
| Action metric padding | `13px` | `12px` |
| Compact metric padding | `13px` | `13px` |
| Lower widget-grid top margin | `12px` | `10px` |

Do not add `margin` to each widget to create grid spacing. Use the parent grid's `gap`, otherwise adjacent margins, responsive stacking, and nested widgets produce double or inconsistent whitespace. Do not apply both parent padding and widget padding to the same visual boundary. A deliberate consumer exception must be scoped to a new named composition and documented; it must not override `.flat-widget`, `.flat-widget-grid`, or the shared widget component classes globally.

At desktop widths the showroom uses four/five/three-column arrangements, reduces on tablet, and stacks to one column below `600px` without page-level horizontal scrolling. Font-size preferences scale text only; density may change control rhythm but must not silently mutate this widget-spacing contract.
