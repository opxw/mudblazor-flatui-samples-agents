# NuGet 2.2.6 consumer baseline

Copyright (c) 2026 opx. All rights reserved.

- Official package: `Opx.MudBlazor.FlatUi` `2.2.6` from NuGet.org.
- NuGet.org repository signature verification passed on 2026-11-20.
- Nupkg SHA-256: `DD97C4FBD10C63E21B17546668F8C62FA3DBFE29E868FC3F128179DD1CA23662`.
- Package metadata records repository commit `5564f00ea2b28d4234ac78ca4f754705ea285d38`.
- The shipped DLL and stylesheet expose the `AlwaysShowScrollbars` contract documented in source checkout `80f88c60b278ce56dfa43aee331a5133abc8fe67`; record this distinction instead of treating the metadata commit as complete source provenance.
- CSS SHA-256: `79E060542CB0B1B1B869F85917D1D502221D3765FA8F470CF20EE9C99396F660`.
- Readable JavaScript SHA-256 remains `5446D6D616731507E5450E9E543883166314A99BFAB846D83FE6C4AA91174D0E`.
- Minified JavaScript SHA-256 remains `D588F934C8076DE582325209ED2AB5DAB4243C0C81BF1BE2934EFA52EA11993F`.
- Dependencies remain MudBlazor `9.14.0`, Markdig `1.6.0`, HtmlSanitizer `11.0.26`, and ASP.NET Core Components Authorization/Web `10.0.12`.

## Imported source contract

- `FlatGroupedDataGrid<TItem>.AlwaysShowScrollbars` defaults to `false`.
- Set it to `true` only for a bounded desktop operational grid where permanent horizontal and vertical scrollbar tracks materially improve discoverability.
- Use it together with `DesktopViewportHeight`; the package-owned `.flat-data-grid-scroll` remains the only two-axis scroller.
- Do not add consumer `.flat-*` CSS, overflow wrappers, wheel forwarding, or a second active scroll owner.
- Responsive cards retain natural page scrolling.
- The ERP Work Orders source sample is the reference composition: fixed detail columns, wrapped Description cells, `AutoRowHeight`, `8px 12px` detail padding, separators, sticky headers, and one package-owned scroller.
- Operating systems with overlay-scrollbar preferences may still control thumb visibility even though the grid reserves stable tracks.

See `docs/GROUPED-DATA-GRID.md` for usage and ownership boundaries.
