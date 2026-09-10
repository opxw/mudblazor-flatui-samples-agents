# Mobile reliability: P0, P1 and P2

## Standalone form keyboard patch (2026-09-09)

Packaging update: included in the official NuGet.org 2.1.22 payload, which matches the canonical same-version repack at `artifacts/nuget/20260909-213441-2.1.22`. The earlier local `20260909-212749-2.1.22` artifact does not contain it. Consumers that restored that superseded local build under the same version must clear/replace that exact cached package before restoring the official package.

`FlatPage` now mounts/disposes the shared visual-viewport keyboard adapter, not only `CrudEditorShell`. Responsive ordinary pages provide temporary trailing keyboard clearance and scroll actual overflow ancestors/document to reveal the focused input. Nested CRUD modals retain their own scroll ownership; pinch zoom is not treated as a keyboard. Account Edit (`opx.page.account.profile-edit`) password fields are covered by `account-keyboard.spec.ts`. Four tablet/phone synthetic viewport cases (account and modal) pass; 304 .NET tests pass. These are browser simulations, not native IME proof. This patch is present in the official 2.1.22 payload.

Canonical PageId: `opx.page.reference.experience-toolkit`, route `/experience-toolkit`.
For native gesture arbitration, non-touch refresh, resume, retry and artifact
evidence upgrades, see [HYBRID-HARDENING.md](HYBRID-HARDENING.md).
Web and MAUI use the shared `MobileReliabilityExamples` composition. These are
additive source contracts; installing an older NuGet artifact does not include them.

## P0 — Refresh and workspace state

```razor
<FlatPage RefreshMode="FlatRefreshMode.Auto" OnRefresh="ReloadAsync">
    @* Shared page content *@
</FlatPage>
```

| RefreshMode | Policy |
| --- | --- |
| Disabled | No Web or native pull gesture, including Dashboard defaults and stale gesture callbacks. |
| Web | Package Web gesture, even inside a native host. |
| Native | MAUI adapter only; unavailable adapter means disabled, not Web fallback. |
| Auto | MAUI adapter when available, otherwise package Web gesture. |
| null (default) | Existing boolean flags and Dashboard compatibility behavior. |

All enabled modes require `OnRefresh`. Explicit mode overrides the legacy flags.
The shared Dashboard Overview explicitly selects Auto: MAUI uses the registered
native RefreshView; Web retains the package's circular native-style indicator.
Native mode renders no duplicate HTML indicator. Web glyph and progress track are
semantic circles protected from the global flat radius rule in every theme.
For packages without this API, an unqualified disable request requires all three:
`NativePullToRefreshEnabled=false`, `PullToRefreshEnabled=false`, and
`DashboardPullToRefreshEnabled=false`. Disabled does not cancel already-running
business work or suppress unrelated manual/programmatic loading. Keep ordinary
scrolling enabled. CRUD overlays suspend eligible refresh until the last overlay
closes; closing them must never override Disabled.

Refresh may claim a downward gesture only when its eligible scroll chain is at
the top. Nonoverflowing cards and list boundaries pass vertical gestures to their
ancestor. Overflowing lists retain internal scrolling. Drag handles/maps keep their
intentional specialized gesture contracts; do not blanket-disable touch defaults.

`FlatWorkspaceState.ScrollPositions` adds named vertical offsets alongside existing
query, page, page size, selected key and filters. `FlatScrollRestoration` captures
and restores a specific scroll owner:

```razor
<FlatScrollRestoration Position="savedTop" PositionChanged="RememberTop"
                       Ready="dataLoaded" ScrollSelector=".records-scroll">
    <div class="records-scroll">@* Bounded, host-composed result list *@</div>
</FlatScrollRestoration>
```

The selector is relative to the wrapper; omit it for document scrolling. Keep it
stable for the component lifetime and use one restoration component per owner.
Restore query/paging and materialize results before setting Ready. Remount when
intentionally restoring another workspace. Missing targets retry on the next
render; invalid selectors do not attach. Offsets are clamped by the browser.
The sample retains list/detail state in memory. Durable route/reload restoration
uses the existing host-owned `IFlatWorkspaceStateProvider`, scoped by user, tenant
and page; clear it on logout/context change. The package does not persist personal
data automatically or fetch records to fill a saved offset.

## P1 — Startup checks, remote search and keyboard

`FlatMobileConfigurationValidator.ValidateOrThrow` checks a host-declared page
catalog for empty/duplicate keys, invalid modes, missing handlers and unavailable
native adapters. Both canonical host startups validate optional
`OpxFlatUi:Mobile:Pages` declarations. An omitted catalog is valid.

```json
{
  "OpxFlatUi": {
    "Mobile": {
      "Pages": [
        { "PageKey": "dashboard", "Mode": "Auto", "HasRefreshHandler": true },
        { "PageKey": "editor", "Mode": "Disabled", "HasRefreshHandler": false }
      ]
    }
  }
}
```

This is validation, not route discovery or automatic parameter binding. The host
must bind each declared mode to its FlatPage and truthfully declare its callback
and native registration. Prefer typed startup catalogs where practical. Explicit
mode takes precedence over old flags rather than reporting their coexistence as
an error. Diagnostics/messages never echo configuration values or secrets.

`FlatLatestSearch<T>` supports bounded debounce (0–2000 ms), cancellation of the
previous request, rejection of stale results even if transport ignores cancellation,
and disposal cancellation. Use one instance per search field and dispose it with
the owner. Expected cancellation is not a user-visible error. `FlatSearchComboBox`
uses it internally without doubling MudAutocomplete's existing debounce. Other
host-driven remote grids/lookups can reuse the helper; the package does not replace
their data transport or apply a universal API query. Authorization, query bounds,
result limits and error handling remain host-owned.

The shared CRUD shell observes VisualViewport below 901px, reduces overlay height
when a keyboard-sized viewport reduction occurs, preserves header/footer and
scrolls the focused field inside the modal body. Pinch zoom is not treated as an
IME. Listeners detach when the modal closes. This adapts to supplied viewport
metrics; actual MAUI keyboard/resize policies remain native-host responsibilities.

## P2 — Development diagnostics

`FlatMobileDiagnostics` renders nothing by default. The host must set
`DevelopmentEnabled` from its trusted environment, never a query string. The Web
sample registers `FlatMobileDiagnosticsOptions` only as enabled in Development;
the MAUI sample leaves diagnostics disabled by default.

The explicit Inspect action shows package version, viewport dimensions, refresh
mode, overlay count, status inset and visible grid/list/modal scroll metrics. It
does not collect field values, route URLs, labels, record contents or transmit
telemetry. Do not expose the diagnostics component in production merely because a
user requests it.

## Regression gates and boundaries

- `RefreshModeTests` and `MobileReliabilityTests`: resolution, native suspension/
  disable, stale callbacks/searches, startup validation, workspace JSON, opt-in diagnostics.
- `mobile-reliability.spec.ts`: live circuit, list/detail scroll restore, mode
  changes, real modal touch and synthetic keyboard viewport geometry.
- `card-grid-scroll-chain.spec.ts`: focused short/overflowing lists and boundary
  handoff in Light/Dark/Auto across responsive widths.

Browser tests and synthetic VisualViewport changes are not Android/iOS/Windows
device proof. Test native Back, IME, safe area, orientation and native refresh on
the target device before release. These gates cover representative owners, not a
claim that every consumer's custom template or CSS has been certified.
