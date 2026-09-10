# FAB shape regression — 2026-09-09

Copyright (c) 2026 opx. All rights reserved.

The global flat reset chained three class-based `:not(...)` exclusions, raising its specificity above the explicit FAB and semantic-circle rules. A FAB with `flat-fab-shape-circle` therefore computed to `border-radius: 0px`.

The exclusions now use `:not(:where(...))`, preserving the reset's shell-level specificity and allowing the existing shape contracts to win. No new API, page-local override, host detection, version bump or publication was introduced.

## Verification

- Release Web sample build: zero warnings/errors.
- .NET suite: 297 passed after updating the source-contract assertion to require specificity-neutral exclusions in all seven shell/portal contexts.
- Repository audit: 66 pages passed; targeted diff whitespace check passed; recursive source/sample Release PDB count zero.
- `fab-shape.spec.ts`: 9 passed across desktop/tablet/mobile projects. Each covers Light/Dark/Auto, no-reload resize, pager clearance and CSS probes for Circle/Square/Extended in admin/auth/website shells.
- Selected existing responsive/refresh tests: 24 passed, including the formerly failing CRUD FAB scenario on all three projects.
- Three additional Email geometry scenarios passed their square-panel/circular-avatar assertions, but stopped at an unrelated heading-font expectation: actual 14.9157px versus expected 15px with 0.05px tolerance. A focused mobile rerun confirmed the same failure. Font styling and that assertion were not changed; subsequent assertions in those scenarios did not execute.
- Visually inspected post-patch Light/Dark mobile screenshots in `artifacts/fab-shape-final-20260909`. Broader run evidence and traces are in `artifacts/fab-radius-patch-20260909`.

This is browser/source evidence. Android/Windows native runtime and a newly packaged NuGet/APK were not verified in this patch.
