# Dashboard readiness P0–P2

The shared `/?preview=dashboard-readiness` composition extends `opx.page.dashboard.overview`. No package publish is implied.

## P0 — spacing and preview gate

`OpxFlatUi:Display` now accepts PagePadding / MobilePagePadding (16/16), PanelBodyPadding / MobilePanelBodyPadding (16/14), WidgetGap / MobileWidgetGap (16/12). Integer px values clamp to 0–48. Mobile uses <=900px; these host defaults are not per-user display preferences. FlatMudProviders resolves direct options before IOptions, emitting responsive --opx-page-padding, --opx-panel-body-padding and --opx-widget-gap.

PagePadding owns the page's inline gutters only, never safe-area or bottom-navigation clearance. PanelBodyPadding applies to FlatWidget body, opt-in .flat-panel-body, Portfolio and Profile Settings body. It does not blanket-pad edge-to-edge FlatPanel grids or alter input geometry. WidgetGap applies to Home's stack and Dashboard Composer. ContentOwnsPadding on FlatWidget removes the loaded wrapper inset when its child already owns padding; loading/error/empty and freshness keep their own inset. Component-specific geometry remains explicit.

Before delivering any preview, run `scripts/test-preview-assets.ps1 -Url http://127.0.0.1:PORT/`. It checks CSS MIME and recursive imports, fails on HTTP errors/external imports, and accepts loopback only. Multiple dotnet previews share generated intermediates: rebuild/restart the matching listener after changes, or use one current preview for all routes. OutputPath alone does not isolate obj/scopedcss. Do not add padding to disguise missing styles. The gate detects stale assets; it does not repair or monitor hosts automatically.

## P1 — widget states and intents

FlatWidget supports Loading, Empty, ErrorText, explicit Retry callback, UpdatedText and Stale with configurable labels. Loading takes precedence, then error, then empty; non-ready states suppress ChildContent. Retry is single-flight and shown only with a callback. The host chooses timestamps, stale policy and safe error messages, and owns loading/cancellation. No timer or query is added.

FlatMetricStrip.ItemSelected returns the exact host metric. Portfolio arcs and names return ItemSelected; SVG arcs are focusable with Enter/Space and expose name/value/percentage, plus a title for pointer hover. Selection shows an inline accessible value/percentage for touch (no hover dependency). ChangeText is host-formatted, and existing HeaderActions hosts the period selector. The sample's period changes synthetic comparison text only, not a market query. No navigation, financial action or authorization is inferred.

## P2 — layout and print

FlatDashboardComposer adds show/hide checkboxes and keyed articles; movement operates over visible widgets, hidden widgets remain restorable. Duplicate keys are rejected and ColumnSpan clamps to 1–3. WidgetsChanged and Reset retain host ownership. Use the existing IFlatDashboardLayoutProvider with an authenticated per-user/tenant scope; filter saved keys against today's authorized catalog, never trust saved titles/permissions. The sample provider is scoped in-memory, not durable per-account storage. Save failures retain the last accepted layout with retry guidance.

Print CSS hides customization/retry controls but retains metric values and holding names. This is browser print layout, not PDF generation or native printer support. Exact native print/device/IME behavior requires separate testing.

> Import scope (2.1.31): upstream documentation from `D:\projects\git\mudblazor-flat-ui` at `e7c743d`. New showcase pages, preview launchers, host registrations and upstream test results described here are not automatically installed or certified in this consumer by a package/rules upgrade. Follow the local source map before invoking a route or script.
