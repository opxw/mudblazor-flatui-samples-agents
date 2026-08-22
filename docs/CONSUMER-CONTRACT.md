# OPX Flat UI consumer contract

Copyright (c) 2026 opx. All rights reserved.

Use the repository template when a new Blazor Web project must reproduce the compiled OPX Flat UI sample. The template carries the sample composition, repository rules, agent skill, NuGet.org configuration, and the versioned consumer contract.

## Create a consumer

From this repository root:

```powershell
dotnet new install .
dotnet new opx-flatui-web -n MyCompany.MyApp
Set-Location MyCompany.MyApp
& .\run-clean.ps1 -PrepareOnly
& .\.agents\skills\opx-flat-ui-development\scripts\audit_flat_ui_consumer.ps1 -ProjectPath .
dotnet build -c Release --no-restore --nologo
& .\run-clean.ps1
```

The generated project remains in public NuGet package mode. Do not replace `Opx.MudBlazor.FlatUi` with a source `ProjectReference`.

## Required workflow

1. Read `RULES.md`, `.agents/AGENTS.md`, `.agents/RULES.md`, and the development skill.
2. Read `flat-ui.contract.json` and keep its package, clean initial-run, stylesheet ownership, runtime HTML attribution, theme, adaptive responsive boundaries, mandatory shell, and widget-spacing baseline values aligned with the installed contract.
3. Resolve the requested UI to one canonical `PageId` in `page-registry.md`.
4. Open the mapped archetype and every shared component it directly uses.
5. Keep the initialized admin shell complete: `MainLayout.razor` must expose the AppBar three-dot menu with `Settings`, its dedicated Application preferences modal, and Light/Dark/Auto choices; it must mount `SampleSidebarMenu.razor` with Dashboard `/`, the initial sample groups, search, and active-route expansion. In the seeded user block, keep the Logout icon last and aligned to the right edge on desktop and responsive drawers, while the avatar and identity copy remain on the left. The initial groups are seed content, not permanent business-menu records; labels, routes, permissions, grouping, identity data, and actual logout/session behavior may be replaced by the consumer while the functional shell geometry remains.
6. Adapt only branding, wording, data, authorization, and domain integration. Start with the Light default theme and preserve composition, responsive behavior, theme tokens, widget padding/margins/gaps, loading, modal, toolbar, grid, and FAB contracts. For widgets, use the parent grid gap and do not add outer margins to individual cards; follow `docs/WIDGETS.md`.
7. Run the consumer audit, Release build, and representative desktop/mobile Light/Dark browser validation.

## Adaptive responsive design

Responsive behavior is a composition contract, not desktop scaling. Keep table/desktop presentation above `900px`, equivalent responsive cards at `900px` and below, two-column cards from `601px` through `900px`, and single-column phone refinement at `600px` and below. Preserve one query, selection, permission, loading, validation, and mutation state across representations. Use viewport/container CSS rather than Android/iOS user-agent checks, perform desktop -> responsive -> desktop live resize without reload, and verify Light/Dark/Auto, browser text scaling, keyboard focus, touch geometry, internal scroll ownership, and zero document-level horizontal overflow. Browser checks do not prove MAUI native behavior.

## CRUD terminology

Use `Edit` consistently for the CRUD edit button, editor-title verb, tooltip, and accessible action name. The template contract does not use `Ubah` for this action, including when surrounding business copy is Indonesian.

## Clean initial run

Use `run-clean.ps1` for the first application start. It resolves the single project in its own directory, deletes only that project's exact `bin` and `obj` directories, restores through the copied `NuGet.Config`, and then runs with `--no-restore`. `-PrepareOnly` performs the clean and restore without launching a long-running server and exists for CI/audit preparation. Do not replace this with a broad recursive cleanup from a parent workspace.

## Stylesheet ownership

- Reusable OPX styling comes only from the restored NuGet static web asset `_content/Opx.MudBlazor.FlatUi/opx-flat-ui.css`. Contract `2.0.10` pins its SHA-256 so a stale or substituted package asset fails audit.
- MudBlazor styling comes only from `_content/MudBlazor/MudBlazor.min.css`. Never copy either package stylesheet into `wwwroot`.
- `wwwroot/app.css` is the canonical source-sample host/domain composition layer, not a fork of reusable package CSS. A newly generated project receives its normalized-LF source-of-truth hash so Windows/Linux line endings do not create false drift. Change it only when implementing deliberate consumer composition, and do not redefine reusable OPX component behavior there.
- The template excludes the unused local Bootstrap distribution. Additional UI-framework packages, stylesheet links, and CSS imports are forbidden.
- `Components/App.razor` keeps theme bootstrap first, then MudBlazor CSS, OPX package CSS, and the canonical host composition stylesheet. Stale `bin`/`obj` static-web-asset manifests cannot be used as visual evidence because the initial launcher removes them.

## Runtime HTML attribution

`Components/App.razor` emits exactly one `<!-- Powered by opx (github.com/opxw) -->` immediately inside `<body>` before `Routes` through an explicit `MarkupString`. This is a non-visible HTML comment that must remain present in the initial runtime response for every route. A literal HTML comment in a Razor file and a Razor comment are both removed during compilation, so source inspection alone is not proof. Do not place secrets, environment details, user data, or dynamic identifiers in this comment.

## Business and data decision contract

For dashboards, reports, layouts, and transaction workspaces, the agent acts as UI/UX, business, and data analyst: identify the user decision or operational action, data grain/source/freshness/units/comparison, relevant KPI or exception, and drill-down path before choosing widgets or charts. Transaction layouts must represent the applicable lifecycle, validation, approval, completion, cancellation/reversal, retry, concurrency, and audit boundaries. The UI must not invent formulas, thresholds, statuses, permissions, accounting effects, or live data; those remain host-owned and assumptions must be explicit.

`flat-ui.contract.schema.json` is machine-readable but does not replace the PowerShell audit. The audit reads the effective restore package folder from `obj/project.assets.json`, then checks project references, package versions, the restored OPX CSS hash, absence of local package-CSS copies/imported UI frameworks, clean-run launcher, host registrations, asset order, baseline options, canonical rules, and the selected archetype.

## Outside the contract

The template may show sample content, but the UI contract does not define or require dashboard status distribution, quick-access actions, user-summary lists, real user names/avatars/roles, logout/session behavior, or the final business menu labels/routes/permissions. Those surfaces belong to the consumer and must be derived from its data, authorization, navigation, and session contracts. The contract covers their reusable visual primitives and shell placement only.

The standard `audit_flat_ui_repo.ps1` entrypoint detects a package-only checkout and delegates to the consumer audit. A source checkout that contains `src/Opx.MudBlazor.FlatUi` continues to run the full library audit.

When the package or UI contract changes, update the schema, manifest, template identity, rules, skill, documentation, and audit together. Generate a fresh consumer and validate it before accepting the change.
