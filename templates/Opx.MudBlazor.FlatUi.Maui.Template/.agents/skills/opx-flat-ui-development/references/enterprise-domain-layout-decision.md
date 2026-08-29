# Enterprise domain layout decision

Copyright (c) 2026 opx. All rights reserved.

Read this reference whenever a prompt concerns ERP, HR, finance, inventory, procurement, production, sales, approval, payroll, attendance, employee data, master data, transactions, or another enterprise workflow. It extends the canonical PageId/profile/sample decision; it never replaces them.

## Choose the operating mode first

Identify the user's primary job and select one dominant mode before choosing components:

1. **Overview and decision**: use a dashboard only for named decisions, exceptions, trends, and drill-down.
2. **Work queue**: use a filterable responsive list/grid for triage, assignment, status, due date, and permitted batch actions.
3. **Master data**: use the mapped CRUD archetype for stable reference records, validation, duplicate prevention, and audit-aware mutations.
4. **Transaction or document**: use a header-detail workspace with document identity, lifecycle/status, lines, totals, validation, review, and recovery/reversal boundaries.
5. **Approval or review**: use an exception-first queue plus decision detail, reason/comment, history, authority, and explicit confirmation.
6. **Planning or scheduling**: use calendar, timeline, capacity, or planning workspaces according to time/resource grain.
7. **Analysis or reporting**: use operational report or Pivot according to whether the job is fixed-output monitoring or exploratory analysis.
8. **Setup and governance**: use Settings, policy, matrix, hierarchy, or designer surfaces only when the job changes system configuration or metadata.

Do not combine modes just to make a page look comprehensive. A dashboard is not the default landing surface for a job that is primarily record maintenance or transaction execution.

## ERP decisions

- Identify document lifecycle, header/line/totals structure, status, business date/period, currency, quantity/UOM, responsible party, attachments, approvals, concurrency, audit, cancellation, reversal, and downstream inventory or finance consequences that the UI must expose.
- For purchase, sales, inventory, production, journal, reconciliation, and other controlled transactions, prioritize document identity, status, exceptions, validation, totals, and the next permitted action. Keep rare or risky actions secondary and confirm irreversible intent.
- Use PageId `opx.page.erp.toolkit` when the request needs reusable ERP transaction, lookup, money/quantity, journal, reconciliation, planning, lifecycle, or background-operation UI. Use a narrower registered ERP PageId when the mapped sample already represents the requested module job.
- The package returns typed user intent. The host remains authoritative for posting, fiscal periods, tax/discount, UOM conversion, stock/lot/serial, costing, matching, capacity, approvals, authorization, persistence, concurrency, and audit.

## HR decisions

- Distinguish employee master administration, employee self-service request, manager approval, attendance/timesheet, payroll/compensation, and recruitment before choosing a layout; they have different users, privacy, density, and risk.
- Employee self-service favors a short guided/mobile-first form, clear entitlement or policy context supplied by the host, status, and request history. HR administration favors a denser searchable grid plus controlled editor. Manager approval favors an exception-first queue with employee/request context and explicit approve/reject intent.
- Attendance and timesheet surfaces prioritize period, anomalies, missing entries, approval state, and correction flow. Payroll and compensation surfaces minimize exposure, require permission-gated fields, and prioritize period/status/reconciliation; never invent payroll formulas or expose sensitive values without an explicit role requirement.
- Recruitment administration uses `opx.page.operations.jobs`; a public careers experience uses `opx.page.public.careers-landing`. Do not place a public candidate journey in the admin shell.
- Treat personal, compensation, health, identity, and disciplinary data as sensitive: show the minimum necessary fields, preserve role/permission boundaries, avoid sensitive values in dashboard summaries, and keep policy, retention, consent, authorization, and audit host-owned.

## Enterprise action and layout hierarchy

- Rank actions as primary job completion, frequent secondary work, exceptional/risky action, and navigation. Expose at most one primary create/submit action per viewport and do not give destructive actions equal visual weight.
- Desktop remains compact and data-oriented. Tablet transforms unsuitable tables to the canonical two-column cards or split workspace. Phone uses a single prioritized column, fullscreen editing when mapped, and package Bottom Sheet for secondary filters/actions. Never shrink the desktop composition uniformly.
- Preserve one shared query, selection, permission, loading, validation, and mutation state across responsive representations.
- Include loading, empty, permission-denied, validation, conflict/concurrency, partial failure, success, unsaved, and recovery states that are credible for the selected mode.
- Never invent business formulas, thresholds, approval levels, statuses, permissions, posting effects, retention rules, or live data. State only material assumptions and leave authoritative domain behavior in the host.

## Required decision statement

Before implementation, state:

`Dipilih: <PageId> · <behavior profile> · <sample>. Keputusan bisnis/layout: <user job, operating mode, lifecycle/risk, hierarchy, responsive transformation>. Asumsi: <only material assumptions>.`

Ask at most one focused question only when the answer changes the operating mode, public/admin boundary, mutation or approval authority, sensitive-data exposure, accounting/inventory consequence, or native capability. Otherwise make the canonical layout decision and proceed.
