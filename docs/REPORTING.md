# Operational reporting

Copyright (c) 2026 opx. All rights reserved.

`FlatOperationalReportViewer<TItem>` is the reusable result surface for operational, ERP, IT, ecommerce, monitoring, and audit reports. The sample route `/reports` is the composition source of truth.

## Included presentation behavior

- grouped desktop table with optional subtotal and grand-total templates,
- equivalent mobile grouped cards at `900px` and below,
- row drill-down callback,
- loading skeleton, empty state, error/retry state,
- refresh and print actions,
- a three-dot export menu for PDF, Excel, and CSV,
- host-defined toolbar content and extra menu actions.

The component does not query APIs, calculate business totals, generate files, authorize access, schedule reports, persist output, or deliver email/device notifications. The host owns those responsibilities through its query pipeline and callbacks.

## Minimal composition

```razor
<FlatOperationalReportViewer TItem="ReportRow"
                             Items="Rows"
                             GroupKey="row => row.Department"
                             ColumnCount="5"
                             RowSelected="OpenDetail"
                             OnRefresh="LoadAsync"
                             OnPrint="PrintAsync"
                             OnExport="ExportAsync">
    <HeaderTemplate>
        <tr><th>Document</th><th>Status</th><th>Quantity</th><th>Amount</th><th>Reference</th></tr>
    </HeaderTemplate>
    <RowTemplate Context="row">
        <td>@row.Document</td>
        <td>@row.Status</td>
        <td class="flat-report-number">@row.Quantity</td>
        <td class="flat-report-number">@row.Amount.ToString("N0")</td>
        <td>@row.Reference</td>
    </RowTemplate>
    <MobileTemplate Context="row">
        <article>@row.Document · @row.Status</article>
    </MobileTemplate>
</FlatOperationalReportViewer>
```

## Page rules

Release 2.1.29 includes the responsive toolbar and bounded card-scroll/pager correction. Official PackOnly and 355 tests against the exact package passed; fresh consumer Release build passed without warnings/errors. Packaged CSS matches the tested source. That upstream PackOnly artifact was unsigned, contained no PDB, and had not been published at the time of that test. NuGet.org 2.1.29 is now available; its signed package and current consumer validation are recorded separately. SHA256: `92AFD7B5F1E40E8407B9C787D15141F595F09766391ABC8979D14F590840DEC1`. Browser regression evidence remains separate from native/consumer runtime certification.

- In a bounded `.module-panel`, keep `FlatOperationalReportViewer` shrinkable and let its mobile card region own vertical scrolling; put a host pager after the viewer as a non-shrinking sibling. Unbounded viewers retain natural page flow. Mobile toolbar copy/actions share one row, optional toolbar content occupies the next row, and the desktop spacer is hidden.
- Regression: `scripts/test-report-mobile-layout.mjs` checks the live canonical `/reports` component with a synthetic sibling pager and filter slot at phone/tablet/landscape/desktop widths, touch scrolling, final-group reachability and live resize. This is Web evidence, not native or consumer application proof.

- Keep report parameters in a compact panel before KPI and result content.
- Use `FlatPageKind.Module`, automatic initial skeleton, and the AppBar as the only page title.
- Enable pull-to-refresh only when a real query-preserving refresh callback exists.
- Keep export/print generation host-owned and report async job progress truthfully for large output.
- Do not render a desktop table on mobile; provide equivalent grouped cards and open drill-down in the shared fullscreen mobile modal.
- Keep number columns right aligned with tabular figures, group boundaries visible, and subtotal/grand total labels explicit.
- Validate permissions and parameter bounds server-side. UI visibility is not authorization.
