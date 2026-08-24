# Exact Sample Mode

Use this mode whenever the user asks for UI that is `sama`, `persis`, `canonical`, `seperti sample`, `ikuti source of truth`, or otherwise expects visual parity with the OPX sample.

## Canonical baseline first

1. Resolve one `PageId` through `page-registry.md` and open its complete mapping in `sample-source-map.md`.
2. For a new host, create it with `dotnet new opx-flatui-web` or `dotnet new opx-flatui-maui`. Never reconstruct the shell, providers, assets, Settings, navigation, loading gate, or responsive composition by memory.
3. For an existing host, generate a temporary canonical consumer from the matching template. Compare against that generated reference before editing the application.
4. Copy the mapped Razor archetype and the shared components it directly uses as one structural baseline. Preserve component hierarchy, wrappers/classes, regions, action order, responsive representations, breakpoint behavior, state ownership, modal/FAB pattern, typography hierarchy, padding, margins, and gaps.
5. Run the matching audit with `-ExactSample` before adding integration. This establishes that the local baseline is byte-equivalent to the canonical shell/page files after line-ending and template-namespace normalization.

Only after the exact baseline passes may the host replace branding, wording, data, authorization, callbacks, endpoints, identity, permissions, and persistence. Those replacements must use the sample's existing slots and typed callbacks; they do not authorize a visual redesign. If a business requirement genuinely needs a different composition, state the deviation and obtain an explicit decision instead of silently drifting.

## Diagnose application versus package

- First confirm the exact package versions, restored OPX CSS hash, asset order, and absence of local `.flat-*` overrides.
- Generate a fresh canonical consumer using the same package version. Reproduce the same route, theme, viewport, density, font mode, data/state, and navigation mode.
- Compare DOM/component hierarchy, computed styles, bounding boxes, overflow/scroll owners, and screenshots at desktop, tablet, and phone widths. Content values may differ; geometry and behavior may not.
- If the fresh canonical consumer is correct but the application differs, classify it as an application integration drift. Correct the application composition/configuration and do not patch package CSS.
- If the same defect reproduces in the fresh canonical consumer with the verified package asset, classify it as a sample/package candidate and investigate the package source separately.
- A successful build, matching markup tokens, or a single screenshot is not parity proof. The acceptance gate is the canonical audit plus same-state responsive visual/computed comparison.

Record the selected `PageId`, canonical source file, audit result, tested states/viewports, and every intentional deviation in the handoff.
