# FlatMetricStrip

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

> Import scope (2.1.31): upstream documentation from `D:\projects\git\mudblazor-flat-ui` at `e7c743d`. New showcase pages, preview launchers, host registrations and upstream test results described here are not automatically installed or certified in this consumer by a package/rules upgrade. Follow the local source map before invoking a route or script.
