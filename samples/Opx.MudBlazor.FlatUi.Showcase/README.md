# OPX Flat UI shared showcase

This Razor Class Library is the single source of truth for showcase pages, public/auth layouts,
sample services, navigation metadata, sample-code snippets, and showcase styling.

Both `Opx.MudBlazor.FlatUi.Sample` (Web) and `Opx.MudBlazor.FlatUi.MauiHost.Sample` (MAUI
Blazor Hybrid) load this assembly through `Router.AdditionalAssemblies` and consume
`ShowcaseNavigationCatalog`. Host projects own only their runtime shell and adapters. MAUI-only
capabilities such as status bar, local notification, camera, file picker, share, native
pull-to-refresh, and session bootstrap remain in the MAUI host.

Do not copy shared pages back into either executable host. Add or revise a showcase page here,
update the page registry/source map, and validate both hosts.
