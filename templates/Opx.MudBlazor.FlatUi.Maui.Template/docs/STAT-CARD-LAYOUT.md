# FlatStatCard layout

Copyright (c) 2026 opx. All rights reserved.

`Layout=FlatStatCardLayout.Default` preserves existing label/value plus trailing-icon presentation. Opt into `Horizontal` for a leading icon and value above label. No second reusable card is introduced. Unknown enum values fall back to Default.

```razor
<FlatStatCard Layout="FlatStatCardLayout.Horizontal"
              Label="Employees" Value="149"
              Icon="@Icons.Material.Outlined.People" Tone="green" />
```

Values and labels are host-owned, formatted strings; no counting, currency, trend or business logic is inferred. Parent grid controls column count. Horizontal mode keeps intrinsic height, wraps long text, and uses logical grid positioning for direction support. Optional Note/NoteContent spans below both columns. When ProgressPercent is finite the existing meter replaces the leading icon, without forcing it to fit icon height; decorations and default progress behavior remain unchanged.

Canonical sample: `/?preview=horizontal-stats`, PageId `opx.page.dashboard.overview`, shared HorizontalStatPreview. Browser preview is not native MAUI certification.

> Import scope (2.1.31): upstream documentation from `D:\projects\git\mudblazor-flat-ui` at `e7c743d`. New showcase pages, preview launchers, host registrations and upstream test results described here are not automatically installed or certified in this consumer by a package/rules upgrade. Follow the local source map before invoking a route or script.
