# Data-grid Excel export

Copyright (c) 2026 opx. All rights reserved.

`FlatDataGrid<TItem>` can generate a real `.xlsx` workbook from the materialized grid view. Set `ExportVisible="true"`; when `OnExport` is not supplied, the built-in action exports the effective visible column order and each cell's localized `FormattedValue`.

```razor
<FlatDataGrid TItem="OrderRow"
              State="_gridState"
              Columns="_columns"
              Items="_currentPage"
              ExcelExportItems="_filteredAndSortedRows"
              ValueSelector="GridValue"
              ExportVisible="true"
              ExcelFileName="sales-order-view.xlsx"
              ExcelSheetName="Sales orders" />
```

- Omit `ExcelExportItems` to export only `Items`, normally the displayed page.
- Supply `ExcelExportItems` only with rows already materialized in the current filtered/sorted order.
- Hidden and preference-reordered columns follow the rendered grid.
- Values use package localization and formatting; workbook cells are text so untrusted values are not interpreted as formulas.
- `ExcelExported` provides the generated file for host-owned save/share/audit adapters.
- `OnExport` takes precedence for authorization, server/virtualized/unbounded data, background jobs, or native MAUI file placement.

The component never loads an unbounded server dataset. Data access, export authorization, retention, and business audit remain host-owned.
