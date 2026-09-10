# Dynamic menu

`FlatDynamicMenu` loads and renders an arbitrary-depth navigation tree from flat records:

```csharp
new FlatDynamicMenuItem(MenuText, Id, ParentId, Url, Icon)
```

- `MenuText` is the visible label.
- `Id` is the stable case-insensitive unique key.
- `ParentId` is null for a root or refers to another item.
- `Url` may be an internal route or HTTP(S) target.
- `Icon` accepts a MudBlazor icon value and falls back to a neutral circle.

```razor
<FlatDynamicMenu LoadItems="LoadMenuAsync"
                 Loaded="NavigationReady"
                 Selected="MenuSelected" />

@code {
    private Task<IReadOnlyList<FlatDynamicMenuItem>> LoadMenuAsync(CancellationToken token) =>
        MenuClient.GetItemsAsync(token);
}
```

The component builds recursive hierarchy, expands active ancestors, filters descendants through search, cancels loading on disposal, and exposes `ReloadAsync()`. It rejects missing/duplicate IDs, missing labels, unknown parents, self-parenting, and cycles. The `/dynamic-menu` sample includes explicit level-3 and level-4 paths so deep nesting can be tested visually.

Use `FlatDynamicMenuBuilder.Build(...)` without UI. Use `FlatDynamicMenuBuilder.ToNavigationItems(...)` to feed the resolved structure to `FlatHorizontalNavigation`, `FlatBottomNavigation`, or `FlatAppShell.NavigationItems`.

When API menu labels must map to routes owned by a Web/MAUI consumer, use the same domain-neutral resolver in both hosts:

```csharp
IFlatNavigationRouteResolver resolver = new FlatNavigationRouteResolver(
    new Dictionary<string, string>
    {
        ["MYPROFILE"] = "/me/profile",
        ["MYTEAM"] = "/team/members"
    });

var route = resolver.Resolve(apiItem.DisplayName, apiItem.Url);
```

The consumer dictionary has precedence over the supplied fallback URL. Labels are normalized with Unicode compatibility normalization, format/zero-width removal, alphanumeric filtering, and invariant uppercase. Fallbacks accept local routes and absolute HTTP(S) URLs; empty values, fragment-only placeholders, protocol-relative URLs, `javascript:`, `data:`, and other schemes are rejected. Duplicate normalized labels or unsafe dictionary values fail during resolver construction. Keep business route names and authorization policy in the consumer; the package does not infer route permissions from menu visibility.

For phone Bottom navigation, configure `BottomNavigationChildPresentation` from the persisted display preference. `Sheet` remains the default; `MainView` presents each resolved child level as icon-and-text tiles in the main content region. Both consume the same recursive `FlatNavigationMenuItem` tree and preserve exact leaf URLs.

The host owns endpoint authentication, authorization filtering, ordering, localization, tenancy, caching, retry policy, logging, and route permission enforcement. Hiding a menu is not authorization. `/dynamic-menu` uses in-memory sample data and does not prove an API or permission integration.
# Cross-platform URL normalization

The resolver and dynamic menu builder share `FlatNavigationRouteResolver.NormalizeUrl`. Normalize Unicode/format characters first, reject protocol-relative URLs and any backslash, accept single-leading-slash local routes before absolute URI parsing, then allow only HTTP(S) absolute URLs. This prevents Unix/Android file-URI classification from dropping local menu routes. No business mapping is required: dynamic `Url` fields remain the source.

`NavigationUrlRegressionTests` covers direct builder input and resolver-to-builder-to-navigation composition, including Unicode, unsafe URLs and idempotency. A dedicated Ubuntu CI job runs without MAUI workload restore. The source records a 320-test Windows run; that is upstream evidence. This consumer restores the signed NuGet.org 2.1.23 package. Linux CI and Android emulator behavior require their own evidence and are not established by a Windows consumer build.
