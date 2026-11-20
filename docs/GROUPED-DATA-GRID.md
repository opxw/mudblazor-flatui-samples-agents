# Grouped Data Grid

Copyright (c) 2026 opx. All rights reserved.

`FlatGroupedDataGrid<TItem>` presents a flat result set as stable expandable groups. It is intended for operational lists where users need compact grouped detail plus host-supplied Count, Sum, Average, Minimum, Maximum, or other summary facts.

Set `AutoRowHeight="true"` when grouped detail rows contain variable-length text. Non-numeric cells wrap, each row grows to its tallest cell, and neighboring cells align to the first line; the default remains `false` for backward-compatible compact rows.

The component does not calculate authoritative business aggregates. The host queries, groups, validates, and supplies every summary value; OPX handles localization-aware formatting, accessible expand/collapse, row selection, and responsive presentation.

## Usage

```razor
<FlatGroupedDataGrid TItem="Product"
                     State="GridState"
                     Columns="Columns"
                     Groups="GroupedProducts"
                     DesktopViewportHeight="min(70vh, 720px)"
                     AlwaysShowScrollbars="true"
                     GroupHeaderAlignment="FlatGroupedGridHeaderAlignment.Left"
                     ValueSelector="GridValue"
                     GroupToggled="HandleGroupToggled"
                     RowSelected="OpenProduct" />
```

```csharp
var groups = new[]
{
    new FlatGroupedGridGroup<Product>(
        "2025-12",
        "December 2025",
        products,
        [
            new FlatGroupedGridSummary("Products", "Count", products.Count),
            new FlatGroupedGridSummary(
                "Orders",
                "Sum",
                orderTotal,
                FlatGridColumnValueKind.Currency,
                "N2")
        ],
        InitiallyExpanded: true)
};
```

Use stable, unique group keys. `GroupToggled` returns the exact group object and resulting expanded state. `RowSelected` returns the exact item. Sorting and filtering use the same `GridViewState` and `GridColumnDefinition` metadata as `FlatDataGrid`; the host rebuilds the grouped collection from its current query result.

Set `DesktopViewportHeight` when a grouped grid needs a bounded desktop viewport. The package applies the height directly to its existing two-axis data scroller, so the consumer must not add another `overflow` wrapper or a wheel-event forwarding handler. Omit the parameter to preserve parent-driven sizing. Responsive card layouts continue to use their normal page scroll.

Set `AlwaysShowScrollbars="true"` when operators must see both scrollbar tracks without first hovering the grid. The option changes only the package-owned desktop viewport from `overflow:auto` to `overflow:scroll`; its default is `false` for backward compatibility. Operating systems that globally render overlay scrollbars may still control thumb visibility, while the stable gutter remains reserved.

The ERP Work Orders source sample applies this contract to production-order operation details. It combines a bounded desktop viewport with fixed `WidthPx` columns, `WordWrap` on Description, `AutoRowHeight`, vertical and horizontal separators, a sticky header, and sample-local `8px 12px` detail-cell padding. The package scroller remains the only overflow owner.

`GroupHeaderAlignment` accepts `Left` (the default), `Center`, or `Right`. The component enforces both text alignment and the flex/grid content axis, so application-level button styles cannot silently move group labels away from the requested alignment. The same setting applies to desktop and responsive group headers.

## Responsive behavior

- Above `900px`: bounded table with sticky-compatible column headers and one internal two-axis scroller.
- Desktop group headers and ordinary detail rows use a dedicated compact approximately `30px` rhythm instead of inheriting looser general-table or Comfortable-density padding. `AutoRowHeight` remains the explicit escape hatch for wrapped content.
- `601-900px`: grouped sections with two item-card columns.
- `600px` and below: grouped sections with one item-card column.
- Expansion is keyed independently from viewport layout, so live resize does not reset open groups.
- A custom `MobileCardTemplate` may change mobile information hierarchy while retaining the same items and group state.

Numeric and currency columns use `FlatLocalizationOptions`, right alignment, the shared Consolas numeric token, and tabular digits. Summary values use the same formatter. The host remains responsible for complete-dataset aggregation, authorization, paging/query bounds, persistence, export, audit, and business rules.

Use `FlatPivotGrid<TItem>` for interactive analysis and `FlatOperationalReportViewer<TItem>` for report filters, KPI, subtotal/grand-total, print, or export workflows.
