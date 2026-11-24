# Grouped Data Grid

Copyright (c) 2026 opx. All rights reserved.

`FlatGroupedDataGrid<TItem>` presents host-supplied stable groups and summaries. The host owns querying, grouping, authoritative aggregates, authorization, persistence, export, and business rules.

```razor
<FlatGroupedDataGrid TItem="Product"
                     State="GridState"
                     Columns="Columns"
                     Groups="GroupedProducts"
                     DesktopViewportHeight="min(70vh, 720px)"
                     AlwaysShowScrollbars="true"
                     AutoRowHeight="true"
                     ValueSelector="GridValue" />
```

Set `DesktopViewportHeight` only when the desktop grid needs a bounded viewport. The package applies it to the existing `.flat-data-grid-scroll`; never add a second overflow wrapper or wheel-forwarding handler. Responsive cards retain their normal page scroll.

Set `AlwaysShowScrollbars="true"` only when operators need persistent horizontal and vertical tracks. Starting with signed package `2.2.7`, the component loads a package-owned ES module that renders persistent rails/thumbs above the native scroller. The default remains `false`. The original `.flat-data-grid-scroll` retains native wheel, middle-mouse, touch, keyboard, and position ownership; the visual controls mirror movement and support pointer dragging plus rail paging. At `900px` and below they are hidden. Forced-colors, unavailable JavaScript, or failed module loading retains native fallback. Consumers must not copy the module, selectors, or pointer logic.

Signed package `2.2.8` corrects the `2.2.7` transparent-thumb defect: color tokens now belong to the common grouped-grid shell, the module copies computed colors there during attach, each thumb keeps a theme-aware fallback, and attach reports success only after controls exist. This changes visibility and fallback accuracy only; native scroll ownership and input handling remain unchanged.

The ERP Work Orders source sample is the canonical composition: fixed `WidthPx` detail columns, `WordWrap` on Description, `AutoRowHeight`, vertical and horizontal separators, a sticky header, sample-local `8px 12px` detail padding, and one package-owned scroller.

Responsive behavior remains:

- Above `900px`: bounded table with one internal two-axis scroller.
- `601-900px`: two-column grouped cards.
- `600px` and below: one-column grouped cards.
- Live resize preserves keyed expansion state.

Use `FlatPivotGrid<TItem>` for interactive analysis and `FlatOperationalReportViewer<TItem>` for report filters, totals, print, or export workflows.
