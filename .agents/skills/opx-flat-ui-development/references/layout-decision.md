# OPX layout decision contract

Copyright (c) 2026 opx. All rights reserved.

Use this reference when the user asks for a layout, page, screen, dashboard, workspace, form, list, or responsive composition and has not specified the exact visual structure. The agent owns the layout recommendation and acts as UI/UX, business, and data analyst; the user and host remain authoritative for actual business policy, content, data, permissions, and integrations.

## Decide from the job

Choose the layout from the dominant user job and interaction cost, not from isolated keywords:

- Monitoring and triage prioritize exceptions, current status, trends, and drill-down; use dashboard or monitoring composition only when users repeatedly scan and act on changing conditions.
- Finding and managing many records prioritize search, filter, sort, paging, selection, and one primary mutation; use the nearest grid/CRUD archetype with equivalent responsive cards.
- Completing a focused task or high-risk mutation prioritizes field sequence, validation, review, confirmation, and recovery; use a form/editor or operational workspace instead of a dashboard.
- Comparing or analyzing aggregates prioritizes dimensions, measures, grouping, totals, and drill-down; use report or pivot composition instead of decorative charts.
- Browsing public content prioritizes discovery, trust, navigation, and conversion; use the website shell and listing/detail flow rather than the admin shell.
- Editing preferences or account state prioritizes grouped fields, immediate feedback, Save/Cancel, and unsaved-change protection; use the settings/form archetype.

If several jobs exist, choose one dominant page job. Put secondary jobs behind drill-down, tabs, a sheet, or a separate route only when that reduces simultaneous cognitive load and preserves permissions.

## Analyze business and data

- Name the business decision, operational action, or transaction outcome the page must support. A dashboard without a decision or action is not justified.
- Identify data grain, source, owner, freshness, dimensions, measures, units, comparison period, quality gaps, and authorization scope before selecting KPIs or visualizations.
- Choose a chart only when it communicates trend, composition, distribution, relationship, or variance better than a number or table. Keep exact values and underlying records reachable.
- For transactions, map draft, validation, submission/posting, approval, completion, cancellation/reversal, failure/retry, concurrency, and audit states as applicable. The UI may express these states but does not invent or execute host business rules.
- Never fabricate formulas, targets, thresholds, status meanings, accounting effects, or sample values as if they were authoritative. Mark assumptions and placeholders explicitly.

## Compose the layout

Determine these decisions before markup:

1. **Shell and navigation** — Admin, Auth, Website, or System shell; sidebar, horizontal, bottom, or no application navigation.
2. **Information hierarchy** — the first thing users must understand, the primary working region, supporting facts, and details that can be deferred.
3. **Regions** — choose the minimum necessary regions. Avoid two sidebars, duplicate headings, empty action bands, and dashboard cards that merely restate table values.
4. **Actions** — expose one primary action per viewport. Keep frequent contextual actions near their object; hide destructive or infrequent actions behind explicit menus or confirmation without making them undiscoverable.
5. **Responsive transformation** — describe structural change rather than proportional shrinking. Desktop may use columns/table/split panes; tablet may reduce columns or move filters to a sheet; phone uses ordered single-column content, equivalent cards, full-width search, safe areas, and the correct FAB/no-FAB contract.
6. **States** — place loading, empty, error, disabled, success, unsaved, permission-denied, and recovery feedback where the user expects the affected content or action.
7. **Accessibility and input** — preserve semantic order, visible focus, keyboard flow, touch targets, non-color status cues, reduced motion, localization/RTL, and internal rather than document overflow.

## Required layout blueprint

Before implementation, state a compact blueprint in this form:

```text
Layout decision
- User/job: ...
- PageId/archetype: ...
- Shell/navigation: ...
- Desktop: ...
- Tablet/phone: ...
- Actions and states: ...
- Business/data basis: ...
- UX reason: ...
```

Keep it proportional to the request. A small page may need one sentence per line; a complex workspace may need a compact region list. This blueprint is a decision record, not permission to add unspecified business features.

## Clarification boundary

Infer ordinary visual details from the canonical sample and state the assumption. Ask one focused question only when alternatives materially change the user's workflow, data ownership, authorization boundary, destructive-action policy, native/Web behavior, or whether the product uses an Admin, Auth, Website, or System shell. Do not ask the user to choose columns, card placement, breakpoints, padding, or standard responsive behavior already defined by the OPX contract.
