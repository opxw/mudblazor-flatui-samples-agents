# P0 compatibility and lifecycle gates

The release gate tests the packed library, not just its source project. Run:

```powershell
./scripts/test-release-package.ps1 -PackagePath <exact-release-artifact.nupkg>
```

Without PackagePath, the script creates a temporary validation package at the current source version. It does not publish, increment the version, or replace an earlier release artifact.

## Coverage

- The tests project uses ProjectReference by default. Passing FlatUiPackageVersion replaces it with PackageReference; the same bUnit, DI, public API and contract suite runs against the package DLL.
- The gate pins the OPX package to its isolated local source, uses a fresh dependency cache and separate build output, and rejects public API baseline regeneration. GUID-scoped validation files are removed after success or failure; existing release artifacts are preserved.
- Public API and FlatPage.Title binding tests detect missing parameters; provider tests cover direct display-options registration and IOptions precedence.
- CompatibilityLifecycleTests exercise Web and MauiHybrid host-kind composition: repeated icon searches, empty results, draft selection, Cancel/close-button discard, modal removal/remount, scanner cancellation and late callback suppression.
- The live Web circuit test repeats search/empty-result/Cancel/host-Back interactions and checks subsequent server interaction plus circuit/JavaScript failures. Playwright runs desktop, tablet and phone profiles.
- Existing tests retain modal result, refresh suspension, grid, and source host-contract coverage. Source/CSS assertions still inspect the checkout; they are not binary or device verification.

```powershell
dotnet test tests/Opx.MudBlazor.FlatUi.Tests/Opx.MudBlazor.FlatUi.Tests.csproj -c Release
npx playwright test tests/responsive/compatibility-lifecycle.spec.ts --output artifacts/p0-browser-results
```

Both gates are included in the existing Windows/Linux CI workflow. Local Windows success does not assert that hosted Linux CI has run.

## Remaining native boundary

MauiHybrid in bUnit means host-kind contract testing, not an Android/Windows native application. Emulator/device tests are still required for OS Back, app suspend/resume, IME, safe areas, native refresh, permissions and notification adapters. Likewise, a canonical Web test does not prove a different consumer's ObjectDisposedException has been fixed. Do not mark native P0 acceptance complete without those results.
