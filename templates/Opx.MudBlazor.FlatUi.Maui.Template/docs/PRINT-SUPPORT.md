# Shared PDF printing

Available in signed NuGet.org **2.1.27**. The dated validation sections below describe upstream artifacts and do not certify this consumer's native runtime. Register the Web service explicitly and connect `FlatPdfViewer.OnPrint`; Android/Windows adapters remain host-owned sample source and must be integrated separately. Installing the NuGet does not install a native adapter.

`IFlatPrintService` accepts an already authorized `FlatPrintRequest` containing PDF bytes and a title. It does not fetch URLs, generate reports, enumerate printers, choose a printer silently, or send ESC/POS commands. The host owns authorization, generation, audit and sensitive-document policies.

```csharp
var capabilities = await printService.GetCapabilitiesAsync(token);
if (capabilities.CanPrintPdf)
{
    var result = await printService.PrintAsync(new(pdfBytes, "Report"), token);
    // Handle every status. Submitted is NOT Completed.
}
```

## Results

- `Completed`: adapter observed completed native job state; not proof of paper delivery.
- `Cancelled`: pre-dispatch cancellation or an observed native cancellation.
- `Unsupported`: no host adapter/API available.
- `Failed`: invalid/oversized PDF, active request, rendering/interop/native failure.
- `Submitted`: printing was handed to a dialog/system whose final outcome is unknown.

Browser `print()`/`afterprint` and WebView2 `ShowPrintUI` cannot reliably distinguish final print versus cancel. Never translate dialog closure to Completed. Capability describes host support, not connected printer discovery or permission to print. Call from an explicit user action; after native dispatch cancellation belongs to its dialog. Cancellation of an interop connection is an unknown outcome, not a cancelled physical job.

## Hosts

| Host | Registration / behavior |
|---|---|
| Web desktop/mobile | Scoped `IFlatPrintService, FlatWebPrintService`; PDF.js renders a separate iframe and invokes browser print. No popup or application chrome; no silent printer selection. |
| MAUI Android | Singleton sample `MauiPrintService`; PrintManager + bounded PDF page renderer, requested page ranges, cancellation and temporary-file cleanup after OnFinish. |
| MAUI Windows | Same sample service; isolated PDF WebView2 page with explicit Print and Close. Uses ShowPrintUI, never prints the application's current page. |
| Other native hosts | `FlatUnsupportedPrintService` until an explicit adapter is supplied. iOS is not a current sample target. |

Shared sample `/pdf-viewer` calls the service through the existing `OnPrint` callback, preserving the component API and the legacy browser fallback for consumers without a callback. Its PDF bytes come from `SamplePdfDocument`, shared by both hosts. They contain synthetic sample content only.

## Bounds and fidelity

Requests accept 5 bytes to 20MiB and require a `%PDF-` signature; this is a fast rejection check, not a security scan or full PDF validation. Renderers validate the document. Browser and Android adapters limit to 50 pages. Web has a cumulative 32M-pixel limit and 8192px maximum page dimension; Android renders one page at a time at 144dpi with a 16M-pixel page limit. Native adapter files use random app-cache names and are removed when the print UI session finishes; application process death can leave cache files, so production hosts must define expiry/scoped cleanup. PDFs requiring vector-perfect output should use a host-approved vector print pipeline; these Web/Android render paths rasterize pages.

Thermal/ESC-POS remains a separate future transport contract. The service never downloads arbitrary URLs or prints additional unmaterialized report rows.

## Validation

`FlatPrintingTests` covers status mapping, malformed/oversized requests, precancellation and single-flight release. `scripts/test-print-browser.mjs` runs the actual shared Blazor page at desktop/tablet/phone widths, stubs only window.print, verifies all 12 pages, absence of app chrome, Submitted and iframe cleanup. This does not prove browser OS print UI, a physical printer, Android/iOS, or Windows runtime behavior. Native build/runtime evidence must be recorded separately.

Platform reference: [Android custom documents](https://developer.android.com/training/printing/custom-docs), [WebView2 printing](https://learn.microsoft.com/en-us/microsoft-edge/webview2/how-to/print).

### Local verification — 2026-09-11

- 347 Release .NET tests passed; Web Release, Android Debug and Windows Debug builds passed without warnings/errors. Repository audit: 66 checks passed.
- Web test passed at 1280, 800 and 390px with browser print stubbed, all 12 rendered pages and cleanup verified.
- Pixel 7 API36: native Print Framework displayed the 12-page PDF preview. Back returned to a responsive Blazor page; the adapter reported Submitted because no terminal job status was available. This is not proof of observed cancellation or physical output. `scripts/test-print-android.mjs` covers this boundary using managed Bottom menu navigation.
- Android diagnostic APK SHA256: `166D8774B3FA282E23B5577F05F49BDDF35DDB703CDC10D26BA14C7FE3D606F6`. Screenshot: `artifacts/print-support/android-dialog.png`.
- Initial harness full-document navigation caused a WebView disposal error; use the application's managed menu path. Windows print runtime, iOS and physical printers remain unverified. No new NuGet was packed or published; existing 2.1.26 predates this implementation.

### Package verification — 2.1.27

Official PackOnly: `artifacts/nuget/20260911-222059-2.1.27/Opx.MudBlazor.FlatUi.2.1.27.nupkg`, 1,268,016 bytes, SHA256 `C9490EB14467BC6953311D437ED1A0F835F95A7553179BFC6521A120777E4C99`. Exact-package suite: 347 passed, zero failed/skipped; fresh consumer Release build: zero warnings/errors. Source and minified JS include opxFlatPrint; package is unsigned and contains no PDB. Prior native/browser evidence above is not exact-artifact runtime certification. This supersedes the source-only packaging status above; no publication performed.
