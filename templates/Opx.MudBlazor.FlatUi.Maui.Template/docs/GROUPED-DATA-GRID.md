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

Set `AlwaysShowScrollbars="true"` only when operators need persistent horizontal and vertical tracks. It changes the package-owned desktop viewport from `overflow:auto` to `overflow:scroll` and reserves a stable gutter. The default remains `false`. Operating-system overlay-scrollbar preferences may still control thumb visibility.

The ERP Work Orders source sample is the canonical composition: fixed `WidthPx` detail columns, `WordWrap` on Description, `AutoRowHeight`, vertical and horizontal separators, a sticky header, sample-local `8px 12px` detail padding, and one package-owned scroller.

Responsive behavior remains:

- Above `900px`: bounded table with one internal two-axis scroller.
- `601-900px`: two-column grouped cards.
- `600px` and below: one-column grouped cards.
- Live resize preserves keyed expansion state.

Use `FlatPivotGrid<TItem>` for interactive analysis and `FlatOperationalReportViewer<TItem>` for report filters, totals, print, or export workflows.
