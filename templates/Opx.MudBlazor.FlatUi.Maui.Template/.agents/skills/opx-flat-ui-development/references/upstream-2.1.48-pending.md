# Verified package 2.1.48 reconnect guidance

Copyright (c) 2026 opx. All rights reserved.

Imported 2026-10-08 from the source working tree at `D:/projects/git/mudblazor-flat-ui`, based on e42f494 with uncommitted reconnect changes. The earlier publication blocker is resolved: official 2.1.48 restores and its NuGet repository signature is valid. The fingerprinted RCL initializer and source/minified JavaScript are packaged. This filename is retained for existing links; the package is no longer pending. Runtime reconnect and native certification remain separate.

## Web/PWA lifecycle: opx.page.reference.experience-toolkit

Read docs/WEB-RECONNECT.md before reconnect implementation or diagnosis. The source RCL initializer configures five framework delays (0/500/1000/2000/3000ms), then attaches one package-owned recovery helper after Web startup. A custom-timing host opts out with `data-opx-reconnect-recovery="false"` on html and owns startup/recovery completely. Never duplicate the helper or replace Blazor.start implicitly.

After framework failure, retries are online/visible, single-flight and bounded. Failed may reconnect to an existing circuit; rejected requires a new document/circuit. Clean rejected recovery preserves the current URL, throttled to once per minute with sessionStorage. Missing storage, unsafe markers or throttle preserve recovery UI instead of reloading.

Dirty FlatUnsavedChangesGuard and active FlatProcessingContainer emit `data-opx-reconnect-block-reload="true"` in the new source. Hosts must supply the same marker for unsafe editors/uploads/camera/mutations/auth transitions not covered by those components. Manual opted-out auto-reload requires synchronous browser-state permission; false, exceptions, absent callback or Promises deny it. Never call disconnected .NET to decide; the DOM marker remains authoritative.

This is Web/PWA only, never MAUI. Preserve native IME/overlay/dirty/WebView/root arbitration and ordinary Web Back/Forward. Recovery does not replay operations, preserve lost server state, persist drafts, renew authentication or prove business success. Production hosts own durable drafts, authorization, session recovery and unknown mutation outcomes.

## Acceptance boundary

Official restore/signature and packaged initializer/source/minified assets are verified. Validate actual clean/dirty reconnect and host startup/static assets before claiming runtime recovery. Keep CSS package-owned. Source Node/browser tests are references, not executed consumer tests or physical-device proof. This import does not copy upstream tests, runtime samples or host adapters.
