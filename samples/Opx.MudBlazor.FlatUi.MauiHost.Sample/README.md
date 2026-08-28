# Opx.MudBlazor.FlatUi MAUI Hybrid host sample

Copyright (c) 2026 opx. All rights reserved.

This project is the executable host reference for consuming `Opx.MudBlazor.FlatUi` from .NET MAUI Blazor Hybrid on Android and Windows.

The full page showroom is not duplicated here. It comes from the shared
`Opx.MudBlazor.FlatUi.Showcase` RCL, which is also consumed by the Web sample. This host adds only
the `MAUI Host` navigation group and native-only pages/adapters.

The standalone solution is intentionally not added to the repository root solution. This keeps the existing Web/library Linux build independent from MAUI workloads while preserving explicit native build gates here.

It demonstrates:

- an interactive root startup/session gate before `Router`;
- `FlatSessionRestore` inside the OPX provider/theme shell with a stable semantic page background throughout preference hydration;
- Debug source JavaScript and Release minified JavaScript selection;
- `HostKind=MauiHybrid`, Auto theme startup, and typed appsettings;
- viewport-only Sidebar/Bottom navigation with a deliberate `900px` host threshold and one recursive `NavigationItems` source for both renderers;
- a host-native Android/Windows `RefreshView` around the persistent `BlazorWebView`, enabled only by an eligible page's `NativePullToRefreshEnabled=true` contract;
- host-owned adapters for SecureStorage, file picker, camera and share;
- Android network-state permission for the host-owned `Connectivity.Current.NetworkAccess` capability;
- Android edge-to-edge with a transparent status bar and measured AppBar inset through CommunityToolkit.Maui;
- no-bounce root scrolling through package overscroll CSS and Android native WebView edge-overscroll suppression;
- Blazor-first Android Back handling: package modal/overlay, previous WebView history entry, then native dispatcher only at the true root;
- the complete shared display Settings surface plus a MAUI-only action that tests the host-owned local notification adapter;
- a real Android local-notification channel, dedicated monochrome small-icon resource, enabled-channel check, and runtime permission flow started only by that explicit user action.

It does not implement real authentication, API authorization, business persistence, offline synchronization, scheduled/background notifications, Windows notification delivery, print adapters, or background services.

The sample intentionally omits a custom `<Menu>` fragment. `FlatAppShell.NavigationItems` is the canonical host menu: at `900px` and below it renders as Bottom navigation, while above `900px` the package renders the same tree in the Sidebar. A custom `Menu` fragment remains supported for existing consumers, but it overrides the typed Sidebar and should not duplicate the same records.

## Build from this source checkout

```powershell
dotnet restore .\samples\Opx.MudBlazor.FlatUi.MauiHost.Sample\Opx.MudBlazor.FlatUi.MauiHost.Sample.csproj --configfile .\NuGet.Config
dotnet build .\samples\Opx.MudBlazor.FlatUi.MauiHost.Sample\Opx.MudBlazor.FlatUi.MauiHost.Sample.csproj -f net10.0-windows10.0.19041.0 -c Debug --no-restore
dotnet build .\samples\Opx.MudBlazor.FlatUi.MauiHost.Sample\Opx.MudBlazor.FlatUi.MauiHost.Sample.csproj -f net10.0-android -c Debug --no-restore
```

This consumer repository restores reusable UI from public NuGet `2.1.2`; the local `Showcase` project contains composition only. To prove package consumption, build with:

```powershell
dotnet build .\samples\Opx.MudBlazor.FlatUi.MauiHost.Sample\Opx.MudBlazor.FlatUi.MauiHost.Sample.csproj -f net10.0-windows10.0.19041.0 -p:UseFlatUiProjectReference=false
```

## Production replacements

1. Implement `IHybridSessionBootstrapper` with SecureStorage lookup, backend validation/refresh, auth-state update, expiry/revocation handling, and anonymous/protected navigation.
2. Extend or replace `MauiDeviceNotificationService` for Windows/iOS, scheduling, cancellation, and notification-tap routing. The Android sample requests permission only after the explicit Settings test action.
3. Keep camera/gallery, file, share/open/print, deep link, connectivity, lifecycle, and system-Back policy in the MAUI host.
4. Keep authorization, persistence, audit, offline queues, conflict policy, and business mutation in the backend/host.
5. Validate Android and Windows Back, keyboard/IME, safe area, pull-to-refresh, camera, notification, theme startup, suspend/resume, and accessibility on target devices.

Native pull-to-refresh is registered as singleton host state and remains disabled by default. The
Dashboard sample opts in through `NativePullToRefreshEnabled="true"` and a real `OnRefresh`
callback. `RefreshView.IsRefreshEnabled` controls only the gesture; the child WebView remains
interactive on every ineligible route. In a MAUI host, native refresh supersedes the package
JavaScript gesture if both flags are set. Web continues to use the independently configurable
`PullToRefreshEnabled` path.

On Android, the host enables edge-to-edge, initializes `CommunityToolkit.Maui`, and attaches
a `StatusBarBehavior` to `MainPage`. The native status bar stays transparent. Its actual
`WindowInsets` height is converted to CSS pixels so the AppBar becomes `60px + inset`, while
the hamburger, title, search, and actions stay vertically centered in the lower `60px`.
Light/Dark/Auto, system-theme, and palette renders update the status-icon contrast from the
computed AppBar surface. Sidebar content uses the same measured top inset so brand/search/menu
never collide with status icons, while the drawer background remains edge-to-edge and its user
block keeps bottom safe-area padding. Auth and Website shells also consume the measured inset;
short landscape windows keep vertical scrolling and compact top-aligned content so headings are
not clipped. Web and Windows keep the regular `60px` AppBar and zero native shell inset.

Do not place API credentials or provider secrets in `appsettings.json`, Razor, browser storage, query strings, logs, or package assets.
