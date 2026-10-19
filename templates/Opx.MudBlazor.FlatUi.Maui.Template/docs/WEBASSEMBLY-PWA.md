# Separate Server and WebAssembly hosts, shared OPX components

> Imported guidance from upstream a543fa8 on 2026-10-16. Commands and executable WASM paths below refer to D:/projects/git/mudblazor-flat-ui, not this consumer repository. This import adds no WASM executable or production deployment; consumers use the official NuGet.org package, never source ProjectReference or unpublished companion packages. Upstream verification instructions are not local runtime proof.

The reusable architecture uses one package and DLL: `Opx.MudBlazor.FlatUi`. It contains shared components, reconnect assets and browser storage/lifecycle services. The executable WASM sample remains `Opx.MudBlazor.FlatUi.WebAssembly.Sample.dll`. Separate executable hosts are required; this does not migrate all Showcase pages or HR Person.

Server hosts register `FlatReconnectOptions` and call the framework `AddRazorComponents().AddInteractiveServerComponents(...)`. WASM hosts call `AddOpxFlatUiWebAssembly` from the shared package (the namespace remains `Opx.MudBlazor.FlatUi.WebAssembly`). Browser JS is `_content/Opx.MudBlazor.FlatUi/browser.js`. Do not reference the earlier local companion packages alongside this merged package. Manifest and service-worker caching policy remain host-owned. No ASP.NET Core Server framework dependency is added to the shared library.

The Server sample can serve published WASM files under `/mobile/` on the same origin. Server remains at `/`; host-owned APIs may use `/api/`. Do not infer hosting mode from installation or device detection. Opening `/mobile/` in a normal browser also runs WASM.

## Run the combined preview

From the repository root:

```powershell
dotnet publish samples/Opx.MudBlazor.FlatUi.WebAssembly -c Release -o artifacts/wasm-host
$env:MobilePwa__Root = (Resolve-Path artifacts/wasm-host/wwwroot).Path
$env:ASPNETCORE_ENVIRONMENT = 'Development'
dotnet run --project samples/Opx.MudBlazor.FlatUi.Sample -c Release --no-launch-profile --urls http://127.0.0.1:58814
```

Open `/` for Server and `/mobile/` for WASM. HTTPS is required for production service workers and device permissions; localhost is suitable for development. `MobilePwa:Root` is optional, absolute or relative to Server content root, and must contain the published index. Missing asset requests return 404 rather than HTML. Deploy the complete published wwwroot directory atomically, not selected DLLs.

For NuGet consumption, set `UseFlatUiProjectReference=false` and `FlatUiPackageVersion=2.2.0` in both hosts. Build with `publish-nuget.ps1 -Version 2.2.0 -PackOnly`; it produces one local package without publication. A shared change reaches hosts after package upgrade and rebuild/deployment. Source previews use project references.

The rebuilt single-package 2.2.0 supersedes the earlier unpublished three-package candidate. Use an isolated NuGet cache when validating because both candidates share a version. Earlier artifacts are retained only as historical evidence.

For separate production domains, serve Server at `https://a.trustapps.my.id/` and publish the WASM host with base href, manifest start_url and scope set to `/` at `https://pwa-a.trustapps.my.id/`. Configure that host's extensionless fallback to index.html and HTTPS, API CORS and authentication callbacks explicitly. The current local combined sample retains `/mobile/`. Installation does not switch runtimes: visiting the PWA domain in an ordinary browser also runs WASM. DNS, TLS, production auth and deployment are not configured by this package.

## Lifecycle and data contract

- WASM loads `blazor.webassembly.js`; no Server reconnect modal or Server startup initializer. Reconnect opt-out is explicit in the document.
- Manifest start URL, scope and service worker scope are `/mobile/`. Server navigation and APIs stay outside the cache boundary.
- Release service worker caches only build-manifest static assets with integrity hashes. Arbitrary API responses, photos and credentials are not cached.
- Updates wait for old clients to close. No skipWaiting, forced controller reload or automatic draft discard.
- The sample explicitly saves/clears a non-sensitive draft through `FlatBrowserStorage` IndexedDB snapshots. Scope is host-selected; production uses a stable user/tenant scope and clears it on logout/retention expiry. Storage is unencrypted and may be evicted. Never store bearer tokens/passwords. Snapshot persistence does not implement durable photo upload. Production hosts own authenticated APIs, authorization, consent, protected photo storage, expiry/cleanup and idempotent upload confirmation.
- `FlatPwaLifecycle` publishes browser online/visible/standalone state. Online is not API/session health. Start it after first render, dispose it with the host scope, and let application callbacks decide safe refresh/retry. Worker registration rejects a URL outside the host base path and never forces activation.
- Same-origin hosting alone does not implement shared authentication. Cookie/CSRF or token integration requires a host contract. Never put secrets in WASM or public appsettings.

## Verification

Run `node scripts/test-webassembly-pwa.cjs` against the combined preview. It checks real WASM execution, offline reload after service-worker activation, no circuit requests, mobile overflow, missing static asset 404 and Server root coexistence. Device installation, camera picker lifecycle, iOS storage eviction and production authentication require separate device/integration validation.
