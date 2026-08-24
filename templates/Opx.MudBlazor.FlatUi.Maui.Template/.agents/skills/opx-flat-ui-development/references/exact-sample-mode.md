# Exact Sample Mode

Use this mode whenever the user asks for UI that is `sama`, `persis`, `canonical`, `seperti sample`, `ikuti source of truth`, or otherwise expects visual parity with the OPX sample.

## Canonical baseline first

1. Resolve one `PageId` through `page-registry.md` and open its complete mapping in `sample-source-map.md`.
2. Create a host with `dotnet new opx-flatui-web` or `dotnet new opx-flatui-maui`. For an existing host, generate a temporary canonical consumer before editing the application.
3. Copy the mapped Razor archetype and its directly used shared composition. Preserve hierarchy, wrappers/classes, regions, action order, responsive representations, breakpoints, state ownership, modal/FAB pattern, typography, padding, margins, and gaps.
4. Run the matching audit with `-ExactSample` before integration. The audit normalizes line endings and the generated template namespace.

Only after this exact baseline passes may the host replace branding, wording, data, authorization, callbacks, endpoints, identity, permissions, and persistence through existing seams. Any genuine visual deviation requires an explicit decision.

## Diagnose application versus package

- Verify package versions, restored OPX CSS hash, asset order, and absence of app-local `.flat-*` overrides.
- Reproduce the same route, theme, viewport, density, font mode, state, and navigation mode in a fresh canonical consumer.
- Compare DOM hierarchy, computed styles, bounding boxes, overflow/scroll ownership, and screenshots at desktop, tablet, and phone widths.
- If the fresh reference is correct, classify the difference as application integration drift. If the same defect reproduces in the fresh reference, investigate it as a sample/package candidate.
- Build success or one screenshot is not parity proof; require the canonical audit and same-state responsive comparison.

Record the PageId, source file, audit result, tested states/viewports, and intentional deviations in the handoff.
