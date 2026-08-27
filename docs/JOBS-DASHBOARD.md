# Jobs dashboard

Copyright (c) 2026 opx. All rights reserved.

The `/jobs` sample is the admin-side vacancy workspace. It includes KPIs, trend and activity panels, searchable/filterable vacancy cards, a compact create/edit modal, and explicit publish/close/delete actions.

- `FlatCardGrid<JobRecord>` owns the reusable result layout and empty state.
- `FlatJobCard` owns the vacancy card surface.
- `FlatVacancyActions<TJob>` returns exact edit, publication-change, and delete intents.
- `FlatFormModal` owns create/edit composition and responsive modal behavior.
- `FlatPage.PrimaryAction*` renders the canonical desktop action and responsive FAB from one configuration.

All mutations in the sample are page-memory only. A production host owns persistence, authorization, concurrency, audit, public-index synchronization, and deletion policy.
