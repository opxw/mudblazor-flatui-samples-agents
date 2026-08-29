# MAUI Hybrid host reference

Copyright (c) 2026 opx. All rights reserved.

The executable NuGet-only reference project is
`samples/Opx.MudBlazor.FlatUi.MauiHost.Sample`. It targets Android and Windows
and consumes `Opx.MudBlazor.FlatUi` `2.1.3` from NuGet.org.

Every canonical cross-host page route lives once in
`samples/Opx.MudBlazor.FlatUi.Showcase`. Web and MAUI load that RCL through
`Router.AdditionalAssemblies` and share its `ShowcaseNavigationCatalog`;
MAUI-specific startup, native-adapter, status-bar, and performance pages remain
explicit host adapters.

## Ownership

`Opx.MudBlazor.FlatUi` owns presentation, theme tokens, responsive composition,
accessibility semantics, loading surfaces, and typed UI callbacks. The MAUI host owns:

- saved-session validation and authentication-state updates;
- SecureStorage and token lifecycle;
- camera, gallery, file picker, share, launcher, print, and notification adapters;
- native permission prompts, deep links, lifecycle, IME/safe area, and system Back. Android hosts that inspect `Connectivity.Current.NetworkAccess` declare `android.permission.ACCESS_NETWORK_STATE`; hosts exposing local notifications also declare `android.permission.POST_NOTIFICATIONS` and request it only from an explicit user action on supported Android versions;
- API authorization, offline queueing, conflict policy, audit, and business persistence.

The sample deliberately returns `Unsupported` for device notifications until the
consumer registers a real Android, Windows, or iOS service. It never simulates a
successful native notification.

## Startup sequence

1. The native launch surface uses a neutral `#FFFFFF` one-pixel white-on-white invisible `MauiSplashScreen`, removing the stock .NET/MAUI artwork while producing a valid Resizetizer resource. Android 12+ still renders its required system-owned splash frame.
2. `wwwroot/index.html` installs the Light-theme bootstrap and renders the static OPX `Memuat` surface before Razor starts.
3. The Razor root emits the OPX attribution and mounts `RootStartupGate`.
4. The gate loads readable package JavaScript in Debug or the minified asset in Release.
5. `FlatUiPreferencesService` resolves theme and display preferences.
6. `IHybridSessionBootstrapper` performs the host check.
7. Only after that check completes is `Router` constructed. A startup exception stays inside the OPX provider shell and presents the configured recoverable failure state instead of the default Blazor red bar.

This prevents protected content from appearing before the host knows the session state,
including when the initial URI is anonymous. A production implementation reads the saved
credential from SecureStorage, validates or refreshes it through the backend, updates the
authentication state, and resolves navigation. The package does not perform those steps.

## Responsive navigation

The sample intentionally uses Bottom navigation at `900px` and below and Sidebar above
`900px`. The same viewport-only rule applies when a Windows window is resized; platform or
device detection is not used for composition. Package compatibility remains unchanged
because the component default is still `600px`.

## Performance measurement

Open `/maui-performance` to inspect current-process startup checkpoints and route timing
from a location change through the first completed render. Open relevant routes repeatedly,
return to the performance page, and compare Release runs on the same target device. This
instrumentation does not include backend/API/database latency and must not be generalized
to untested Android or iOS hardware.

## Android status bar

The Android sample enables edge-to-edge, initializes `CommunityToolkit.Maui`, and attaches
its `StatusBarBehavior` to native `MainPage`. The status bar is transparent so the AppBar
surface draws behind it. The host reads the actual status-bar `WindowInsets`, converts the
value to CSS pixels, and extends the AppBar from `60px` to `60px + inset`; interactive
controls remain centered in the lower `60px`, and main content starts below the enlarged
AppBar. Luminance-aware Light/Dark icons are synchronized after saved theme/palette changes
and Auto-theme system events. This integration is Android host-owned; Web and Windows keep
the regular `60px` AppBar.

## Android Back behavior

Android Back follows the Blazor-first stack. Dispatch `opxFlatModalHistory.tryHandleBack`
so an open form/modal consumes the first Back. When no modal handles it, call the embedded
Android WebView's `CanGoBack()` and `GoBack()` so the next Back returns to the previous
Blazor route. Delegate to the native dispatcher—and therefore permit app exit—only when
both checks return false.

## Build

```powershell
dotnet restore .\samples\Opx.MudBlazor.FlatUi.MauiHost.Sample\Opx.MudBlazor.FlatUi.MauiHost.Sample.csproj --configfile .\NuGet.Config
& .\samples\Opx.MudBlazor.FlatUi.MauiHost.Sample\scripts\audit-maui-page-sync.ps1
dotnet build .\samples\Opx.MudBlazor.FlatUi.MauiHost.Sample\Opx.MudBlazor.FlatUi.MauiHost.Sample.csproj -f net10.0-windows10.0.19041.0 -c Release --no-restore
dotnet build .\samples\Opx.MudBlazor.FlatUi.MauiHost.Sample\Opx.MudBlazor.FlatUi.MauiHost.Sample.csproj -f net10.0-android -c Release --no-restore
```

The sample must remain on a public NuGet `PackageReference`; a source `ProjectReference`
is forbidden in this consumer/source-of-truth repository.

## Required device evidence

Before calling a consumer production-ready, verify on its actual targets:

- Android and Windows startup in Light, Dark, and Auto;
- live resize through `600px` and `900px` without state loss;
- system Back closing modal, sheet, lookup, or drawer before route navigation;
- hardware/software keyboard, IME, focus, screen reader, high contrast, and safe area;
- camera/file permission denial and recovery;
- local notification permission, delivery, tap routing, channel/category, and lifecycle;
- suspend/resume, connectivity loss, session expiry, offline queue, and reconnect;
- PDF print/share/open and temporary-file security when those adapters are enabled.

Browser responsive checks and successful compilation do not prove these native behaviors.
