# AppBar user menu

> Import 2026-09-24 for NuGet 2.1.42: upstream guidance, examples and historical test reports below are not a claim that new page/host wiring or regression scripts are installed or tested in this consumer. See the local skill reference upstream-2.1.42.md and local source map for scope. Package/current-source CSS matches; native/runtime validation remains separate.

Horizontal navigation typography is independent of the compact UserInfo trigger:
menu labels use max(.8125rem, host UI size * .82759), regular weight and normal
letter spacing. Leaf buttons and dropdown activators stay square regardless of
the global ordinary-button rounding option; keep the active underline straight.

Placement follows navigation mode: Vertical retains existing sidebar identity/Logout.
Horizontal uses `FlatAppShell.AppBarUserContent` for the account dropdown including
Logout, even when its navigation collapses into a mobile drawer. Supplying this slot
suppresses the duplicate sidebar UserContent in Horizontal; Bottom is unchanged.
The samples keep a separate Settings action when the account menu is absent.
Logout in the showcase is a demo intent; real session termination is host-owned.

AppBar UserInfo is optional: set `OpxFlatUi:Display:AppBarUserInfoVisible=false`
in the Web/MAUI host configuration to omit the complete shared account menu.
The compatibility default is true. Direct component consumers can set
`FlatUserMenu.Visible=false`; no trigger, menu, spacing or focus target is rendered.
This does not change sidebar identity, authentication or authorization. Hosts that
hide this menu must provide another entry point for any required account actions.

The sample AppBar hides the device-notification send action by default.
Opt in with `OpxFlatUi:DeviceNotification:ShowAppBarSendButton=true`.
This presentation option does not disable the app inbox, notification service,
or deliberate Settings notification tests, and does not grant OS permissions.

Compose `FlatUserMenu` in `FlatAppShell.AppBarActions` or `FlatAppBar.Actions`.
Supply Name, Subtitle, ImageUrl, Greeting, localized AccessibleLabel, Items and
OnItemClick. Optional ChildContent adds host-specific MudMenuItem entries.

FlatUserMenuItem uses stable Id, encoded Text, optional Icon, Value, Badge,
DividerBefore and Disabled. The host supplies only authorized entries and
handles selection, navigation, account balance, lock and logout. Neither an
entry nor a disabled flag grants permission. The package never changes sessions.

Circular FlatProfileAvatar has an initials fallback. Desktop identity is bounded;
mobile retains the avatar, bounded user name and dropdown chevron; only the
subtitle is hidden. Long names ellipsize in the trigger and wrap in the menu header.
Rows wrap with a 44px minimum hit target. A viewport-bounded, native-scrolling
MudMenu retains library keyboard/overlay behavior. Host Mud providers are required.
Custom activator clicks explicitly call MenuContext.ToggleAsync (MudBlazor9).
Regression tests must click the visible trigger before selecting Logout; calling
OpenMenuAsync directly does not prove the trigger wiring works.

Shared ShowcaseUserMenu is integrated into Web and MAUI AppBars. Settings opens
the existing settings dialog; other example intents show a demo notification,
without navigating or modifying an account. Balance is synthetic.

Included in the local 2.1.36 artifact built on 2026-09-17; the earlier 2.1.35
artifact does not include it. Publication, consumer upgrades, live dropdown visual
verification and native-device verification remain separate steps.
