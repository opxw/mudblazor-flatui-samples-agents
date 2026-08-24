# OPX MudBlazor Flat UI

[![NuGet](https://img.shields.io/nuget/v/Opx.MudBlazor.FlatUi?label=NuGet&color=005f91)](https://www.nuget.org/packages/Opx.MudBlazor.FlatUi/2.0.17)
![.NET](https://img.shields.io/badge/.NET-10.0-512BD4)
![MudBlazor](https://img.shields.io/badge/Powered%20by-MudBlazor-594AE2)
![Web and Mobile](https://img.shields.io/badge/ready-Web%20%2B%20MAUI%20Hybrid-0A7B83)

OPX Flat UI is a NuGet-first UI reference and project template for responsive Blazor Web and .NET MAUI Blazor Hybrid applications. It combines reusable flat operational components, canonical application composition, responsive navigation, theme-aware behavior, and auditable consumer rules.

**Web ready. MAUI Hybrid ready by contract. Powered by [MudBlazor](https://www.mudblazor.com/).**

The reusable component API and original CSS are delivered by [`Opx.MudBlazor.FlatUi`](https://www.nuget.org/packages/Opx.MudBlazor.FlatUi/2.0.17). This repository owns the canonical consumer composition, sample pages, project template, rules, skills, documentation, and validation gates.

## Web preview

### Vertical navigation

Vertical is the default operational layout. It provides a searchable grouped sidebar, route-aware expansion, status badges, the mandatory Settings entry, and a right-aligned Logout action.

![OPX Flat UI Web dashboard with Vertical sidebar](docs/images/opx-flat-ui-web-vertical.jpg)

### Horizontal navigation

Horizontal is optimized for desktop Web. It moves the product identity and module navigation into a compact menu bar while retaining the same routes, permissions, theme, and page state.

![OPX Flat UI Web dashboard with Horizontal navigation](docs/images/opx-flat-ui-web-horizontal.jpg)

## Mobile preview

The mobile composition is responsive, touch-aware, safe-area ready, and designed for both mobile Web and MAUI Blazor Hybrid. Tables can become equivalent cards, dialogs become full-screen editors, and controls retain usable touch geometry.

<table>
  <thead>
    <tr>
      <th>Responsive mobile view</th>
      <th>Phone Bottom bar</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><img src="docs/images/opx-flat-ui-mobile.jpg" alt="OPX Flat UI responsive mobile dashboard" width="390"></td>
      <td><img src="docs/images/opx-flat-ui-mobile-bottom-bar.jpg" alt="OPX Flat UI mobile Bottom navigation" width="390"></td>
    </tr>
  </tbody>
</table>

Bottom navigation reuses the same route tree as the other layouts and is selected from viewport width alone. The package default threshold is `600px`; this template explicitly uses `900px`, so tablet and phone widths receive the bottom bar while wider Web and Windows desktop windows receive the sidebar. It supports up to five root actions, a More entry for overflow, recursive child navigation, and safe-area spacing.

Package `2.0.17` keeps labels such as **Settings** fully readable by using a descender-safe `1.25` line-height plus a `1px` bottom inset. Single-line ellipsis and the `60px` bar height remain unchanged; consumer CSS does not override this package-owned geometry.

## Special features

- **Three responsive navigation modes** — Vertical sidebar, Horizontal desktop menu, and viewport-aware Bottom navigation from one route tree.
- **Adaptive data presentation** — `FlatDataGrid` desktop tables and equivalent tablet/mobile cards preserve one query, filter, sort, paging, selection, permission, and loading state.
- **Operational dashboards** — compact KPI widgets, charts, activity feeds, status chips, summary lists, quick actions, and responsive panel composition.
- **CRUD and transaction workspaces** — responsive editor shells, full-screen mobile forms, dirty-state protection, entity lookup, bulk actions, approval flows, and host-owned persistence boundaries.
- **Advanced reusable surfaces** — Pivot, Kanban, Chat, Email, command palette, schema-driven forms, editable grids, audit trail, collaboration, conflict resolution, document workspaces, import, calendar, and notification samples.
- **Theme and display preferences** — Light default, Dark / Night, Auto, multiple palettes, density presets, Device or Manual typography, configurable backdrop, and controlled corner sizing.
- **Shared loading system** — responsive initial skeletons, AppBar operation progress, `FlatReconnectModal`, and the mandatory MAUI `Memuat` spinner using the same package-owned visual.
- **Secure startup presentation** — `FlatSessionRestore` blocks protected UI while the host validates an untrusted saved-session hint. Local storage is never the authorization authority.
- **MAUI system integration contract** — AppBar-synchronized Android/iOS status bar, Device typography, accessibility-scaled text buttons, safe areas, lifecycle resynchronization, and native verification gates.
- **Native interaction rules** — normal scrolling without WebView bounce/edge glow, dedicated pull-to-refresh, and text selection limited to textbox-class inputs and editors.
- **Package-owned reusable CSS** — consumers load `_content/Opx.MudBlazor.FlatUi/opx-flat-ui.css`; host CSS remains limited to application/domain composition.
- **Auditable output** — versioned JSON schema, consumer audit script, source mapping, responsive rules, Release build checks, and fresh-template validation.

Business data, formulas, permissions, authentication, persistence, integration, transactions, and server-side authorization remain owned by the consuming application.

## Navigation modes

| Mode | Intended surface | Behavior |
|---|---|---|
| **Vertical** | Web desktop, tablet fallback, responsive drawer | Searchable grouped sidebar with active-route expansion. |
| **Horizontal** | Web desktop only | Compact product/menu bar with module dropdowns. |
| **Bottom** | Responsive Web, MAUI Hybrid, and resized Windows EXE | Package threshold defaults to `600px`; this template uses `900px`, with sidebar fallback above it. |

Navigation, theme, palette, density, and typography are available from the mandatory **Settings → Application preferences** surface.

## Package baseline

| Dependency | Version |
|---|---:|
| `Opx.MudBlazor.FlatUi` | `2.0.17` |
| `MudBlazor` | `9.8.0` |
| MAUI mobile template | `10.0.90` |
| `CommunityToolkit.Maui` | `15.0.1` |
| Target framework | `.NET 10` |
| Consumer contract schema | `3.1` |

Install the public package from NuGet.org:

```powershell
dotnet add package Opx.MudBlazor.FlatUi --version 2.0.17
```

## Create a consumer project

Install or refresh the repository template:

```powershell
dotnet new install . --force
```

Create a NuGet-only consumer:

```powershell
dotnet new opx-flatui-web -n MyOpxApp
Set-Location MyOpxApp
.\run-clean.ps1
```

The first run cleans project-local `bin` and `obj`, restores from NuGet.org, and starts with the canonical Light theme, Settings menu, default sidebar, package-owned CSS, responsive rules, and runtime OPX attribution.

Audit a generated consumer before accepting its output:

```powershell
.\.agents\skills\opx-flat-ui-development\scripts\audit_flat_ui_consumer.ps1 . -ExactSample
dotnet build -c Release --no-restore
```

Create the canonical Android/iOS MAUI Blazor Hybrid consumer:

```powershell
dotnet new opx-flatui-maui -n MyOpxMobileApp
Set-Location MyOpxMobileApp
.\run-clean.ps1 -PrepareOnly
.\scripts\audit_maui_consumer.ps1 -ExactSample
dotnet build -f net10.0-android -c Release --no-restore
```

The MAUI template pins MAUI `10.0.90`, CommunityToolkit.Maui `15.0.1`, MudBlazor `9.8.0`, and OPX Flat UI `2.0.17`. It includes the native status-bar bridge, root-before-`Router` authorization gate, continuous `Memuat` spinner, Settings, default sidebar/Bottom navigation, Device typography, no-bounce WebView handlers, textbox-only text selection, package-only reusable CSS, a machine-readable mobile contract, and its audit script. Replace the sample authorization validator and sample business data before production use.

When a prompt requests UI that is the same, exact, canonical, or matches the sample/source of truth, use **Exact Sample Mode**. Generate a fresh Web or MAUI template, resolve the `PageId`, and pass `-ExactSample` before wiring host data or services. The audit rejects drift in canonical shell/page files; branding, wording, data, authorization, callbacks, and persistence may then change through existing seams without changing geometry or behavior.

## Repository map

- `samples/Opx.MudBlazor.FlatUi.Sample` — compiled composition reference and template content.
- `.agents/skills/opx-flat-ui-development` — UI/UX, business/data analysis, implementation, responsive, Web, and MAUI rules.
- `docs/CONSUMER-CONTRACT.md` — consumer ownership and integration contract.
- `RULES.md` and `.agents/RULES.md` — mandatory implementation rules.
- `flat-ui.contract.json` and its schema inside the sample — machine-readable baseline enforced by the audit.
- `templates/Opx.MudBlazor.FlatUi.Maui.Template` — Android/iOS Blazor Hybrid source-of-truth template, mobile contract, and native audit.
- `samples/Opx.MudBlazor.FlatUi.MauiHost.Sample` — executable NuGet-only Android/Windows host reference for startup gating, native adapters, and edge-to-edge AppBar/status-bar integration.
- `docs/MAUI-HYBRID-HOST.md` — ownership, startup, responsive navigation, native status-bar, build, and device-evidence contract for the host sample.

## Web and MAUI evidence boundary

The screenshots above are captured from the real local Blazor Web sample at representative desktop and phone viewports. They prove the rendered Web composition and responsive CSS at capture time.

The repository now includes a real Android/iOS MAUI Blazor Hybrid template in addition to the Web template. A successful Android compile proves source/package compatibility only. Status-bar appearance, safe areas, keyboard/IME, system back, lifecycle, suspend/resume, no-bounce WebView behavior, native text selection, and the `Memuat` bootstrap transition still require representative emulator or physical-device validation; iOS build and runtime validation require macOS/Xcode.

---

**OPX Flat UI — Web and MAUI Hybrid ready. Powered by MudBlazor.**
