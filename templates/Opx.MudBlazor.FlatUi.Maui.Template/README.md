# OPX Flat UI MAUI Hybrid consumer

This project is the canonical package-mode starting point for OPX Flat UI Android and iOS Blazor Hybrid applications.

It uses NuGet `Opx.MudBlazor.FlatUi` 2.1.25, restores Device/Manual font size and density before first paint, and configures package-owned panel headers with `PanelHeaderMinHeight=48` and `PanelHeaderPaddingY=10`. Preserve those public options; do not replace them with consumer CSS overrides.

## First preparation

```powershell
.\run-clean.ps1 -PrepareOnly
.\scripts\audit_maui_consumer.ps1
dotnet build -f net10.0-android -c Release --no-restore
```

`run-clean.ps1` removes only this project's `bin` and `obj`, restores from NuGet.org, and prevents stale static-web-asset manifests from affecting the first run. Reusable MudBlazor and OPX CSS remains package-owned; `wwwroot/app.css` contains host/mobile composition only.

## Required host integrations

- Replace `SampleRootStartupGateValidator` with the application's real session validator. Local storage is only an untrusted restoration hint; server/API authorization remains authoritative.
- Replace the sample Dashboard, Transactions, Reports, identity, logout, routes, permissions, and data with the application's actual business contracts.
- Keep Settings and the default navigable shell available at initialization. Bottom navigation is viewport-driven through `900px`; wider windows use the sidebar. Parent and overflow items default to the package Bottom Sheet; `MainView` is explicit opt-in.
- Android Back is layered: close/guard the topmost package modal first, navigate to the previous Blazor WebView history entry next, and delegate to native app exit only at the true root.
- Keep Light as the initial theme and Device typography as the mobile default. Buttons must accommodate accessibility-scaled text without clipping.
- Preserve Toolkit `StatusBarBehavior` and `MobileThemeBridge`, native no-bounce mappings, textbox-only text selection, and the continuous static-to-interactive `Memuat` spinner.
- Do not copy or override reusable OPX component CSS in the app.

## Native evidence boundary

The audit and Android Release build validate the static contract and compile compatibility. They do not prove status-bar appearance, safe areas, rotation, keyboard/IME, accessibility text scaling, back navigation, lifecycle/resume, WebView bounce, selection, or device authorization behavior. Validate those on representative Android devices/emulators. Build and validate iOS on macOS/Xcode with an iOS simulator or device before making iOS-native claims.

Read `RULES.md`, `.agents/AGENTS.md`, `.agents/RULES.md`, `.agents/skills/opx-flat-ui-development/SKILL.md`, and `flat-ui.mobile.contract.json` before changing the composition.
