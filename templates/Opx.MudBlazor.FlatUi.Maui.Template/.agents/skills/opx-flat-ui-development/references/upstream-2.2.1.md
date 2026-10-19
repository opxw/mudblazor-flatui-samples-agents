# Visible-idle Server recovery

Copyright (c) 2026 opx. All rights reserved.

Imported 2026-10-18 from D:/projects/git/mudblazor-flat-ui working tree based on a543fa8, including its uncommitted reconnect/rules changes. Official NuGet.org 2.2.1 restores with a valid repository signature. Nupkg SHA256 B0B05ED3BA337155BA391F2B3034F615A7D7B46429F36754CB3E0CB235B7417E. CSS SHA256 remains 71BF6AE517ED4292944710BA144666DBABF9AF4FAB3E5959B6642F8F49F63CEA; dependencies are unchanged from 2.2.0. Upstream unpublished-artifact notes are historical, not current NuGet availability evidence.

Use PageId opx.page.reference.experience-toolkit for lifecycle diagnosis and read docs/WEB-RECONNECT.md. After at least 30 seconds without pointer/key activity or a probe, focus/pageshow/online/resume, first pointer/key input or framework retrying/show may invoke the bounded heartbeat without a hidden/pagehide transition. The threshold classifies idle state; it is not an added reconnect delay. Do not add periodic server polling or race framework retries during recent activity.

Keep concurrent events single-flight, defer while offline, retain the 600ms heartbeat deadline and the existing pending-reconnect independence. Preserve dirty/upload/processing markers, fail-closed storage and once-per-minute reload throttle. Never replay business operations or promise durable draft restoration. Hosts own session validation, persistence and unknown mutation reconciliation.

This is Server-backed Web/PWA recovery, not standalone WASM offline support or MAUI native Back. Keep original package assets and separate host adapters. No runtime sample/native adapter or regression script is copied by this import. Upstream test counts and browser smoke are not consumer/device proof; verify actual clean/dirty/processing idle transitions before making runtime claims.
