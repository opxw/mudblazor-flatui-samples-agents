# NuGet 2.2.5 consumer baseline

Copyright (c) 2026 opx. All rights reserved.

Verified on 2026-11-20 from the official NuGet.org package and the package-source checkout at `D:\Works\projects\git\mudblazor-flat-ui`.

- The NuGet.org repository signature is valid. Nupkg SHA-256 is `DF71CB104008A743AE13C32DA9BB64A2F8E9EF3CA767F5AEA8CE8057479FB1C0`.
- Package repository metadata points to commit `5ab69c5291e1a80ed694b17966cf98729d850840`, which contains the bounded grouped-grid desktop scroller work.
- CSS SHA-256 remains `7D9F87283043369ED37D11E45EEB8252F32B62C33ED07E7BAB49FCE9602423EE`. Readable JavaScript remains `5446D6D616731507E5450E9E543883166314A99BFAB846D83FE6C4AA91174D0E`; minified JavaScript remains `D588F934C8076DE582325209ED2AB5DAB4243C0C81BF1BE2934EFA52EA11993F`.
- The package dependency baseline is MudBlazor `9.14.0`, Markdig `1.6.0`, HtmlSanitizer `11.0.26`, and ASP.NET Core Components Authorization/Web `10.0.12`. Direct consumer MudBlazor references must use `9.14.0` to avoid a package downgrade.
- Preserve the 2.2.4 lookup and grouped-grid contracts. `FlatEntityLookup.SearchVisible` remains opt-in, column filters remain independent, and `FlatGroupedDataGrid.DesktopViewportHeight` sizes the package-owned scroller.

Upgrade package references, Web and mobile contracts, template identities, audit expectations, rules, skills, and knowledge together. A successful build is source evidence. Browser behavior and native MAUI behavior still require their matching runtime checks.
