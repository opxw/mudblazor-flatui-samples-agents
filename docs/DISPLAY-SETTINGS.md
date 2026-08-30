# Composable display settings

Copyright (c) 2026 opx. All rights reserved.

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
