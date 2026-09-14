# Composable display settings

## Input rhythm and sidebar scrolling

Standard reserves 16px above the input for its floating caption (reduced from 22px); the empty-label position uses the same reservation. This closes the caption/value gap without changing inter-field gaps, input padding, or intrinsic textarea height.

Filled fields use their filled surface instead of an idle underline, including the select adornment. The existing focus/error indicator remains; Standard underlines and Outlined borders are unchanged.

Shared `.flat-crud-form-grid` uses a 12px gap, reduced to 10px at 600px and below. Fields align at the start; nested select wrappers do not duplicate the input top margin. Helper/error containers share a 4px top gap and 10px horizontal inset, with wrapping text. Filled, Standard and Outlined retain their intrinsic variant and multiline heights; no equal-height constraint is applied.

Preview all three variants with synthetic helper/error examples at `/crud-simple?preview=input-rhythm`. The ordinary route remains unchanged.

Sidebar `.drawer-scroll` keeps native overflow scrolling inside `.drawer-scroll-frame`. A progressively enhanced overlay thumb follows the native scroll position, appears on hover/focus/scroll and fades after 750ms idle outside the sidebar. Mouse thumb dragging updates native scrollTop; wheel, touch and keyboard are not intercepted. Brand/footer stay outside the scroll region. Resize/content changes recalculate geometry; removed frames release observers and timers. Without the enhancement script, native thin scrollbars remain, and forced-colors restores native rendering. No SimpleBar dependency is introduced.

In edge-to-edge MAUI, Settings overlays use `--opx-native-statusbar-height` and `--opx-native-navigationbar-height` under `html.opx-native-transparent-statusbar`. The panel fits the inset-adjusted overlay instead of a raw `100dvh`; header/footer remain visible and only the body scrolls. Landscape keeps bounded desktop-style margins. Hosts without the native marker retain existing Web geometry. See `tests/responsive/settings-safe-area.spec.ts` for simulated-inset regression; native validation is separate.

2026-09-09 verification: 3 browser projects passed inset/resize/Web-restoration tests, 297 .NET tests passed, Android Release built with zero warnings/errors, and repository audit passed 66 pages. Pixel 7 API36 portrait screenshots confirm native Settings header/footer clearance before and after touch-scrolling to Local notification. Evidence: `artifacts/settings-safe-area-20260909/settings-fixed.png` and `settings-scrolled.png`; installed/copied APK SHA256 `BD53C7E706A5E23E4A449EFBEC6B909B39D12BF85A1A132FEED3C8CC5C144E3E`. Native landscape/Windows were not retested; landscape coverage here is browser-simulated insets. No NuGet publication.

FAB shape is independent of ordinary button rounding: `OpxFlatUi:Display:DefaultFabShape` defaults to `Circle`; `Square` stays at zero radius, and Extended Circle is pill-shaped. `FlatFab.Shape` remains the local override. The global flat reset keeps exclusions specificity-neutral so spinner exceptions cannot flatten a configured Circle FAB or semantic avatar. Regression coverage: `tests/responsive/fab-shape.spec.ts` (themes, shells, shape variants and live resize), plus CRUD pager tests.

The theme bootstrap also restores saved font mode, bounded font size, and density before styles/Blazor first paint. Host HTML can seed `data-opx-use-app-font-size`, `data-opx-font-size`, `data-opx-minimum-font-size`, `data-opx-maximum-font-size`, and `data-opx-density`; keep these aligned with Display options. Device mode remains `1rem`. Theme changes and reconnect shell mounting must not reset typography. Native static HTML hosts must seed matching defaults if their appsettings differ from 16px/manual-off and 12–18 bounds.

`FlatMudProviders` resolves a directly registered `FlatUiDisplayOptions` instance first (the canonical Web/MAUI registration), then `IOptions<FlatUiDisplayOptions>`, then defaults. Direct registration deliberately wins when both exist, including when `AddOptions` supplies an implicit default wrapper. No consumer DI bridge is required.

Panel headers use global `OpxFlatUi:Display:PanelHeaderMinHeight` (default 48px, clamped to 0–240) and `PanelHeaderPaddingY` (default 10px, clamped to 0–64). `FlatMudProviders` applies these settings as CSS variables; headers retain intrinsic height for subtitles/actions. Horizontal padding is unchanged. These are host configuration, not persisted user preferences or AppBar settings.

```json
{ "OpxFlatUi": { "Display": { "PanelHeaderMinHeight": 48, "PanelHeaderPaddingY": 10 } } }
```

Theme, Density, and Input Style headings and helper text align with their options using 16px horizontal padding, or 14px at widths of 520px and below. Sections with parent-owned padding do not receive another inset.

Copyright (c) 2026 opx. All rights reserved.

`FlatDisplaySettings` remains backward compatible: when `Configuration` is not supplied it renders the existing complete settings surface in its established order. Hosts may opt into a smaller, localized, or reordered surface through `FlatDisplaySettingsConfiguration` without duplicating package markup.

## Indonesian essentials preset

Use the built-in preset when a host needs only Tema, Palet warna, Ukuran font, and Target sentuh in Bahasa Indonesia:

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

The preset orders sections as `Theme`, `ColorPalette`, `FontSize`, then `Density`. Navigation, sidebar colors, input style, backdrop opacity, and rounded corners are not rendered.

## Select, reorder, lock, and replace sections

- Set `Sections` to the exact ordered list that should appear.
- Put sections in `LockedSections` to display the host value while disabling user changes. For example, keep `RoundedSizePx="7"` and lock `RoundedCorners`.
- Set `Text` to `FlatDisplaySettingsText.Indonesian`, `English`, or a host-created immutable text record.
- Set `ShowSectionHeadings=true` when each selected section needs a visible localized heading.
- Supply `SectionTemplates` to replace only selected section bodies with host-owned `RenderFragment` content while retaining deterministic section order.

The component emits normalized change intents only. The host continues to own the modal, draft/live preview, Save, Cancel, Restore defaults, persistence, authorization, and policy. A locked UI value is presentation policy, not server-side authorization.
# Filled field spacing

Standard underline is painted as a one-pixel bottom border on the complete `mud-input-text.mud-input-underline` root, with legacy pseudo-lines disabled to avoid partial/hidden lines behind slots. Idle color mixes 65% foreground with surface; focus uses accent, disabled is quieter, and error keeps its semantic color. Honor `DisableUnderLine` by requiring the underline class. Light CRUD Simple idle and focused previews verified; no change to Filled/Outlined borders.

Historical note (superseded by the 16px reservation above): Standard inputs used transparent underline-only surfaces, 10px inline text/caption inset and 22px top reservation for labeled fields. Empty labels follow the value baseline; populated/focused captions remain above it. These rules are variant-scoped so Filled and Outlined retain their own geometry. Dense row spacing must reserve the full Standard caption rather than placing it against the value surface.

Filled MudBlazor fields retain their variant-owned asymmetric label/value padding. The shared Dense control-height rule excludes `mud-input-root-filled`; never apply centered equal vertical padding to a labeled Filled input or select. Placeholder-like empty-label overrides are scoped to Outlined only. Preserve multiline sizing and native label transitions. Verified in the live CRUD Simple create dialog with populated Code/Category/Status, empty Name and multiline Notes; this is Web preview evidence, not native certification.

> Import scope (2.1.31): upstream documentation from `D:\projects\git\mudblazor-flat-ui` at `e7c743d`. New showcase pages, preview launchers, host registrations and upstream test results described here are not automatically installed or certified in this consumer by a package/rules upgrade. Follow the local source map before invoking a route or script.
