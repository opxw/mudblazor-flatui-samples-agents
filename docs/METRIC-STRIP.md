# FlatMetricStrip

> Import scope (2.1.33): guidance from the upstream working tree. Referenced new preview content and upstream tests are not automatically copied or rerun in this consumer; inspect the local source map. Package API availability is verified separately from browser/native/backend behavior.

Copyright (c) 2026 opx. All rights reserved.

Read-only metric summary, five columns above 900px, three at 601–900px and one at 600px or below. Intrinsic rows wrap long labels/values; logical borders support direction changes. No chart, animation, data fetching, calculation or persistence is implied.

```razor
<FlatMetricStrip Items="Metrics" AccessibleLabel="Monthly results" />
@code {
    private FlatMetricItem[] Metrics = [
        new("cost", "Operating cost", "$12.4k", Trend: FlatMetricTrend.Down,
            TrendText: "Cost decreased versus last month", IsFavorable: true)
    ];
}
```

Keys must be nonempty and unique. Host owns formatting, localization, reporting period, comparison and trend semantics. `None` hides the trend; `IsFavorable=null` is neutral. Direction does not infer favorability. Supply localized `TrendText`; the fallback describes direction/favorability in English. Optional Material `Icon` is decorative. Empty Items renders an empty list, not invented zero metrics. Replace Items when data changes. No click action is implied.

Canonical preview: `/?preview=metric-strip`, PageId `opx.page.dashboard.overview`.

## Compact five-column mode

`Compact="true"` opts into smaller labels/values and five columns at every viewport width. Default false preserves the existing5/3/1 responsive layout. Use five short host-formatted values for one row; additional items continue onto another five-column row. Labels wrap without clipping, typography still scales with the host font setting, logical borders support RTL, and interactive values retain their44px minimum touch height. Units remain host-owned; use a numeric-only Value and an AccessibleLabel that states the unit when desired. This is package-owned CSS, not a consumer override.
