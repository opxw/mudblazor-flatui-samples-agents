# Foreground recovery guidance for 2.1.51

Copyright (c) 2026 opx. All rights reserved.

Imported 2026-10-14 from D:/projects/git/mudblazor-flat-ui working tree based on e42f494, including uncommitted reconnect changes. Official NuGet 2.1.51 restores and its signature is verified. The fingerprinted initializer specifies foregroundProbeTimeoutMilliseconds=600. This supersedes the 1.2-second policy in the historical 2.1.50 reference.

Use PageId opx.page.reference.experience-toolkit for Web/PWA lifecycle diagnosis and read docs/WEB-RECONNECT.md. After an actual hidden/pagehide transition, one single-flight heartbeat takes priority even when framework state is already failed. A healthy circuit keeps the document; an unavailable probe falls back to framework reconnect; rejected or non-responsive probes use guarded restart after 600ms. Duplicate visibility/pageshow/focus/resume events do not create duplicate probes.

Keep one recovery owner, bounded retries, same-URL restart, once-per-minute throttle and fail-closed storage/unsafe-work markers. Dirty drafts, processing, uploads, camera, mutation and auth transitions must prevent unsafe automatic reload. Hosts own durable drafts, authentication, idempotency and unknown mutation outcomes. Never replay business operations or claim state is persisted by reconnect.

Preserve the 2.1.50 keyboard viewport contract: explicit host policy wins, otherwise package viewport-fit/interactive-widget defaults, stable pre-IME baseline, real scroll owner, no duplicate spacer and no consumer focus-scroll script. Recovery is Web/PWA-only, not native MAUI Back or IME policy.

No runtime sample, native adapter or regression script is copied by this import. Package/build inspection is not browser, installed-PWA or native-device proof. Validate clean/dirty/processing foreground transitions and keyboard behavior separately before claiming runtime completion.
