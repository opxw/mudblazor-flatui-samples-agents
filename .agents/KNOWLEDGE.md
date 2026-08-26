# Repository knowledge

Copyright (c) 2026 opx. All rights reserved.

This repository-local ledger preserves accepted OPX Flat UI knowledge for agents and generated consumers. It travels with the repository. User-folder memory and ChatGPT handoff files are supplementary recall only; they never replace this file, current source, compiled samples, package inspection, Git history, or live/device evidence.

## Maintenance contract

- Read this file after root `RULES.md` and `.agents/RULES.md`, before selecting a PageId or editing UI.
- After an accepted material change to package version, contract, PageId, behavior, showcase, responsive design, diagnosis, or host boundary, update the canonical source/rules/reference first and then refresh the relevant entry here.
- Record durable decisions and verified current state, not conversations, source dumps, secrets, credentials, personal data, assumptions, temporary experiments, or consumer-specific workarounds.
- Reverify drift-prone facts such as NuGet versions, routes, package assets, sample composition, and native runtime behavior. Mark unverified boundaries explicitly.
- If this ledger conflicts with compiled source or normative rules, stop and reconcile the conflict in the same change; do not silently choose or let this ledger override source.

## Current canonical snapshot

- Consumer UI authority: this repository and shared `samples/Opx.MudBlazor.FlatUi.Showcase` composition.
- Reusable UI dependency: public NuGet `Opx.MudBlazor.FlatUi` `2.0.20`; package source checkout is inspection authority only, never a consumer `ProjectReference`.
- MudBlazor baseline: `9.9.0`; consumer contract schema: `3.1`; default theme: Light.
- Default color palette is the built-in package ID `fluent-blue`; Restore returns to it, while an explicitly saved user palette remains authoritative until restored.
- Web and MAUI load the shared Showcase routes/navigation; native-only diagnostics remain host-owned.
- The canonical registry has 76 unique PageIds and routes. Every PageId maps exactly once to one of 45 declared profiles in `showcase-behavior-registry.md`.
- Prompt resolution is requirements/job -> PageId -> behavior profile -> mapped sample/archetype -> implementation. The user does not need to supply PageId, form layout, CRUD mechanics, grid behavior, spacing, or standard responsive transformation.
- `.agents/PROMPTING.md` is the canonical shortcut contract: a short business phrase is enough, routine UI decisions remain agent-owned, and at most one question is asked only for a material workflow/authority/native distinction.
- Package-first reuse is mandatory: inspect the supported NuGet public API and mapped canonical sample, use an existing capability through its public seam, and never duplicate package behavior or assets in a consumer. A verified missing domain-neutral capability is proposed as a package addition; a domain, authorization, persistence, integration, or native need is proposed as a host-owned seam. Package changes and publication require explicit approval.
- When analysis finds a material improvement, report it as `Saran UI/UX` with need/risk, one concrete recommendation, user/business impact, priority (`Wajib`, `Disarankan`, or `Opsional`), and scope/approval boundary. Do not add filler suggestions or silently expand scope.

## Durable UI and behavior decisions

- Exact Sample Mode applies to requests for the same, exact, canonical, sample-matching, or source-of-truth UI. Preserve geometry, hierarchy, responsive transformations, typography, spacing, states, actions, and scroll ownership; adapt host-owned data/integration seams only.
- Responsive CRUD/list cards use package `FlatMobileGrid`, `article.mobile-card`, and the mapped facts/body/footer classes. A bare manual `div.mobile-grid-list`, a classless card article, or local card geometry CSS is forbidden when that package pattern exists; losing the required class is a consumer integration defect because package selectors own padding, hierarchy, alignment, scrolling, and touch behavior.
- Responsive composition uses desktop/table behavior above `900px`, responsive/two-column behavior from `601-900px`, and phone/one-column refinement at `<=600px`, subject to documented component-specific boundaries.
- Content-panel bodies have a positive logical horizontal inset: default `padding-inline:14px` desktop and `12px` at `<=900px`, unless the mapped compiled sample defines another positive value. Edge-to-edge table/media shells may use outer zero padding only when immediate readable children own a positive inset.
- Spacing ownership is singular: parent layout owns gaps, panel body owns inner padding, and widgets do not add compensating outer margins or duplicate padding at the same boundary.
- The initial spacing preset is the package density value `Default`, configured as `OpxFlatUi:Display:DefaultDensity="Default"`. There is no separate `DefaultSpacing` key. Compact/Comfortable remain persisted Settings choices; Restore returns to Default without changing canonical gutters, panel insets, safe areas, or component-specific spacing.
- Ordinary buttons default to a `7px` corner radius through package-owned `OpxFlatUi:Display:DefaultRoundedSizePx`. The same bounded `0-12` token controls bottom-sheet top corners; cards, panels, inputs, dialogs, menus, grids, toolbars, and workspaces remain square. Do not create consumer/page-local radius overrides.
- CRUD uses the visible verb `Edit`, not `Ubah`. Forms preserve validation, dirty-state guard, functional Add/Edit/Save/Cancel/Delete, desktop compact multi-column layout, and mobile one-column/fullscreen editing where appropriate.
- Back behavior is layered and Blazor-first: an open CRUD/form modal consumes the first Back and keeps the route/application alive; the next Back navigates through prior Blazor WebView history. MAUI Android delegates to native Back/app exit only when no package modal/overlay and no prior WebView history entry remain. Package 2.0.20 already owns modal interception; WebView-history fallback is host-owned.
- Grids use compact search, hidden metadata icons, type-aware alignment/formatting, one bounded desktop scroll owner, and equivalent responsive cards/lists sharing query, filter, sort, paging, selection, permission, loading, validation, and mutation state.
- On responsive/mobile search or filter toolbars with at least two secondary actions, the action row defaults to collapsed/hidden because package `FlatPage.MobileToolbarActionsExpandedByDefault` defaults to `false`. The full-width text field and accessible Apps toggle remain visible; desktop toolbar actions remain visible. Initial expansion is opt-in.
- Initialized admin consumers include Settings, default searchable navigation, Light/Dark/Auto preferences, and right-aligned Logout. Root session validation completes before `Router` is created.
- Bottom navigation requests default child/overflow navigation to the package `Sheet` presentation through `OpxFlatUi:Display:DefaultBottomNavigationChildPresentation="Sheet"`. `MainView` is opt-in only; both presentations reuse the same recursive navigation state and neither authorizes routes.
- Default typography means both font ownership and font face stay with the device/browser: `UseAppFontSize=false`, ordinary UI inherits the system UI font stack and `1rem` plus accessibility scaling, and consumers do not bundle, download, or force an app/custom font. Manual is an explicit size override with a `16px` baseline and does not replace the system font family. Package-owned numeric, code, and icon tokens are the only intentional face exceptions; text buttons inherit Device typography and grow or wrap without clipping.
- MAUI keeps that Device typography/button scaling, Toolkit status bar synchronized with AppBar/theme, no native bounce, selectable text only in text-bearing editors, and static-to-interactive `Memuat` loading. Native claims require emulator/device evidence.

## Defect classification vocabulary

- Write the exact phrase **"bug package"** only when an unchanged canonical sample on the same supported NuGet version reproduces a package-owned component/API/CSS/JavaScript defect.
- Write **"bug integrasi aplikasi"** for consumer markup, local CSS, configuration, host service, stale asset, or integration defects.
- Write **"belum terklasifikasi"** when ownership is not proven and state the missing reproduction/comparison. Never infer ownership merely from the visual location of a symptom.

## Canonical detail indexes

- Normative contract: `RULES.md`
- Repository workflow: `.agents/RULES.md`
- Development skill: `.agents/skills/opx-flat-ui-development/SKILL.md`
- Page identities: `.agents/skills/opx-flat-ui-development/references/page-registry.md`
- Interaction/state profiles: `.agents/skills/opx-flat-ui-development/references/showcase-behavior-registry.md`
- Archetype/source ownership: `.agents/skills/opx-flat-ui-development/references/sample-source-map.md`
- Exact reproduction: `.agents/skills/opx-flat-ui-development/references/exact-sample-mode.md`
- Layout decisions: `.agents/skills/opx-flat-ui-development/references/layout-decision.md`
- MAUI deployment: `.agents/skills/opx-flat-ui-development/references/maui-mobile-deployment.md`
- Simple prompts and safe defaults: `.agents/PROMPTING.md`
