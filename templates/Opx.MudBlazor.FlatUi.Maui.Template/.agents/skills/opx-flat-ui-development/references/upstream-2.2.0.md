# Single-package Server, WASM and MAUI guidance

Copyright (c) 2026 opx. All rights reserved.

Imported 2026-10-16 from D:/projects/git/mudblazor-flat-ui commit a543fa8. Official NuGet.org 2.2.0 repository signature verified; nupkg SHA256 C17BFAFDF0EE28A73C47B6C2B5B6D969738F3F77ADF70405C3D8AE820E9C3910. Package repository metadata records e42f494, not the later guidance commit. CSS SHA256 remains 71BF6AE517ED4292944710BA144666DBABF9AF4FAB3E5959B6642F8F49F63CEA; dependencies remain MudBlazor 9.10.0, Blazor Components 10.0.12, Markdig 1.3.2 and HtmlSanitizer 9.2.1039.

## Host selection and ownership

- Consume only Opx.MudBlazor.FlatUi from NuGet.org for reusable UI. Browser services use namespace Opx.MudBlazor.FlatUi.WebAssembly but live in the same core package/DLL. Do not reference superseded local companion packages or package-source projects.
- Server registers framework circuits in its executable host. WASM explicitly calls AddOpxFlatUiWebAssembly and loads blazor.webassembly.js, not the Server initializer/reconnect surface. MAUI retains its native host and adapters. Installation, viewport or user-agent never switches runtimes or Back ownership.
- Read docs/WEBASSEMBLY-PWA.md when a separate WASM/PWA host is requested. The upstream combined sample uses /mobile/ with matching document base, manifest and worker scope; production root hosting requires changing all three consistently. This consumer import does not add that executable host or migrate shared pages.
- Cache only integrity-checked static build assets. Exclude API responses, user data, photos and credentials; do not force worker activation/reload over drafts. Deploy complete published assets atomically and return 404 for missing assets.
- FlatBrowserStorage snapshots are host-scoped, unencrypted and evictable. Require explicit non-sensitive draft persistence, stable user/tenant scope and logout/retention cleanup. Never store bearer tokens or passwords. Authenticated APIs, authorization, consent, protected media storage and idempotent uploads remain host-owned.
- Start FlatPwaLifecycle after first render and dispose it with the host scope. Online is not API/session health. Same-origin hosting does not supply shared authentication; no secrets belong in WASM/public appsettings.

## Server foreground recovery

Use PageId opx.page.reference.experience-toolkit for lifecycle diagnosis and docs/WEB-RECONNECT.md. A real background/foreground transition must run its bounded 600ms heartbeat even while an earlier Blazor.reconnect promise remains pending. Keep reconnect and heartbeat independently single-flight. Preserve healthy documents, fall back when unavailable, and use guarded same-URL restart for stale probes. Unsafe-work markers, unavailable storage and once-per-minute throttle deny reload. Never replay mutations or claim durable draft restoration. This Server circuit mechanism is not WASM offline support or MAUI native navigation.

## Acceptance boundary

Keep original package CSS and consumer defaults, positive panel insets, root startup gate, separate Web/MAUI Back and existing native adapters. Local source tests, upstream screenshots and published sample instructions are references, not evidence that this consumer passed them. Verify exact-package builds; a newly requested WASM host additionally needs published offline reload, no Server circuit requests and device/authentication testing. Existing legacy MAUI safe-area migration remains separate.
