# NuGet 2.2.9 consumer baseline

Copyright (c) 2026 opx. All rights reserved.

- Official package: `Opx.MudBlazor.FlatUi` `2.2.9` from NuGet.org.
- NuGet.org repository signature verification passed on 2026-11-27.
- Nupkg SHA-256: `09E75269DCC5319FE9534EB3991DFBDF23DD43783E11C909C3CABB6A15B5329E`.
- Package metadata records repository commit `f0a5102f5f9c21f45d73e676ce1644cdd49f47ca`.
- DLL SHA-256: `E09530A6F2D4E6A8B5A05EAC9795FCDFCDA6193FB2B427970271690E58A871FA`.
- CSS SHA-256: `184033BB4EBF043465D5064E020DE2DDB21D7AD468FC565C7049A6B271375D8D`.
- Readable JavaScript SHA-256: `F4DBFB7741B03133C8844C5F9370E00106BBDA50BE09C6C00FE5AB646EC1DB0A`.
- Minified JavaScript SHA-256: `41EB96E404B3679352CE450983EF0A8823A0A1C35D791C1C02D76139EFB963A7`.
- Theme bootstrap SHA-256: `F4E7D397584B79AA13E0A362FFFB7A7D3E47C5CAA9FEBDC97F2C694BD2115D82`.
- `grouped-grid-scrollbars.js` is unchanged at SHA-256 `68355696CE6FC902DACCADEB467F3C11B8976CBD816816A1C9CE04887767CA93`.
- Dependencies remain MudBlazor `9.14.0`, Markdig `1.6.0`, HtmlSanitizer `11.0.26`, and ASP.NET Core Components Authorization/Web `10.0.12`.

## Global component spacing

- The default `FlatDisplaySettings` surface includes a `Spacing` section with separate Desktop and Tablet/phone sliders.
- Preferences persist as `WidgetGapPx` and `MobileWidgetGapPx`, preview immediately, and drive `--opx-widget-gap-desktop` plus `--opx-widget-gap-mobile`.
- The responsive `--opx-widget-gap` alias switches at `900px`, so package layouts that consume the shared token update together.
- Host defaults remain `FlatUiDisplayOptions.WidgetGap=16` and `MobileWidgetGap=12`; `MinimumWidgetGap=0` and `MaximumWidgetGap=32` bound the standard controls.
- Density still owns internal control/table/card/navigation rhythm. Widget spacing owns parent-level layout gaps; neither replaces page gutters, panel padding, safe areas, or component-specific internal geometry.
- Consumers must not override this preference through page-local margins or redefine package tokens.

## CRUD/FormModal heading geometry

- Two-line Mode/eyebrow and title headers use explicit line boxes, a small internal gap, vertical padding, and a content-fitting minimum height.
- Preserve the 40px Back target, title ellipsis, body-only scrolling, and fixed footer.
- Do not compensate through fixed heights, negative offsets, transforms, overflow hiding, or consumer selectors targeting package internals.
- Browser visual checks are required at desktop/mobile and minimum/maximum supported font preferences; native MAUI claims still require device evidence.

The source commit did not add a separate skill-file delta for 2.2.9. This consumer imports the verified package contracts additively into its existing, more complete local skill and template mirror.

