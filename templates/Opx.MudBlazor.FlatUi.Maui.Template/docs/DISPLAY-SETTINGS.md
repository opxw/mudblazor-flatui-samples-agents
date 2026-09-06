# Composable display settings

Copyright (c) 2026 opx. All rights reserved.

The package theme bootstrap restores saved Device/Manual font mode, bounded font size, and density before styles and Blazor first paint. Web hosts seed `data-opx-use-app-font-size`, `data-opx-font-size`, `data-opx-minimum-font-size`, `data-opx-maximum-font-size`, and `data-opx-density` from `FlatUiDisplayOptions`; static MAUI HTML must seed values matching its appsettings defaults. Device mode remains `1rem`, and later theme or reconnect synchronization must not reset typography.

Panel headers use global `OpxFlatUi:Display:PanelHeaderMinHeight` (default `48px`, clamped to `0-240`) and `PanelHeaderPaddingY` (default `10px`, clamped to `0-64`). `FlatMudProviders` applies both package tokens as CSS variables. Headers keep intrinsic growth for subtitles and actions; horizontal padding is unchanged. These values are host configuration, not persisted user preferences.

```json
{ "OpxFlatUi": { "Display": { "PanelHeaderMinHeight": 48, "PanelHeaderPaddingY": 10 } } }
```

Theme, Density, and Input Style headings/helper text align with their option controls using a package-owned `16px` horizontal inset, reduced to `14px` at `520px` and below. Do not double-pad sections whose parent already owns spacing and do not reproduce this behavior in consumer CSS.

`FlatDisplaySettings` remains backward compatible: when `Configuration` is omitted it renders the complete Settings surface in its established order. Consumers may opt into a smaller, localized, or reordered surface through package-owned `FlatDisplaySettingsConfiguration` without copying component markup or CSS.

## Indonesian essentials preset

Use `FlatDisplaySettingsConfiguration.IndonesianEssentials` when a host needs only Tema, Palet warna, Ukuran font, and Target sentuh in Bahasa Indonesia. The preset orders sections as `Theme`, `ColorPalette`, `FontSize`, then `Density`; navigation, sidebar colors, input style, backdrop opacity, and rounded corners are not rendered.

```razor
<FlatDisplaySettings Configuration="FlatDisplaySettingsConfiguration.IndonesianEssentials"
                     ThemeMode="@ThemeMode"
                     ThemeModeChanged="SetThemeAsync"
                     ColorPalettes="@Palettes"
                     ColorPalette="@ColorPalette"
                     ColorPaletteChanged="SetPaletteAsync"
                     UseAppFontSize="@UseAppFontSize"
                     UseAppFontSizeChanged="SetFontModeAsync"
                     FontSizePx="@FontSizePx"
                     FontSizePxChanged="SetFontSizeAsync"
                     Density="@Density"
                     DensityChanged="SetDensityAsync" />
```

## Composition contract

- `Sections` is the exact visible order.
- `LockedSections` displays host values while suppressing component change intents.
- `Text` accepts `FlatDisplaySettingsText.Indonesian`, `English`, or host-supplied immutable copy.
- `ShowSectionHeadings=true` shows localized headings.
- `SectionTemplates` replaces only explicitly selected section bodies.

The component emits normalized change intents only. The host owns the modal, draft/live preview, Save, Cancel, Restore defaults, persistence, authorization, and policy. A locked UI value is presentation policy, not server-side authorization.
