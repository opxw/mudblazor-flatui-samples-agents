# Authentication and navigation templates

Copyright © 2026 opx. All rights reserved.

## Included samples

- `/login` is a standalone authentication layout sample.
- `/two-step-verification` demonstrates a six-digit one-time-code workflow with masked destination text, verify, resend, and back-to-login actions.
- `/reset-password` demonstrates reset request, masked destination, six-digit reset code, new-password confirmation/requirements, success, and back-to-login states. The Login sample links to it through `Forgot password?`.
- Web Settings provides `Vertical`, `Horizontal`, and `Bottom` navigation layouts. MAUI Blazor Hybrid provides `Vertical` and `Bottom`. Both retain host-configured color palettes, density, and font size with immediate preview, Save, Cancel, and Restore application defaults.

The authentication pages are UI-only. They do not generate, send, validate, or persist credentials, verification codes, or reset tokens.

## Root startup gate

Create the root startup/session gate before `Router`, not inside a protected layout. This gate therefore runs when the initial URL is `/login`, another anonymous route, or a protected route. While checking, render `FlatSessionRestore` inside `FlatMudProviders` (or the exact equivalent provider/theme shell), using the configured startup copy under `OpxFlatUi:Reconnect`. Keep the full-page loading surface on the resolved semantic page `Background` throughout preference hydration; palette `Primary/Accent` is reserved for the spinner and actions, not the page background. Construct `Router` only after the host callback succeeds so protected layout content cannot flash before session state is known.

The compiled sample uses `Components/RootStartupGate.razor` and a scoped no-op `SampleStartupGateService`. Production hosts replace that callback with saved-session/token validation and authentication-state updates. The library does not read credentials, choose authorization outcomes, or navigate on behalf of the host.

## Configuration-driven Login branding

Treat this configuration as part of initial host scaffolding. Add the complete `OpxFlatUi:Application` block before feature-page development so Login branding never depends on hard-coded page values or a later styling pass.

The Login sample follows the operational reference composition without owning its authentication API or session model. `LoginLayout` selects `Default` or `Boxed`. `Default` preserves the split branding/form layout on desktop; mobile hides the large brand panel and does not repeat a top identity/logo row. `Boxed` centers the same form in a bounded surface over the configured brand background on every viewport. Both modes keep the form heading as the visible application identity, use the same responsive typography and theme tokens, and preserve the same single-flight submit behavior.

The Login form has no static security/integration or `Sample only` footer banner. Required fields and the local invalid-credential simulation use the shared semantic Error MessageBox. The sample accepts only `operator@opx.local` with password `sample`; other non-empty values receive the generic message `The username or password is incorrect.` A production host must replace this local comparison with its own authentication flow without exposing which credential field failed.

Register the typed options in the host:

```csharp
var applicationOptions = builder.Configuration
    .GetSection("OpxFlatUi:Application")
    .Get<FlatApplicationOptions>() ?? new FlatApplicationOptions();
builder.Services.AddSingleton(applicationOptions);
```

Configure the visible identity in `appsettings.json`:

```json
{
  "OpxFlatUi": {
    "Application": {
      "AppName": "OPX Flat UI",
      "CompanyName": "OPX",
      "Author": "Noviyanto Wibowo",
      "Logo": null,
      "Copyright": "© {Year} {CompanyName}",
      "LoginBrandBackgroundColor": "#5274b9",
      "LoginBrandBackgroundImageUrl": null,
      "LoginBrandPanelVisible": true,
      "LoginBrandOverlayColor": "#000000",
      "LoginBrandOverlayOpacity": 0.0,
      "LoginLayout": "Default"
    }
  }
}
```

Expose the configured author once from the host document so every routed page inherits the same metadata:

```razor
@inject FlatApplicationOptions ApplicationOptions

<head>
    <meta name="author" content="@ApplicationOptions.ResolvedAuthor" />
    ...
</head>
```

Do not duplicate the author tag inside individual page components. `FlatApplicationOptions` normalizes blank values to `opx`.

`Logo` and `LogoUrl` are optional. Leave both blank/null to omit the logo element and its reserved gap from the desktop brand identity and form title. `Logo` accepts `Apps`, `Business`, `Computer`, `Dashboard`, `Inventory`, or `Speed`, and also accepts a trusted MudBlazor SVG path. Use `LogoUrl` instead when the host supplies a relative or HTTP(S) image URL. Invalid values resolve to no logo rather than an unrelated fallback icon. The copyright template expands `{Year}` and `{CompanyName}`. A configured logo remains intentionally compact: `34px` in the desktop brand identity and `30px` beside the form title. The duplicate mobile top identity row is not rendered.

The desktop branding background is independently customizable. `LoginBrandBackgroundColor` and `LoginBrandOverlayColor` accept six-digit hexadecimal colors. `LoginBrandBackgroundImageUrl` accepts a relative application asset or HTTP(S) URL; unsupported schemes and CSS-control characters are rejected. `LoginBrandPanelVisible` defaults to `true`; setting it to `false` hides the brand panel and centers the unboxed Login form. `LoginBrandOverlayOpacity` is clamped to `0-0.85`, making text contrast tunable for photography. The image is decorative (`alt=""`) and rendered as an image layer, not raw CSS. The brand panel remains hidden on mobile in `Default`; `Boxed` instead reuses this background behind its centered card. Invalid enum values normalize to `Default`. The sample query `/login?preview=boxed-login` previews `Boxed` without changing the configured host default.

Password fields that provide show/hide use `Class="opx-password-visibility-field"`. The shared rule keeps the eye/eye-off icon white (`#fff`) in resolved Dark/Night and dark (`#212529`) in resolved Light while leaving its background transparent. The class remains on the field when `InputType` switches between Password and Text, so the icon contrast does not change after toggling. Give the toggle an accessible label and retain keyboard activation in production hosts.

Browser credential autofill uses the shared field theme instead of Chromium's injected light-blue surface. The library applies both `:autofill` and `:-webkit-autofill` to input, textarea, and select elements for normal, hover, focus, and active states, preserving the resolved background, text, and caret colors in Light, Dark/Night, and Auto. This is a global field contract rather than a Login-only override, so an autofilled value cannot appear as a separate block beside a transparent adornment. It does not alter dense height, padding, floating labels, outlines, or disabled behavior.

## Navigation configuration

### MAUI versus Web Back ownership

In a hybrid MAUI/Web solution, shared Razor pages share user intent and dirty-state rules, **not the native Back implementation**. This host distinction qualifies every native Back/IME statement below.

- **Web, including mobile browsers and PWA:** use browser/Blazor navigation history and the existing package Web overlay/unsaved-change integration. Visible Back actions must use the Web path. Never call MAUI dispatchers, native `WebView.CanGoBack()`/`GoBack()`, hardware-key handlers, native IME interception or native app-exit logic from Web. Preserve normal browser Back/Forward and native browser confirmation for external reload/tab close; do not install an extra competing `popstate` handler or synthetic route stack.
- **MAUI Hybrid:** register the canonical native adapter only in the MAUI host. Android Back has one paired-key, single-flight owner: visible IME first, then topmost registered overlay/modal with its dirty guard, then actual `WebView.CanGoBack()`/`GoBack()`, then the host's native root policy only when nothing remains to consume Back. Do not apply Android hardware-key handling to iOS; validate its supported native navigation separately.
- **Host selection:** use explicit host configuration and registered capabilities/adapters. Viewport width, responsive Bottom navigation, touch support, user-agent and an Android browser do not prove a MAUI host. Keep native APIs and registrations in the native project; shared callbacks resolve to the correct host implementation. Reuse existing package contracts before proposing additional abstractions.
- **Shared outcome:** Back closes an active modal without leaving its page; a later Back follows actual visited history. A rejected discard keeps draft, modal and route unchanged. Cancel/Back never becomes Save or triggers a data reload. Preserve package-owned Sheet/MainView menu history and Forward; do not guess parent URLs, force Dashboard redirects, or exit from a non-root page.
- **Lifecycle:** keep one owner per Back event. Dispose registrations on teardown; do not invoke both native and Web handlers for the same press. MAUI overlay ownership suspends native pull-to-refresh and releases that lease on close, route/layout transition or disposal; Web must not acquire a native refresh lease.

Before accepting a change, test Web desktop and mobile-browser Back/Forward, modal close, rejected discard and direct-entry routes independently of MAUI. On Android test IME -> modal -> current page -> previous visited page -> actual root, including rapid/repeated presses. Test Bottom Sheet/MainView against their visited menu trail in each host. Record browser and exact native artifact/device evidence separately; a narrow viewport or passing build is not native Back proof. If package ownership is demonstrated, report **bug package**; proven host misrouting is **bug integrasi aplikasi**. Otherwise report **belum terklasifikasi** and the missing evidence.

### Bottom menu Back history

Delivered in the 2.1.24 package line. Upgrade the DLL and bundled OPX JavaScript
together; stale deployed/static-cache assets do not contain the `backMenu`
bridge. The existing host-owned native Back adapter remains required.

Sheet and MainView record each visited menu level with Blazor `HistoryEntryState`
at the unchanged origin URL. Leaf navigation creates the ordinary route entry.
For example: Dashboard -> ERP menu -> Finance menu -> General Ledger. Back
returns to Finance, then ERP, then Dashboard; an origin other than Dashboard
returns to that actual origin instead. Forward replays the visited entries.

Visible menu Back and native overlay Back traverse that same history. Close
(including the Sheet backdrop) unwinds the current consecutive menu entries.
Keyboard/IME and active modal/dirty-form guards retain priority. A rejected
navigation leaves the current menu visible; no hidden sheet is registered on
the leaf page. The host's existing Android Back bridge is still required.

Menu snapshots are bounded and scoped to the shell-retained component, with opaque
history keys; they contain no business route mapping or durable session store.
Direct links, reload/new circuits, stale or foreign history keys do not invent
menu context. Replace the host menu collection after route/permission changes
to invalidate cached snapshots. Menu visibility never authorizes a route.

Regression: `BottomMenuHistoryTests` and `scripts/test-bottom-menu-history.mjs`
(pass `android` for the installed Pixel7 diagnostic sample). Browser proof is
separate from actual MAUI and exact Release-artifact certification.

Set the host default in `appsettings.json`:

```json
{
  "OpxFlatUi": {
    "Display": {
      "HostKind": "Web",
      "AppBarSearchVisible": true,
      "DefaultNavigationLayout": "Vertical",
      "DefaultBottomNavigationChildPresentation": "Sheet",
      "StorageKey": "opx.flat-ui.display"
    }
  }
}
```

`HostKind` accepts `Web` or `MauiHybrid`. Navigation-layout values are `Vertical`, `Horizontal`, and `Bottom`. Horizontal is accepted only when `HostKind` is `Web`; MAUI Hybrid normalizes configured, saved, and previewed Horizontal values to Vertical. Bottom is accepted by both hosts. `DefaultBottomNavigationChildPresentation` accepts `Sheet` or `MainView`; invalid values normalize to `Sheet`. The user overrides are stored per browser by `FlatUiPreferencesService`; the server configuration file is never modified.

The compiled sample also accepts `?preview=bottom-main-view`. This query forces `Bottom` plus `MainView` for the current sample circuit, so a fresh browser or Cloudflare Quick Tunnel can demonstrate the scenario without pre-populated local storage. The preview flag remains latched when a leaf opens another SPA page, keeping the bottom bar visible after the child panel closes; a full reload without the query returns to the configured preference. It does not change or persist the host defaults, and widths above `900px` use the documented sidebar fallback.

Provide both menu representations to `FlatAppShell`:

```razor
<FlatAppShell HostKind="@displayOptions.HostKind"
              NavigationLayout="@preferences.NavigationLayout"
              BottomNavigationMaxWidthPx="900"
              NavigationItems="@navigationItems">
    <Menu>
        <YourSidebarMenu />
    </Menu>
    <HorizontalMenu>
        <FlatHorizontalNavigation Items="@horizontalItems" />
    </HorizontalMenu>
</FlatAppShell>
```

Horizontal navigation is available only to Web hosts at desktop widths. Web tablet/mobile automatically uses the existing hamburger and overlay drawer. Bottom navigation is available to Web and MAUI Hybrid hosts. `BottomNavigationMaxWidthPx` defaults to `600`, preserving existing consumers. Set it to `900` when the host intentionally wants Bottom navigation for both tablet (`601-900px`) and phone (`<=600px`) widths; the sidebar then renders only above `900px`. The selected threshold is evaluated from viewport width and updates during live resize, including a resized Windows EXE; the shell never detects Android, Windows, MAUI, or device type to choose between sidebar and bottom navigation. Pass one recursive `NavigationItems` tree to the shell so Sidebar and Bottom render the same routes, labels, icons, active state, and nested children. When `Menu` is omitted, the Sidebar automatically renders and searches that typed tree; retain `Menu` only for an intentional custom compatibility override. Pass the same `HostKind` to `FlatDisplaySettings` so its available choices match the shell.

The bottom bar displays at most five equal-width root actions. When there are more roots, the first four remain visible and the rest appear under `More`. `Sheet` opens parent children in a locked theme-synchronized bottom sheet. `MainView` instead replaces the responsive content region between the AppBar and bottom bar with square icon-and-text tiles and one internal scroller. Both modes preserve recursive drill-down, visible Back/Close actions, active state, overflow roots, and leaf navigation; Sheet additionally closes from its backdrop. Because Bottom mode removes the responsive hamburger, its AppBar toolbar explicitly retains balanced `16px` left/right gutters for AppName/PageTitle and trailing actions. Safe-area-aware page padding and FAB offset prevent the bar from covering content, but the bar never alters CRUD modal geometry.

AppBar terminology is fixed: row 1 is `AppName` and row 2 is `PageTitle`. The legacy `Title`/`Subtitle` parameters remain compatibility aliases, but new consumers should use `AppName`/`PageTitle`. At the app-controlled `16px` UI baseline, AppName resolves to approximately `12px` bold and PageTitle to `11px` regular; density presets preserve those ratios.

The global AppBar search is optional. `FlatAppBar.SearchVisible` and `FlatAppShell.SearchVisible` default to `true`; set either to `false` to omit the complete search markup, result list, occupied width, and keyboard focus target. A host can bind this to `OpxFlatUi:Display:AppBarSearchVisible`. Do not use an empty `SearchItems` collection as a visibility switch because the input would remain visible.

Wherever Web global search is visible, size the AppName/PageTitle block from the wider rendered text line and keep a `16px` visual gap before the page/component search field. Cap and ellipsize unusually long titles to preserve responsive actions. Measure the rendered block and search border boxes after route, density, or font-size changes; do not reserve a fixed width or use whitespace characters.

Treat the AppBar search as one composite focus target. Keep the visible focus indicator on `.global-search`; the inner native input remains transparent and must not add its own outline or box-shadow. Verify one clear ring in both Light and Dark/Night.

In the sidebar tree, align each first-level child icon with the start of its parent label. For example, the ERP Overview icon shares the same horizontal coordinate as the `E` in ERP. Keep the child icon-to-text gap compact and stop the dotted branch connector before the icon.

Sidebar leaf links and parent groups support compact semantic badges through `FlatNavigationBadge`. Put the component directly in a `MudNavLink` child body. For a parent, use `MudNavGroup.TitleContent` and keep its plain `Title` populated because MudBlazor uses that value for the underlying button's accessible label.

```razor
<MudNavLink Href="/email" Icon="@Icons.Material.Outlined.MailOutline">
    Email
    <FlatNavigationBadge Text="3"
                         Color="@Color.Error"
                         AccessibleLabel="3 unread messages" />
</MudNavLink>

<MudNavGroup Title="Operations" Icon="@Icons.Material.Outlined.AccountTree">
    <TitleContent>
        <span>Operations</span>
        <FlatNavigationBadge Dot="true"
                             Color="@Color.Success"
                             AccessibleLabel="Operations available" />
    </TitleContent>
    ...
</MudNavGroup>
```

Use a short count or label. Long text truncates rather than widening the drawer. Dot-only badges require `AccessibleLabel`; semantic options use MudBlazor `Color` values. A badge is supplemental UI state only—the host owns the actual count/status and authorization. Badge presence must not change the established icon, text, dotted connector, row height, or expand-chevron positions.

Keep the sidebar search compact but not cramped: the `30px` search control sits inside a `38px` wrapper with `4px` top and bottom padding. This vertical spacing is independent from the navigation tree's icon, text, and connector alignment.

Treat its placeholder as navigation copy rather than a full form hint: use the shared responsive `10-11px` scale at normal `400` weight. Do not change the control height or menu typography to compensate.

Sidebar group labels and ordinary leaf labels both use weight `500` by default. Host applications can configure group and item weights independently through `OpxFlatUi:Display`; values are rounded to the nearest 100 and clamped from 100 through 900.

Nested sidebar geometry follows the same rule at every level. A direct child's icon starts at its parent label's horizontal position, and a deeper sub-child repeats that alignment against its immediate parent label. Nested links retain a compact `2px` icon-to-text gap, while the dotted horizontal connector stops `3px` before the icon. This behavior must remain identical in the desktop drawer and responsive overlay drawer. Keep the tree and collapse wrappers width-bound to their parent, subtract only the current level's indent, and reserve a stable scrollbar gutter in the scroll region. Preserve nested padding and link width when overflow appears, groups enter/leave, or links become active. Expanding a deeper group or navigating to the first child must not resize or shift an earlier sibling child.

Textbox and textarea placeholders, including authentication fields that use placeholders, render `2px` larger than the input's inherited font and use a subtle theme-specific secondary-text mix at full opacity: Light mixes `92%` active secondary text with `8%` white, while Dark/Night mixes it with `8%` black. Empty outlined MudBlazor fields do not necessarily emit an HTML placeholder; their non-floating label is the placeholder-like text inside the control and uses a responsive minimum of `13px`, weight `500`, the same theme-specific placeholder color, plus a `2px` upward optical offset. CRUD entered values and selected combo values retain the `12.5px`/`500` foreground scale, while floating labels remain smaller captions. The offset applies only while the field is empty and unfocused, leaving floating-label position, control height, and padding unchanged.

Outlined floating labels such as `Username / Email`, `Code`, `Category`, and `Phone` are treated separately from placeholders. They use the same library-wide minimum `11.5px` formula on desktop, tablet, and mobile before MudBlazor's `0.75` floating transform. Compact account/settings editors use `Margin.Dense` rather than applying page-specific typography or a fixed CSS height, keeping label, value, outline, adornment, helper/error, and responsive geometry synchronized.

When the responsive sidebar backdrop is visible, the document behind it is inert for pointer interaction and locked against wheel/touch scrolling. The drawer retains its own internal scroll. Backdrop opacity uses the shared display preference rather than a sidebar-only hard-coded alpha.

## Two-step verification integration boundary

A production consumer must implement these concerns outside the UI package:

- issue a cryptographically random, single-use challenge;
- keep codes short-lived and bind them to the pending authentication transaction;
- enforce bounded attempts, resend cooldowns, rate limits, and lock/recovery policy;
- protect against replay and invalidate previous codes when a replacement is issued;
- mask email/phone destinations and never log codes, tokens, passwords, or recovery secrets;
- issue the authenticated session only after server-side verification succeeds;
- define trusted-device enrollment, revocation, logout, and account-recovery behavior;
- expose user-safe errors while logging technical detail under the host security policy.

The sample accepts any six digits locally only to demonstrate the visual state. This behavior is not authentication proof.

## Reset-password integration boundary

The reset sample locally advances from email request to code/password entry. A production consumer must additionally:

- return a neutral request response so account existence is not disclosed;
- issue a random, single-use reset token bound to the account and recovery transaction;
- enforce short expiry, bounded attempts, resend cooldowns, rate limits, replay protection, and prior-token invalidation;
- validate password policy on the server and hash the password with the organization-approved password hasher;
- invalidate applicable sessions/refresh tokens and record a security audit event after a successful change;
- never place passwords, reset codes, or tokens in logs, screenshots, analytics, URLs, or persistent browser storage;
- provide secure recovery and support escalation without weakening identity verification.

The sample clears its transient code and password fields after the visual success transition. It does not change a real credential.

## Responsive validation

- Desktop horizontal mode has no drawer offset and places content below both AppBar and navigation bar.
- Web AppBars with visible global search size the AppName/PageTitle block from the wider rendered line and keep exactly `16px` before the search border box in vertical and horizontal navigation modes.
- Vertical mode retains the reference desktop drawer behavior.
- Child and sub-child icons align with their immediate parent-label starts on desktop and mobile drawers; dotted connectors stop `3px` before each child icon, and computed width/padding remains unchanged across collapsed, entering, entered, and active states.
- Below the Web desktop breakpoint, Horizontal renders the same mobile drawer behavior as Vertical.
- Bottom renders the fixed navigation bar only at phone widths; tablet/desktop renders the reference sidebar fallback.
- A Bottom parent uses the configured child presentation: locked sheet or Main View icon-and-text tiles. Nested groups drill down/back without changing root positions, leaf navigation closes it, and overflow roots remain reachable through `More`.
- Bottom content and FAB clear the bar plus safe area without changing modal geometry.
- MAUI Blazor Hybrid exposes Vertical and Bottom, never Horizontal. Native safe-area, keyboard, lifecycle, and system-navigation behavior still requires emulator/device verification.
- Dropdowns, active states, and Settings controls follow light and dark themes.
- No page-level horizontal overflow appears at representative desktop, tablet, and mobile widths.
- Browser validation does not prove MAUI keyboard, safe-area, system navigation, lifecycle, or secure-storage behavior.
