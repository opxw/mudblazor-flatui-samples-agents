# Opx.MudBlazor.FlatUi MAUI Hybrid host sample

Copyright (c) 2026 opx. All rights reserved.

This project is the executable host reference for consuming `Opx.MudBlazor.FlatUi` from .NET MAUI Blazor Hybrid on Android and Windows.

The standalone solution is intentionally not added to the repository root solution. This keeps the existing Web/library Linux build independent from MAUI workloads while preserving explicit native build gates here.

It demonstrates:

- an interactive root startup/session gate before `Router`;
- `FlatSessionRestore` inside the OPX provider/theme shell;
- Debug source JavaScript and Release minified JavaScript selection;
- `HostKind=MauiHybrid`, Auto theme startup, and typed appsettings;
- viewport-only Sidebar/Bottom navigation with a deliberate `900px` host threshold;
- host-owned adapters for SecureStorage, file picker, camera and share;
- Android edge-to-edge with a transparent status bar and measured AppBar inset through CommunityToolkit.Maui;
- an explicit native-notification replacement point.

It does not implement real authentication, API authorization, business persistence, offline synchronization, native notification channels, print adapters, or background services.

## Build from this NuGet-only consumer checkout

```powershell
dotnet restore .\samples\Opx.MudBlazor.FlatUi.MauiHost.Sample\Opx.MudBlazor.FlatUi.MauiHost.Sample.csproj --configfile .\NuGet.Config
dotnet build .\samples\Opx.MudBlazor.FlatUi.MauiHost.Sample\Opx.MudBlazor.FlatUi.MauiHost.Sample.csproj -f net10.0-windows10.0.19041.0 -c Debug --no-restore
dotnet build .\samples\Opx.MudBlazor.FlatUi.MauiHost.Sample\Opx.MudBlazor.FlatUi.MauiHost.Sample.csproj -f net10.0-android -c Debug --no-restore
```

This consumer repository always restores `Opx.MudBlazor.FlatUi` `2.0.17` from NuGet.org. A source `ProjectReference` is intentionally forbidden here.

## Production replacements

1. Implement `IHybridSessionBootstrapper` with SecureStorage lookup, backend validation/refresh, auth-state update, expiry/revocation handling, and anonymous/protected navigation.
2. Replace `MauiDeviceNotificationService` with platform services. Request permission only after an explicit user gesture.
3. Keep camera/gallery, file, share/open/print, deep link, connectivity, lifecycle, and system-Back policy in the MAUI host.
4. Keep authorization, persistence, audit, offline queues, conflict policy, and business mutation in the backend/host.
5. Validate Android and Windows Back, keyboard/IME, safe area, pull-to-refresh, camera, notification, theme startup, suspend/resume, and accessibility on target devices.

On Android, the host enables edge-to-edge, initializes `CommunityToolkit.Maui`, and attaches
a `StatusBarBehavior` to `MainPage`. The native status bar stays transparent. Its actual
`WindowInsets` height is converted to CSS pixels so the AppBar becomes `60px + inset`, while
the hamburger, title, search, and actions stay vertically centered in the lower `60px`.
Light/Dark/Auto, system-theme, and palette renders update the status-icon contrast from the
computed AppBar surface. Web and Windows keep the regular `60px` AppBar.

Do not place API credentials or provider secrets in `appsettings.json`, Razor, browser storage, query strings, logs, or package assets.
