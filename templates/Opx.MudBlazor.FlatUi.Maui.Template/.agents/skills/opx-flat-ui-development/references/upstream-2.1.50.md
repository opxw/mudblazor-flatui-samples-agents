# Web/PWA reliability guidance for 2.1.50

Copyright (c) 2026 opx. All rights reserved.

Imported 2026-10-13 from the working tree of D:/projects/git/mudblazor-flat-ui, based on e42f494 with uncommitted changes. Use PageId opx.page.reference.experience-toolkit for lifecycle/recovery and opx.page.account.profile-edit for standalone keyboard coverage. Official NuGet 2.1.50 restores with a valid repository signature; package CSS is unchanged. Keep NuGet-only ownership, existing native Back adapters, positive padding and original CSS.

## Foreground recovery

Read docs/WEB-RECONNECT.md. After a real hidden/pagehide transition, the first foreground visibility/pageshow/focus/resume event runs one single-flight JS-to-.NET heartbeat. Duplicate events do not create duplicate probes. A healthy circuit keeps the current document; missing/rejected or slower-than-1.2-second response goes through the guarded restart path. Keep the URL and at-most-once-per-minute throttle. Dirty/processing/host unsafe-work markers, unavailable storage or denied synchronous permission prevent auto reload and preserve recovery UI.

Retain the bounded 0/500/1000/2000/3000ms framework retry profile and one package helper. Custom timing requires explicit opt-out and one host-owned recovery implementation. Never install this Web/PWA helper in MAUI, replay mutations, claim durable drafts, extend sessions or treat restart as business success. Host authentication, durable drafts, idempotency and unknown operation reconciliation remain independent.

## Mobile Web/PWA keyboard

Read docs/MOBILE-RELIABILITY.md. Preserve an explicit interactive-widget policy; otherwise use viewport-fit=cover and interactive-widget=resizes-content through package startup. Keyboard detection uses a stable pre-IME baseline even when layout and visual viewport shrink together. Retain VisualViewport fallback, reveal the active editable field through its actual scroll owner, preserve nested modal ownership and exclude pinch zoom. Do not add a duplicate keyboard-sized spacer when content has already resized. No consumer focus-scroll script, fixed keyboard height or CSS workaround.

## Acceptance boundary

Package source/minified JavaScript and fingerprinted initializer are the deployed authority; source checkout alone is not package proof. Imported documentation test reports are upstream historical evidence, not local execution. Validate foreground clean/dirty/processing recovery and keyboard geometry in Web/PWA; installed Android/iOS PWA and MAUI IME need separate device proof. This import adds no runtime sample, native adapter or regression script.
