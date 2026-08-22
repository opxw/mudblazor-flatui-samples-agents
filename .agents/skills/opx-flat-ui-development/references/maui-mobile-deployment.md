# MAUI Android/iOS deployment contract

Copyright (c) 2026 opx. All rights reserved.

Read this reference when a consumer adds, deploys, or reviews a .NET MAUI Blazor Hybrid host for Android or iOS. It does not make the Web-only `opx-flatui-web` template a MAUI project.

## Required host setup

- Reference `CommunityToolkit.Maui` at a stable version compatible with the host's selected .NET MAUI SDK; do not copy the package into the OPX Razor library.
- Add `using CommunityToolkit.Maui;` and call `.UseMauiCommunityToolkit()` on the `MauiAppBuilder` in `MauiProgram.cs`.
- Attach `CommunityToolkit.Maui.Behaviors.StatusBarBehavior` to the native root `ContentPage` that owns the `BlazorWebView`. Prefer the behavior over calling the platform API directly from the page constructor, `OnAppearing`, or `OnNavigatedTo`.
- Android requires no additional Toolkit status-bar configuration. In `Platforms/iOS/Info.plist`, set `UIViewControllerBasedStatusBarAppearance` to `false`.

## Color and theme ownership

- Initialize mobile typography with OPX Device ownership: `OpxFlatUi:Display:UseAppFontSize=false`. The Razor root follows device/browser `1rem` and OS/browser accessibility text scaling. Keep Manual available as an explicit persisted user choice, but never make a fixed Manual pixel value the Android/iOS default.
- Keep one host-owned resolved theme/palette state as the authority for both the native status bar and the OPX AppBar. The status-bar background must equal the rendered AppBar background exactly; a separately copied or visually similar hex value is non-compliant.
- Bridge the resolved value explicitly between the MAUI host and Razor shell. Do not scrape computed CSS and do not let Android and iOS independently choose product colors.
- Update `StatusBarBehavior.StatusBarColor` whenever the resolved Light/Dark/Auto theme or active palette changes. Reapply the current state after navigation and application resume when the native lifecycle can restore system chrome.
- Select `StatusBarStyle.LightContent` or `DarkContent` from the resolved background contrast so icons and text remain readable. Matching background colors does not justify unreadable system content.
- Preserve safe-area/notch ownership. The status bar may share the AppBar color, but content must still begin inside the correct platform inset.

## Native validation gate

Use representative Android and iOS emulators or physical devices. Verify:

- first launch and warm resume use the same status-bar and AppBar background;
- explicit Light and Dark/Night override device preference coherently;
- Auto follows a changed system appearance without mixed native/Web chrome;
- palette changes update both surfaces in the same rendered state;
- status-bar icon/text contrast remains readable for every supported palette;
- OS text-size/accessibility changes update Device typography without switching to Manual;
- forward/back navigation and app resume do not restore a stale prior color;
- portrait/landscape, notch/safe-area, keyboard/IME, and fullscreen modal transitions remain correct.

A Release build or responsive browser preview is not native deployment proof. Record platform, OS/API version, device/emulator, theme, palette, and observed result when reporting completion.

## Authoritative API references

- [Get started with .NET MAUI Community Toolkit](https://learn.microsoft.com/dotnet/communitytoolkit/maui/get-started)
- [StatusBarBehavior](https://learn.microsoft.com/dotnet/communitytoolkit/maui/behaviors/statusbar-behavior)
