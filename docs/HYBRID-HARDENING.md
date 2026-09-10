# Hybrid hardening — P0 through P2

Copyright (c) 2026 opx. All rights reserved.

Canonical sample: `opx.page.reference.experience-toolkit` (`/experience-toolkit`).
This extends existing mobile reliability; it is not another ERP feature roadmap.

## P0: native gesture, overlays and device regression

An open responsive Vertical drawer registers a Sheet overlay and owns a native
refresh suspension lease. Back closes the drawer before route/root navigation;
closing, navigating, changing navigation mode, resizing to persistent desktop,
or disposing releases both registrations. A persistent desktop sidebar is not
a blocking overlay and must never consume Back or suspend refresh.

The Android host registers `NativeRefreshViewHandler`, retaining the native
MauiSwipeRefreshLayout indicator while overriding CanChildScrollUp to consult
`NativeRefreshGestureGate`. MAUI 10.0.20 bypasses the AndroidX callback in its own
override, so installing only OnChildScrollUpCallback is insufficient. At ACTION_DOWN it obtains a bounded
boolean from `opxFlatPullRefresh.canStartNative`, using coordinates relative to the
persistent WebView. The hit target must belong to the active Native FlatPage,
and the document, ancestor scroll chain and visible primary list must be at top.
Inputs, buttons, links, editable/drag surfaces, overlays, busy pages, multitouch,
horizontal/upward gestures and unknown/late results do not start native refresh.
Eligibility is latched per gesture; reaching top halfway through a scroll does
not turn that scroll into refresh. No JavaScript-to-Java interface, URL fetch or
consumer business mapping is introduced. Slow hit tests deliberately require a
new pull rather than steal an ongoing scroll. This host adapter must accompany
the package upgrade; upgrading only the NuGet DLL cannot patch a consumer host.

Native refresh callbacks marshal onto the component dispatcher and explicitly
render both busy and completed states. Otherwise data-refresh-blocked can remain
true after a successful callback and silently prevent the next native gesture.
The regression gate must test a second refresh and restoration after a modal,
not just the first successful pull.

Android Back dispatches modal callbacks through JS interop onto the Blazor
renderer without traversing WebView history, then consults the scoped overlay coordinator for sheets.
After overlays, explicitly use WebView.CanGoBack()/GoBack(); only an empty history
falls through to native root behavior. Never derive a parent URL from menu hierarchy.
The Activity dispatcher fallback alone does not perform WebView history Back.
Native scoped-service dispatch is not a component render dispatcher.
Web keeps history-backed modal behavior; MAUI receives the canonical OpxHostKind
cascade and never pushes/pops a document history entry for CRUD modal lifetime.
The Android callback is reattached after WebView handler and overlay state changes:
MAUI can register its own history callback after Activity.OnCreate, so root-page
Back success alone is insufficient. Verify a modal on a non-root route stays on
that same route after closing. See [MAUI callback-order report](https://github.com/dotnet/maui/issues/34379).
The pinned MAUI 10.0.20 WebView additionally handles Back in OnKeyDown before
Activity callbacks. The canonical Activity consumes paired Back down/up while the
host page exists, using one single-flight pipeline: visible IME, overlay, actual
WebView history, then native root. Holding a key must not run a second path on key-up.
See the [pinned WebView implementation](https://github.com/dotnet/maui/blob/10.0.20/src/BlazorWebView/src/Maui/Android/BlazorAndroidWebView.cs).
Rejected dismissal still consumes Back. Bottom navigation unwinds
one child level at a time and closes its root sheet before route/app Back. Generic
BottomSheet and bottom navigation hold independent native-refresh suspension
leases. CRUD and decision-locked questions retain their existing semantics:
cancelled CRUD returns false; confirmation never silently returns true on Back.

Native edge-to-edge CRUD panels reserve the supplied status-bar and navigation-bar
insets independently of the AppBar. Keyboard-visible panels remove the bottom
reserve because the visual viewport already ends above the IME. Browser-only
layouts remain unchanged; no hard-coded device status-bar height is used.

`scripts/test-android-emulator.ps1 -Apk <Release signed APK>` targets only the
approved Pixel 7 1080x2400 emulator. It preserves app data, checks same-process
resume and activity retention after sheet Back, and captures scroll/landscape/
resume checkpoints. Rotation settings are restored in finally. Screenshot
checkpoints remain NeedsVisualReview, not an automatic visual pass. Full modal,
IME and native nested-scroll acceptance still requires the matching scenarios;
see the run report. ADB boot completion is not proof of a responsive screen.

## P1: non-touch access, resume and accessibility

An enabled FlatPage with gesture-only refresh now supplies one accessible refresh
action. It is visible for fine-pointer devices and appears on keyboard focus on
coarse-pointer devices; touch-only dashboards keep their compact presentation.
Existing visible toolbar refresh takes precedence. All package-owned paths share
the guarded callback. Explicit RefreshMode.Disabled removes package manual and
gesture actions, including late callbacks; it does not cancel unrelated host work.
This intentional accessibility refinement supersedes older absolute “no refresh
button on Dashboard/MAUI” guidance.

FlatScrollRestoration captures on visibility loss/pagehide and restores on resume
only while the same owner remains mounted. Filters and selections stay in host
workspace state. List/data must be ready before initial restoration. This does
not promise process-death, server-circuit-loss or logout persistence. Durable,
user/tenant/page-scoped storage and data loading remain host-owned.

The MAUI Window suspends native gestures while stopped/destroyed and releases
only its own suspension on resume; it never overrides page Disabled or a modal.
Keyboard focus, reduced motion, scoped axe and landscape/scroll regression are
covered by `hybrid-hardening.spec.ts` and existing mobile/experience tests.
Browser accessibility is not TalkBack/Narrator certification.

## P2: offline/retry and exact-artifact evidence

Reuse FlatOperationState with host-supplied Offline/Timeout/Forbidden results.
Retry requires CanRetry plus a callback and is single-flight until that callback
finishes. No automatic network reconnect/replay or persistence is performed.
The shared sample explicitly simulates offline/denied outcomes, keeps existing
records, and counts deliberate recovery attempts. FlatOfflineSyncPanel remains
the separate host queue presentation; network reachability is not API health.

`publish-nuget.ps1` now creates a SHA256-bound `.compatibility.json` companion for
every new package. `scripts/write-artifact-compatibility.ps1` can do the same for
APK/AAB/ZIP/MSIX. All runtime platforms start NotRun; never copy old passing
results to a new hash. Add reviewed exact-artifact evidence without overwriting
unrelated entries. The canonical native host targets Android and Windows only.
No NuGet publication or version bump is implied by this hardening work.

Android reference: [OnChildScrollUpCallback](https://developer.android.com/reference/androidx/swiperefreshlayout/widget/SwipeRefreshLayout.OnChildScrollUpCallback).
