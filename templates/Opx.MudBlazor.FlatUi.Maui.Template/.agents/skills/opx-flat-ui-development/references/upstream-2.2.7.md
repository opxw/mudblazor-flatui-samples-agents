# NuGet 2.2.7 consumer baseline

Copyright (c) 2026 opx. All rights reserved.

- Official package: `Opx.MudBlazor.FlatUi` `2.2.7` from NuGet.org.
- NuGet.org repository signature verification passed on 2026-11-20.
- Nupkg SHA-256: `710D4CCCFB43BE7DA04C943CB46B0E80BA750ACE69B9EEFB2CB8FC7E6431832F`.
- Package metadata records repository commit `80f88c60b278ce56dfa43aee331a5133abc8fe67`.
- CSS SHA-256: `F7313BBF4F1B570CA00D86AAFA0B39B303E7AF4AE99A6E241A21240706BD6B08`.
- `grouped-grid-scrollbars.js` SHA-256: `FB826FF5CF1CB6A6F01C7040D5C81A6D0497E66A89B8F34240CAF8EA47181D1A`.
- Readable JavaScript SHA-256 remains `5446D6D616731507E5450E9E543883166314A99BFAB846D83FE6C4AA91174D0E`.
- Minified JavaScript SHA-256 remains `D588F934C8076DE582325209ED2AB5DAB4243C0C81BF1BE2934EFA52EA11993F`.
- Dependencies remain MudBlazor `9.14.0`, Markdig `1.6.0`, HtmlSanitizer `11.0.26`, and ASP.NET Core Components Authorization/Web `10.0.12`.

## Persistent grouped-grid scrollbars

- `FlatGroupedDataGrid<TItem>.AlwaysShowScrollbars=true` loads the package static module `grouped-grid-scrollbars.js`.
- The module renders persistent vertical and horizontal rails/thumbs so operating-system overlay-scrollbar policy cannot hide the visual controls.
- `.flat-data-grid-scroll` remains the only scroll owner. Wheel, middle-mouse autoscroll, touch, keyboard, and programmatic scroll positions remain native and are not forwarded.
- The visual controls mirror native movement, support pointer dragging and rail paging, and recalculate after resize, group expansion, and content changes.
- Component disposal detaches listeners/observers and removes generated controls.
- Responsive cards hide the custom controls at `900px` and below.
- Forced-colors, unavailable JavaScript, or failed module loading retains native fallback.
- Consumers must not copy the module, its CSS, selectors, or pointer logic.

See `docs/GROUPED-DATA-GRID.md` for usage and ownership boundaries.
