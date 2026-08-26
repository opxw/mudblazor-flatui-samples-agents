# Repository agent instructions

Copyright (c) 2026 opx. All rights reserved.

These instructions apply to every file in this repository.

## Required reading order

Before creating or changing a page, layout, reusable component, CSS rule, navigation item, or host configuration:

1. Read the user request and preserve its explicit decisions.
2. Translate it into the user or role, primary job, information hierarchy, action/risk/permission needs, device/input context, required states, accessibility, localization/RTL, and responsive behavior.
3. For a layout request, state the chosen shell, regions/hierarchy, desktop and tablet/phone composition, action placement, states, and UX rationale; infer ordinary OPX layout details when the intent is sufficient.
4. Read the repository root `RULES.md` completely.
5. Read `.agents/RULES.md` completely.
6. Read `.agents/KNOWLEDGE.md` completely; treat it as the portable accepted-decision ledger, not as a replacement for current source or evidence.
7. Read `.agents/PROMPTING.md` and resolve short natural-language prompts without requiring OPX terminology.
8. Use `.agents/skills/opx-flat-ui-development/SKILL.md`.
9. Resolve the request to one stable `PageId` using `.agents/skills/opx-flat-ui-development/references/page-registry.md`, then apply its canonical CRUD/form/grid/state/responsive profile from `showcase-behavior-registry.md`; the user does not need to choose either value.
10. Open the closest matching page under `samples/Opx.MudBlazor.FlatUi.Sample` from the skill's sample source map.
11. Open every reusable component under `src/Opx.MudBlazor.FlatUi` used by that sample before changing its API or behavior.

## Authority and source of truth

- Explicit user decisions have highest authority.
- Root `RULES.md` is the normative product/UI contract.
- `.agents/RULES.md` defines the repository development workflow.
- `.agents/KNOWLEDGE.md` is the repository-local durable decision ledger and must stay synchronized with accepted current contracts.
- `.agents/PROMPTING.md` is the simple natural-language request contract; it keeps OPX/PageId/component decisions agent-owned unless one material workflow question remains.
- `samples/Opx.MudBlazor.FlatUi.Sample` is the behavioral and composition source of truth for page development.
- For initialized admin consumers, `MainLayout.razor` and `SampleSidebarMenu.razor` are the source of truth for the mandatory Settings menu/modal and default searchable sidebar scaffold.
- `src/Opx.MudBlazor.FlatUi` is the API and implementation source of truth for reusable components.
- `docs` and `README.md` explain the implemented contract but do not override compiled source.

When source, rules, and documentation disagree, do not silently choose one. Preserve the accepted behavior, update stale documentation/rules in the same change, and report any unresolved conflict.

## Delivery boundary

- Keep reusable source domain-neutral and keep domain examples in the sample project.
- Preserve copyright headers on new source, scripts, rules, and documentation.
- Preserve unrelated worktree changes. Do not reset, stash, or overwrite user work.
- Do not claim API, authentication, persistence, Cloudflare, IIS, WebSocket, or native MAUI behavior without matching live evidence.
- Build and validate in proportion to the change. Browser responsive checks do not prove native MAUI behavior.
