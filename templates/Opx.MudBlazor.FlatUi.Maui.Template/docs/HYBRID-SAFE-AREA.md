# Package-owned MAUI safe areas

> Consumer import (2.1.35): this document records upstream guidance and upstream-only test/device evidence. NuGet 2.1.35 is now officially published and signature-verified here; the historical statement below that no NuGet was released applies only to the recorded source test. Upstream iOS bootstrap/Container adapter changes and regression scripts are not automatically installed in this consumer. Existing MAUIHost app.css still contains legacy native AppBar/safe-area overrides; a separate canonical host migration and native geometry validation are required before claiming full adoption. Preserve local Web/MAUI Back ownership rules during that migration.

Reference: opx.page.reference.experience-toolkit; FlatAppShell and MAUI MainLayout.

FlatAppShell with HostKind=MauiHybrid now activates package safe-area styling.
The existing html.opx-native-transparent-statusbar marker is also supported and
can be present in the MAUI document before startup, including anonymous routes.
Web shells without either marker retain their existing geometry.

The package owns the AppBar (60px controls plus top inset), main content offset,
Bottom MainView/refresh offset, sidebar, auth/website and native modal rules.
Do not copy these rules into each consumer. Use matching package DLL/static assets.
Existing installed applications need a package upgrade and rebuild; source edits
do not update their binaries.

Inset ownership:

- --opx-native-statusbar-height overrides env(safe-area-inset-top, 0px).
- --opx-native-navigationbar-height overrides env(safe-area-inset-bottom, 0px).
- Native measurements and environment values are alternatives, never added.
- Explicit 0px means the host already protects that edge. Missing means use env.
- WKWebView edge-to-edge documents require viewport-fit=cover. Do not mask an
  unknown iOS inset with zero; the sample bridge removes the unknown top override.
- Android hosts must continue supplying measured, uncovered WebView insets from
  WindowInsets, refreshed on layout/rotation/resume. An RCL cannot read them.
- If the native container already excludes system bars, supply zero rather than
  the physical status-bar height. Do not combine native padding and CSS padding.

The sample no longer owns duplicate AppBar CSS or an iOS-only status-bar cover.
The sample now also declares net10.0-ios with an iOS bootstrap. On iOS,
MainPage uses SafeAreaRegions.Container, following the HRPerson host pattern:
native layout owns the complete WebView clearance and the bridge supplies explicit
zero additional top/bottom insets. Android retains measured edge-to-edge insets.
Browser geometry tests and builds are not iOS/Android runtime certification.

## Regression checks and evidence boundary

Imported 2026-09-24: wide native Horizontal navigation (>=1200px) starts at 60px plus the resolved top inset. Main content and refresh indicators clear another 44px navigation row. Native-container ownership uses explicit zero; edge-to-edge hosts consume measured inset once. Upstream browser geometry cases cover zero/24/59px, but were not rerun here and do not certify this consumer or iOS. Legacy local host overrides remain pending migration.

Run scripts/test-package-safe-area.mjs for package-only env/native override and
Web restoration geometry; run scripts/test-native-editor-header.mjs for the
modal header's single-inset ownership. Run source component tests and the repository
audit. Before release, validate the exact NuGet and rebuild its consumer with
matching DLL and static assets; do not carry source-only results over as release proof.

Recorded 2026-09-17: 449 Release source tests and both geometry scripts passed.
The current Android Debug source-reference APK was installed on Pixel 7 API 36
(pixel_7_-_api_36_0, emulator-5554). Its portrait Dashboard showed status icons
clear of the AppBar, with bottom navigation visible; the user confirmed Android
looked safe. Evidence: artifacts/safe-area-pixel7/portrait.png.

This is a bounded observation, not a blanket Android certification. Native
landscape, keyboard, overlays, all themes and iOS simulator/device remain unverified
for this patch. An initial transient null-style JavaScript error was observed
before the Dashboard rendered and remains undiagnosed. No new NuGet was released.

Later on 2026-09-17 the HRPerson source and its safe-area smoke/documentation
were inspected directly. The sample gained an iOS target/bootstrap and the same
native Container ownership, plus an explicit native-owned flag in the JS bridge.
Windows managed compilation for net10.0-ios / iossimulator-arm64 passed with zero
warnings/errors; the bridge regression passed. Remote SSH then timed out, so
no Mac native build, app bundle deployment or simulator screenshot was obtained.
