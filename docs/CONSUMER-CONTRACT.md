# OPX Flat UI consumer contract

Copyright (c) 2026 opx. All rights reserved.

Use the repository template when a new Blazor Web project must reproduce the compiled OPX Flat UI sample. The template carries the sample composition, repository rules, agent skill, NuGet.org configuration, and the versioned consumer contract.

## Create a consumer

From this repository root:

```powershell
dotnet new install .
dotnet new opx-flatui-web -n MyCompany.MyApp
Set-Location MyCompany.MyApp
dotnet restore --configfile .\NuGet.Config
& .\.agents\skills\opx-flat-ui-development\scripts\audit_flat_ui_consumer.ps1 -ProjectPath .
dotnet build -c Release --no-restore --nologo
```

The generated project remains in public NuGet package mode. Do not replace `Opx.MudBlazor.FlatUi` with a source `ProjectReference`.

## Required workflow

1. Read `RULES.md`, `.agents/AGENTS.md`, `.agents/RULES.md`, and the development skill.
2. Read `flat-ui.contract.json` and keep its package, theme, breakpoint, mandatory shell, and widget-spacing baseline values aligned with the installed contract.
3. Resolve the requested UI to one canonical `PageId` in `page-registry.md`.
4. Open the mapped archetype and every shared component it directly uses.
5. Keep the initialized admin shell complete: `MainLayout.razor` must expose the AppBar three-dot menu with `Settings`, its dedicated Application preferences modal, and Light/Dark/Auto choices; it must mount `SampleSidebarMenu.razor` with Dashboard `/`, the initial sample groups, search, and active-route expansion. The initial groups are seed content, not permanent business-menu records; labels, routes, permissions, and grouping may be replaced by the consumer while the functional sidebar remains.
6. Adapt only branding, wording, data, authorization, and domain integration. Start with the Light default theme and preserve composition, responsive behavior, theme tokens, widget padding/margins/gaps, loading, modal, toolbar, grid, and FAB contracts. For widgets, use the parent grid gap and do not add outer margins to individual cards; follow `docs/WIDGETS.md`.
7. Run the consumer audit, Release build, and representative desktop/mobile Light/Dark browser validation.

`flat-ui.contract.schema.json` is machine-readable but does not replace the PowerShell audit. The audit also checks project references, package versions, host registrations, asset order, baseline options, canonical rules, and the selected archetype.

## Outside the contract

The template may show sample content, but the UI contract does not define or require dashboard status distribution, quick-access actions, user-summary lists, real user names/avatars/roles, logout/session behavior, or the final business menu labels/routes/permissions. Those surfaces belong to the consumer and must be derived from its data, authorization, navigation, and session contracts. The contract covers their reusable visual primitives and shell placement only.

The standard `audit_flat_ui_repo.ps1` entrypoint detects a package-only checkout and delegates to the consumer audit. A source checkout that contains `src/Opx.MudBlazor.FlatUi` continues to run the full library audit.

When the package or UI contract changes, update the schema, manifest, template identity, rules, skill, documentation, and audit together. Generate a fresh consumer and validate it before accepting the change.
