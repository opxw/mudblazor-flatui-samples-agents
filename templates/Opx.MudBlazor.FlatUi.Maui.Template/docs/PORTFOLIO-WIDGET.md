# FlatPortfolioWidget<TItem>

Copyright (c) 2026 opx. All rights reserved.

Generic composition: donut, host-formatted central total and identity/value list. Canonical preview `/?preview=portfolio-widget`, PageId `opx.page.dashboard.overview`.

Required: `Items`, unique nonempty `ItemKey`, `ItemText`, `ItemWeight`. Optional selectors: `ItemSymbol`, `ItemQuantity`, `ItemValue`, `ItemColor` (six-digit hex only; invalid values use the component palette). Optional `HeaderActions` can host a currency/period selector; the host must replace all matching values and total consistently. `ItemSelected` returns the exact selected item through an accessible button; absent callback leaves a read-only label.

Weights must represent comparable quantities in one common unit, not mixed token balances. Finite positive weights determine visual proportions only. Zero, negative and nonfinite weights remain listed at zero percent, without arcs; all-zero/empty collections show a neutral ring. Scaling before summation avoids overflow. Percentages are rounded for display and may not sum exactly to 100. The textual list provides an equivalent to the decorative SVG, including in forced colors.

`TotalText` is supplied separately, never derived as a financial total. Hosts own valuation, exchange rates, pricing timestamps, formatting/localization, authorization and navigation; selection does not trade or mutate holdings. Avatars retain the package's circular identity default. No animation, remote image loading or wallet integration is added.

> Import scope (2.1.31): upstream documentation from `D:\projects\git\mudblazor-flat-ui` at `e7c743d`. New showcase pages, preview launchers, host registrations and upstream test results described here are not automatically installed or certified in this consumer by a package/rules upgrade. Follow the local source map before invoking a route or script.
