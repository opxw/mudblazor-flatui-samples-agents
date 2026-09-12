# PDF viewer

Copyright (c) 2026 opx. All rights reserved.

`FlatPdfViewer` is the reusable responsive shell for PDF reports and documents. It uses the pinned Mozilla PDF.js runtime packaged under the RCL static assets for page rendering, zoom, navigation, text search, and thumbnails. MudBlazor provides the application controls and theme behavior.

## Usage

```razor
<FlatPdfViewer SourceUrl="/reports/sales.pdf"
               Title="Sales Report"
               OnRefresh="ReloadReportAsync"
               OnDownload="DownloadAsync"
               OnShare="ShareAsync"
               OnOpenExternal="OpenExternalAsync"
               OnPrint="PrintAsync">
    <ParametersContent>
        <!-- Host-owned report parameters. -->
    </ParametersContent>
</FlatPdfViewer>
```

The component owns responsive presentation, page/zoom/search state, PDF.js rendering, loading/error feedback, and exact action callbacks. The host owns authentication, authorization, report/PDF generation, secure URLs, storage, download transport, and every native integration.

## Responsive behavior

- Above `900px`, parameter/search/thumbnail controls and document actions remain in the compact upper toolbar.
- At `900px` and below, secondary actions move into the header menu and page navigation plus Print remain in the bottom bar.
- The viewer owns its internal page and thumbnail scrolling. It must not create document-level horizontal overflow.
- OPX typography, focus, Light/Dark/Auto surfaces, and square component geometry remain authoritative.

## Platform adapters

For the shared `IFlatPrintService` contract and current Web/Android/Windows sample registrations, see [PRINT-SUPPORT.md](PRINT-SUPPORT.md). `OnPrint` remains the integration seam; Submitted must not be treated as confirmed printing.

When `OnPrint` is not supplied, the component renders every page through PDF.js into a temporary browser print document and opens the standard Web print dialog. A supplied `OnPrint` callback overrides that fallback. Handle native callbacks in the consuming host:

| Capability | Host adapter |
|---|---|
| Windows print | WebView2 Print API |
| Browser print | Built-in PDF.js render-to-print fallback |
| Android print | Android `PrintManager` |
| iOS print | `UIPrintInteractionController` |
| Share PDF | .NET MAUI `Share.Default` |
| Open externally | .NET MAUI `Launcher.Default` |

Platform authorization, temporary-file lifecycle, URI permissions, print settings, cancellation, errors, and audit remain host responsibilities. Browser validation proves the PDF.js Web surface only; Windows/Android/iOS behavior requires matching device or emulator evidence.

## Assets and security

- PDF.js is pinned through `pdfjs-dist` in `package-lock.json`; packaged runtime files and the Mozilla license are under `wwwroot/vendor/pdfjs`.
- `PdfJsModuleUrl` and `PdfJsWorkerUrl` may be overridden when a host serves approved assets from another base path.
- Treat `SourceUrl` as untrusted input. The host must authorize access, use bounded file sizes, validate actual PDF bytes, set appropriate CSP/CORS headers, and avoid embedding secrets in query strings.
- Text search reads the PDF text layer exposed by PDF.js and jumps to the matching page. It does not provide OCR for scanned images.
