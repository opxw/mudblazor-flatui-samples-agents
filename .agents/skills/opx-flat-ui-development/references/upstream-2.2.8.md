# NuGet 2.2.8 consumer baseline

Copyright (c) 2026 opx. All rights reserved.

- Official package: `Opx.MudBlazor.FlatUi` `2.2.8` from NuGet.org.
- NuGet.org repository signature verification passed on 2026-11-20.
- Nupkg SHA-256: `528F80CADCA82A05615874DAFE1CB5A91824A187C87A86ED71D801B6428317E9`.
- Package metadata records repository commit `80f88c60b278ce56dfa43aee331a5133abc8fe67`.
- CSS SHA-256: `A4AA97D7A2330DF6622C8E2A4CDE1CECB25A655F40629E27B9803B112F30E123`.
- `grouped-grid-scrollbars.js` SHA-256: `68355696CE6FC902DACCADEB467F3C11B8976CBD816816A1C9CE04887767CA93`.
- Readable JavaScript SHA-256 remains `5446D6D616731507E5450E9E543883166314A99BFAB846D83FE6C4AA91174D0E`.
- Minified JavaScript SHA-256 remains `D588F934C8076DE582325209ED2AB5DAB4243C0C81BF1BE2934EFA52EA11993F`.
- Dependencies remain MudBlazor `9.14.0`, Markdig `1.6.0`, HtmlSanitizer `11.0.26`, and ASP.NET Core Components Authorization/Web `10.0.12`.

## Grouped-grid scrollbar visibility correction

- `AlwaysShowScrollbars=true` continues to use the package-owned ES module and the existing `.flat-data-grid-scroll` remains the sole native scroll owner.
- Version `2.2.8` corrects a `2.2.7` visibility defect where generated thumb elements were siblings of the native scroller and therefore could not inherit color tokens declared only on that scroller.
- Scrollbar color tokens now live on the common grouped-grid shell. During attach, the module copies computed colors to that shell and retains a local theme-aware fallback so a thumb cannot become transparent.
- Attach reports success only after the owner, shell, tracks, and thumbs exist. Detach removes generated controls, observers, listeners, classes, and inline color tokens.
- Wheel, middle-mouse autoscroll, touch, keyboard, and programmatic positions remain native; the module only mirrors position and handles pointer dragging or rail paging.
- Responsive cards hide custom controls at `900px` and below. Forced-colors, unavailable JavaScript, or failed module loading retains native fallback.
- Consumers must not copy the module, selectors, color tokens, or pointer logic.

See `docs/GROUPED-DATA-GRID.md` for usage and ownership boundaries.

