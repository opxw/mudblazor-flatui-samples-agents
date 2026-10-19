# Web/PWA reconnect recovery

## 2.2.1 visible-idle recovery

After at least 30 seconds without pointer/key activity or a probe, focus/pageshow/online/resume, first pointer/key input or a framework retrying/show event may trigger the same bounded heartbeat without hidden/pagehide. This is event-driven, not periodic polling. Concurrent events share one probe; recent activity does not race normal framework retries. Offline defers until online. The existing 600ms deadline and draft/upload, storage and reload-throttle guards remain. The 30 seconds classifies inactivity, not an extra reconnect delay. This guidance is imported from the a543fa8 working tree; the official 2.2.1 asset contains the patch. Consumer runtime/device testing remains separate.

> Imported from upstream a543fa8 for NuGet 2.2.0. The circuit guidance applies to Server-backed Web/PWA, not standalone WASM or MAUI. Upstream validation scripts and application adoption examples below are references, not tests run or integrations installed in this consumer.

The package automatically configures and attaches Web/PWA recovery through its .NET 10 Razor Class Library JavaScript initializer. It augments the existing `FlatReconnectModal` and Blazor reconnect handler without creating a second UI or replacing `Blazor.start`. The initializer exports only the Web hooks, so it does not run in MAUI.

The package Web/PWA retry sequence is `0`, `500`, `1000`, `2000`, and `3000` milliseconds: five attempts complete in about 6.5 seconds before the framework reports failure. The initializer intentionally replaces framework or host reconnect timing so package consumers receive deterministic fast recovery.

Installed PWAs also receive a foreground circuit probe. After the document has actually been hidden or receives `pagehide`, the first `visibilitychange`, `pageshow`, `focus`, or Page Lifecycle `resume` event runs one lightweight JS-to-.NET heartbeat. This heartbeat takes precedence even when the framework already reports `failed`, so an idle return does not first enter the longer reconnect loop. An already pending `Blazor.reconnect()` must not suppress this bounded probe after suspension; reconnect calls themselves remain single-flight. A healthy circuit keeps the current document and performs no reload. A rejected or slower-than-600-millisecond response marks the circuit stale and immediately uses the same guarded restart path. An unavailable probe falls back to framework reconnect. Duplicate foreground events do not start duplicate probes.

The package attaches `window.opxFlatReconnect` after Web startup. A host can still attach manually when it has opted out of automatic recovery:

```js
const disposeRecovery = window.opxFlatReconnect.attach('components-reconnect-modal');
```

Set `data-opx-reconnect-recovery="false"` on the root `<html>` element to disable both package retry defaults and automatic attachment. A host that needs custom retry timing must use this opt-out and fully own reconnect startup and recovery. Do not register a second consumer reconnect helper while package recovery is enabled.

After the framework exhausts its retry sequence, package recovery retries only while online and visible and on online, pageshow, or visibilitychange. It is single-flight, bounded to five attempts with two-second spacing per recovery cycle, and never races Blazor's active retry state. Reattaching to the same element disposes the old package owner.

For a native-like clean resume, the Web initializer enables one automatic document restart when the server rejects a lost circuit or the foreground probe proves the circuit stale. The reload keeps the current URL and is throttled to once per minute. `FlatUnsavedChangesGuard` while dirty and `FlatProcessingContainer` while active automatically render `data-opx-reconnect-block-reload="true"`, which blocks restart and leaves the recovery UI available instead. Host-owned editors, uploads, camera work, or mutations outside those components must render the same marker while unsafe. Unavailable session storage also denies restart. This is lifecycle recovery, not operation replay or durable draft persistence.

For a manually attached, opted-out host, automatic reload still uses `{ reloadOnRejected: true, canReload: () => hostDraftState.isSafeToReload() }`. This must return synchronous boolean true from browser state; false, exceptions, missing callback and Promises deny reload. Do not call disconnected .NET to decide. The DOM block marker remains authoritative even if the callback allows reload. The manual package retry button remains available.

Reload happens only while online and visible, at most once per minute across reloads via an origin/sessionStorage marker. Unavailable storage denies auto reload. The helper does not replay operations, cache credentials, extend session expiration, change circuit retention, prevent OS suspension, or preserve lost server-side state. Hosts still own durable drafts and session recovery. Restarting a server with an in-memory session vault can require login.

SIAP86 adoption: consume a new package containing this API first, remove its local reconnect.js registration, then rely on package auto-attachment or opt out and keep one host-owned helper with its draft/camera guard. Do not mix new DLL and old JS assets. The existing local 2.1.49 artifact predates this foreground heartbeat source patch and must not be used as evidence for it; build a newer package before consumer adoption. No local package or browser smoke is physical-device or production certification.

Validation: `node --test tests/reconnect-recovery.test.cjs tests/reconnect-initializer.test.cjs`, .NET package tests, and browser smoke of source/minified assets.
