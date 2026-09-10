# MAUI Android/iOS deployment contract

Copyright (c) 2026 opx. All rights reserved.

Read this reference when a consumer adds, deploys, or reviews a .NET MAUI Blazor Hybrid host for Android or iOS. It does not make the Web-only `opx-flatui-web` template a MAUI project.

## Required host setup

- Reference `CommunityToolkit.Maui` at a stable version compatible with the host's selected .NET MAUI SDK; do not copy the package into the OPX Razor library.
- Add `using CommunityToolkit.Maui;` and call `.UseMauiCommunityToolkit()` on the `MauiAppBuilder` in `MauiProgram.cs`.
- Attach `CommunityToolkit.Maui.Behaviors.StatusBarBehavior` to the native root `ContentPage` that owns the `BlazorWebView`. Prefer the behavior over calling the platform API directly from the page constructor, `OnAppearing`, or `OnNavigatedTo`.
- Android requires no additional Toolkit status-bar configuration. In `Platforms/iOS/Info.plist`, set `UIViewControllerBasedStatusBarAppearance` to `false`.
- In Android `AndroidManifest.xml`, declare `android.permission.ACCESS_NETWORK_STATE` before reading `Connectivity.Current.NetworkAccess`. Declare `android.permission.POST_NOTIFICATIONS` when the host exposes local notifications; on Android versions requiring runtime approval, request it only from the notification action initiated by the user. A manifest declaration alone does not implement notification channels, delivery, tap routing, or scheduling.

## Color and theme ownership

- Initialize mobile typography with OPX Device ownership: `OpxFlatUi:Display:UseAppFontSize=false`. The Razor root follows device/browser `1rem` and OS/browser accessibility text scaling. Keep Manual available as an explicit persisted user choice, but never make a fixed Manual pixel value the Android/iOS default.
- Ordinary text-button labels inherit the Device scale. Let button height and content width grow, or allow a deliberate readable wrap, when scaled text needs more space. Never clip/ellipsize a required action label, lock the button to an incompatible fixed height, or shrink below the established touch target. Keep density as the minimum geometry and treat text-fit growth as an accessibility exception; icon-only toolbar buttons, FAB glyphs, and global spacing do not scale merely because text does.
- Keep one host-owned resolved theme bridge as the authority for both the native status bar and the OPX AppBar. Bind `StatusBarBehavior.StatusBarColor` to the exact resolved theme token that paints the AppBar. Palette Primary, a separately copied hex, or a visually similar platform color is non-compliant whenever it differs from the rendered AppBar.
- Support explicit Light and Dark/Night plus Auto. Explicit selection overrides the system theme; Auto follows system changes. Recompute the shared resolved token at startup, theme change, palette change, navigation, and resume, then update AppBar and status bar from that one value.
- Set `StatusBarBehavior.ApplyOn="OnPageNavigatedTo"` when page navigation can change or restore system chrome; property changes still carry theme and palette updates.
- Derive `StatusBarStyle.LightContent` or `DarkContent` from the final resolved background contrast, after all theme and palette resolution.
- Bridge the resolved value explicitly between the MAUI host and Razor shell. Do not scrape computed CSS and do not let Android and iOS independently choose product colors.
- Update `StatusBarBehavior.StatusBarColor` whenever the resolved Light/Dark/Auto theme or active palette changes. Reapply the current state after navigation and application resume when the native lifecycle can restore system chrome.
- Select `StatusBarStyle.LightContent` or `DarkContent` from the resolved background contrast so icons and text remain readable. Matching background colors does not justify unreadable system content.
- Preserve safe-area/notch ownership. The status bar may share the AppBar color, but content must still begin inside the correct platform inset.

## Mandatory WebView interaction rule

- This section is required for every Android/iOS MAUI Hybrid consumer; missing any item is contract noncompliance. Preserve ordinary vertical and internal-panel scrolling, but disable native root bounce and edge overscroll. Configure the MAUI `BlazorWebView` handler so iOS `WKWebView.ScrollView.Bounces` and `AlwaysBounceVertical` are `false`; configure Android `WebView.OverScrollMode` as `Never`. Also apply `overscroll-behavior:none` to the Hybrid document root so scroll chaining does not recreate the effect.
- Pull-to-refresh is not permission to restore WebView bounce. Eligible pages use the explicit package refresh contract and indicator; ineligible pages remain inert at the top edge.
- Default the Hybrid application root to `user-select:none`, `-webkit-user-select:none`, and no WebKit touch callout. Restore `user-select:text`, `-webkit-user-select:text`, caret placement, selection handles, and clipboard operations only within textbox-class controls: text-bearing `input`, `textarea`, and deliberate `[contenteditable=true]` editors.
- Do not treat buttons, labels, cards, AppBar/sidebar copy, table cells, dashboard metrics, icons, or read-only display text as textbox targets. Do not block typing, validation, focus, password-manager/autofill, keyboard/IME composition, assistive-technology focus, or normal scroll gestures.
- Keep the native handler mapping and Hybrid-root selector scoped to the MAUI host. Do not fork reusable OPX component CSS or change the Web consumer's normal copy/selection semantics merely to satisfy a native shell rule.

## Mandatory startup-loading rule

- Remove stock .NET/MAUI splash artwork. Keep `MauiSplashScreen` only as a neutral `#FFFFFF` surface with the canonical one-pixel white-on-white invisible SVG so Android 12+ can satisfy its mandatory system-splash contract without displaying a .NET logo or colored brand frame. Hand off immediately to `Memuat`; do not claim the Android-owned frame can be eliminated on every supported OS version.
- During both native `BlazorWebView` bootstrap and session authorization checking, render `Memuat` with exactly one package-owned `.flat-system-loading-spinner`. Its geometry, accent, border, and motion match the Reconnecting state of `FlatReconnectModal`; do not create a host-specific spinner.
- Place centered full-viewport static placeholder markup in the MAUI host document so it appears before Razor becomes interactive. Once interactive, authentication-enabled hosts hand off to `<FlatSessionRestore Title="Memuat" />`. Coordinate visibility so the user never sees a blank frame, two spinners, text-only `Memuat`, or a protected-layout flash.
- Resolve surface and text colors from the active Light/Dark/Night/Auto theme, respect safe-area insets, and retain a visible static ring when reduced motion suppresses rotation. This contract governs the first WebView-owned loading surface after the native launch splash.

## Native validation gate

Use representative Android and iOS emulators or physical devices. Verify:

- first launch, forward/back navigation, and warm resume use the same status-bar and AppBar background;
- explicit Light and Dark/Night override device preference coherently;
- Auto follows a changed system appearance without mixed native/Web chrome;
- palette changes update both surfaces in the same rendered state;
- status-bar icon/text contrast remains readable for every supported palette;
- OS text-size/accessibility changes update Device typography without switching to Manual;
- ordinary text buttons remain fully readable, grow/wrap as needed, and preserve their minimum touch target at large accessibility text sizes;
- forward/back navigation and app resume do not restore a stale prior color;
- portrait/landscape, notch/safe-area, keyboard/IME, and fullscreen modal transitions remain correct.
- top/bottom edge drags do not bounce, stretch, or show Android edge glow while ordinary page and internal-panel scrolling still works;
- long-pressing ordinary UI copy does not select text or show a copy callout, while textbox input, selection handles, caret movement, copy/paste, autofill, validation, and IME still work;
- cold start and session checking show one centered `Memuat` spinner matching Reconnecting, with no text-only, blank, duplicate, stale-theme, unsafe-area, or protected-shell frame;

A Release build or responsive browser preview is not native deployment proof. Record platform, OS/API version, device/emulator, theme, palette, and observed result when reporting completion.

## Authoritative API references

- [Get started with .NET MAUI Community Toolkit](https://learn.microsoft.com/dotnet/communitytoolkit/maui/get-started)
- [StatusBarBehavior](https://learn.microsoft.com/dotnet/communitytoolkit/maui/behaviors/statusbar-behavior)
