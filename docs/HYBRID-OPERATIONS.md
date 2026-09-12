# Hybrid operations P1 / P2

Copyright (c) 2026 opx. All rights reserved.

This increment provides host-neutral coordination contracts and a **local simulation** at `opx.page.reference.experience-toolkit`. It is not a completed device-integration or accessibility certification milestone.

## Implemented

- `FlatHostCapability` separates availability and permission; `IFlatHostCapabilityProvider` probes without requesting permissions. Reuses `FlatNativeCapability`. CanExecute is presentation eligibility, never server authorization.
- `FlatHostConnection` distinguishes network, API reachability and session validity. All three must be positive before the outbox runner dispatches; no URL probing is embedded in the package.
- `FlatDocumentTransferService` validates bounded materialized bytes and safe leaf filenames, snapshots bytes, forwards bounded progress, and enforces single-flight. Host adapter implements Save/Share/Open. No implicit retry or fetch. Exceptions after dispatch produce Failed rather than claiming cancellation or rollback.
- `FlatScanCoordinator` reuses `IFlatScannerAdapter` / `FlatScanResult` for camera and keyboard/manual input. Bounds input; never navigates to or executes scanned text. Null camera result means cancelled; absent adapter means unsupported.
- `FlatOutboxRunner` reuses `FlatSyncItemState`, preserves an opaque idempotency key and only dispatches pending or explicitly retryable failed work. Conflict, completed and unknown outcomes are not replayed. Cancellation/exception after dispatch requires host reconciliation.
- `IFlatAdvancedPrintService` is an optional page-range/orientation seam, with one-based validated ranges. Existing print adapters do not implement these options yet; never silently treat the interface as platform support. Thermal/ESC-POS stays separate and is not implemented here.
- `FlatHostDiagnostic` intentionally has no arbitrary exception/message, URL, identity or business payload. It holds versions, capability/check state and an opaque correlation ID only. Emission, access and retention remain host-owned.

## Host obligations and remaining work

Register per-user/scoped coordinators for Web, not global mutable services. Durable outbox storage must atomically claim operations, isolate tenant/user, keep idempotency across retries, encrypt sensitive data as required and reconcile uncertain server outcomes. The in-memory runner is not durable or cross-process locking. Transfer adapters must clean temporary files, report truthful Submitted versus Completed, respect user cancellation and enforce host file policy. No physical scanner, printer or server integration is implied.

Web/MAUI transfer adapters are now implemented and registered in the canonical hosts, with Download/Share/Open connected in PDF Viewer. Web uses streamed bytes and a Blob download, optional Web Share, or PDF-only new-window Open. Unsupported actions explicitly suggest Download; popup/activation policies may prevent Open/Share. Web transfer reports Submitted, not completed saving. MAUI uses Toolkit FileSaver, Share and Launcher; successful FileSaver returns Completed while external handoff returns Submitted. Native Share/Open files remain in a dedicated cache for 24 hours and are purged on the next operation, not immediately on chooser return. This is bounded retention on use, not a background deletion guarantee. Production hosts must define stricter sensitive-file policy where necessary.

Platform capability/permission providers, camera decoding, durable outbox storage, print-option implementations and thermal transport remain integration work. TalkBack, keyboard-only and scaled-text testing remain required before claiming P1 accessibility complete. No automatic background work or package publication occurs.

Transfer validation: Web Release and Android/Windows Debug builds pass without warnings/errors; 355 .NET tests pass. `scripts/test-document-transfer.mjs` verifies an actual browser download, Submitted feedback, unsupported Share, simulated Share AbortError and HTML Open rejection. Native Save/Share/Open runtime and physical-device behavior remain unverified. Existing 2.1.27 NuGet predates these additions.

## Verification

`FlatHybridOperationsTests` covers network/permission fail-closed behavior, unsafe filename rejection, transfer snapshot/single-flight, inert bounded scans, outbox retry/conflict/unknown rules, and print-option validation. The shared showroom demonstrates synthetic scanner input and dispatch decisions only.

## This consumer checkout

The upstream implementation and test results above describe the package source repository, not proof of this consumer's runtime. NuGet 2.1.29 supplies the shared APIs. This import updates package dependencies and guidance; it does not wire the newer document-transfer adapters or hybrid-operations example into these hosts. Consult `D:\projects\git\mudblazor-flat-ui` for the canonical adapters when enabling Save/Share/Open. Existing printing remains separate. The minimal MAUI template requires explicit host integration.

