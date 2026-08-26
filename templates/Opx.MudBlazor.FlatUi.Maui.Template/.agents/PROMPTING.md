# Simple prompting contract

Copyright (c) 2026 opx. All rights reserved.

The user may describe only the business job in ordinary Indonesian or English. They do not need to know OPX component names, PageIds, behavior profiles, routes, breakpoints, padding values, shell variants, grid mechanics, or MAUI host details.

## Minimum useful prompt

Any of these is sufficient to start:

- `buat master supplier`
- `buat form pengajuan cuti`
- `buat dashboard penjualan bulanan`
- `buat daftar invoice yang bisa difilter`
- `buat halaman approval pembelian`
- `buat versi MAUI mobile`
- `samakan halaman profile dengan sample`
- `cek ini bug package atau aplikasi`

Optional context may be added naturally: target user/role, important fields, allowed actions, API/data source, approval rules, or Web/MAUI target. Missing ordinary visual details are inferred from the canonical contract.

## Agent resolution contract

From a short prompt, the agent must infer and state concisely:

1. primary user/job and whether the page is public, authentication, or admin;
2. one canonical PageId and behavior profile;
3. nearest compiled sample/archetype and shell/navigation;
4. information hierarchy, fields/columns, primary/secondary actions, and destructive confirmation needs;
5. desktop, tablet, phone, and MAUI transformation where relevant;
6. loading, empty, error, disabled, success, unsaved, permission, and recovery states;
7. what is package-owned versus host-owned, including data, authorization, persistence, calculations, notifications, and native adapters;
8. verification proportional to the requested change.

Do not return routine UI decisions to the user. Infer standard layout, spacing, panel padding, grid/card switch, form density, button placement, validation presentation, modal geometry, and responsive behavior from `page-registry.md`, `showcase-behavior-registry.md`, and the mapped sample.

Before inventing any local UI or integration mechanism, inspect the supported NuGet public API and mapped canonical sample. Reuse an existing package component, option, callback, service seam, CSS, or JavaScript behavior exactly when available; do not duplicate or override it in the consumer. If no fitting capability exists, do not silently build a substitute: classify the gap as a domain-neutral package suggestion or a host-owned domain/integration/native seam, then present one decision-ready recommendation with impact, priority, compatibility/testing/release boundary, and approval scope. Use `belum terklasifikasi` until package availability and ownership have been inspected.

For a responsive CRUD or list result, default to package `FlatMobileGrid` and the mapped canonical `article.mobile-card` body/footer structure. Never improvise a bare `div.mobile-grid-list`, omit the `mobile-card` root class, or recreate card padding/alignment in consumer CSS. Infer and preserve this without asking the user.

## Safe defaults when the prompt is short

- Use the admin shell unless the words or business job clearly indicate public website or authentication.
- `master`, `kelola`, `management`, or a request to add/edit/delete records selects a CRUD-capable archetype. `form <business record>` defaults to `opx.page.reference.model-crud` when the form persists a normal record; use `model-form-designer` only for a WYSIWYG tool that designs form layouts.
- CRUD/form modal Back defaults to modal first, previous Blazor page second, and native app exit only at the true navigation root. Do not ask the user to choose this routine behavior.
- `daftar`, `list`, or `grid` defaults to a responsive read-oriented grid/list unless mutation is requested. Choose grouped, editable, hierarchy, report, or pivot behavior only when the data/job requires it.
- For responsive/mobile grid toolbars, keep search/filter text visible and default a multi-action icon row to collapsed/hidden (`MobileToolbarActionsExpandedByDefault=false`). Do not ask the user; an initially expanded row requires an explicit request or page need.
- `dashboard` requires decision-oriented KPIs, units, period/freshness, exceptions/trends, and drill-down; never invent formulas or thresholds.
- `approval`, `transaction`, `posting`, `stock`, `journal`, or similar high-risk work keeps lifecycle, permission, validation, review/confirmation, concurrency, reversal/recovery, and audit authority host-owned.
- Use Light theme and the built-in `fluent-blue` color palette by default without asking. Device typography remains default: `UseAppFontSize=false`, ordinary UI inherits the device/browser system font and `1rem` accessibility scale, no custom app font is forced, and Manual remains an explicit `16px` size override. Also preserve canonical navigation/Settings, package CSS, positive panel inset, and standard responsive boundaries.
- Use the package-owned `DefaultRoundedSizePx=7` for ordinary buttons and bottom-sheet top corners; keep other standard surfaces square and never add page-local radius overrides.
- Use package spacing/density preset `Default` (`DefaultDensity="Default"`) unless the user explicitly selects Compact or Comfortable. Never create a `DefaultSpacing` key or replace canonical gutters/panel padding with density-specific page CSS.
- A short request for `navigation Bottom`, `bottom navigation`, or `bottom bar` defaults child and overflow menus to the package `Sheet` presentation (`DefaultBottomNavigationChildPresentation="Sheet"`). Select `MainView` only when the user explicitly asks for an in-content tile view.
- If no backend is provided, build explicit sample/in-memory data seams and state that live API, authentication, persistence, and native behavior are not proven.
- Words such as `sama`, `persis`, `canonical`, `seperti sample`, or `source of truth` activate Exact Sample Mode automatically.

## When one question is allowed

Ask at most one focused question only when the answer materially changes one of these:

- public website versus authenticated admin workflow;
- read-only versus mutation/approval/financial transaction;
- materially different record lifecycle or permission authority;
- Web-only versus a native capability that requires MAUI/device integration;
- two canonical workflows remain equally plausible after inspecting repository context.

Otherwise proceed with explicit, reversible assumptions. Do not ask the user to choose PageId, components, columns for obvious model fields, desktop/mobile breakpoints, padding, modal type, or standard CRUD/grid behavior.

## Expert suggestion contract

When analysis reveals a meaningful usability, accessibility, responsive, business-workflow, data-quality, performance, consistency, or recovery improvement, communicate it proactively under the label **`Saran UI/UX`**. Keep each suggestion decision-ready:

- identify the observed need or risk;
- recommend one concrete canonical change;
- explain the user/business impact;
- mark priority as `Wajib`, `Disarankan`, or `Opsional`;
- identify whether it is inside the requested scope or needs approval.

Do not invent cosmetic suggestions merely to fill a section. Omit the section when no material improvement exists. A suggestion does not silently override an explicit user decision, expand scope, add unsupported business rules, or authorize an external mutation. Contract/security/accessibility defects are `Wajib`; preference improvements are not presented as mandatory.

## Output shorthand

Before implementation, keep the decision summary compact:

`Dipilih: <PageId> · <behavior profile> · <sample>. Asumsi: <only material assumptions>.`

Then implement and validate. For a pure recommendation or diagnosis, provide the selected mapping and evidence without mutating files.

## Defect prompts

For `cek bug package atau aplikasi`, compare an unchanged canonical sample with the consumer on the same supported NuGet version:

- proven package ownership -> **"bug package"**;
- proven consumer/host ownership -> **"bug integrasi aplikasi"**;
- insufficient comparison -> **"belum terklasifikasi"**, followed by the missing evidence.
