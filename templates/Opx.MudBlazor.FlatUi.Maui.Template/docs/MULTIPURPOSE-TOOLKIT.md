# Multipurpose operational toolkit

Canonical PageId: `opx.page.reference.enterprise-toolkit`, route `/enterprise-toolkit`. Shared Web/MAUI sample composition: `MultiPurposeExamples.razor` inside the existing Enterprise Toolkit. All records and callbacks in the demonstration are local/in-memory; no API, device command, approval, or durable persistence is implied.

| Priority | Package composition | Host responsibility / remaining boundary |
| --- | --- | --- |
| P0 | Semantic filled-surface auto contrast, first-paint font/density restoration | Audit custom templates; confirm native accessibility and lifecycle |
| P1 | `FlatWorkInbox`: selected current keys, typed actions, per-item outcomes | Authorization, query/filter/paging, confirmations, idempotency, actions/results |
| P1 | `FlatMasterDetailWorkspace` + tabs + `FlatDocumentWorkspace` + `FlatRecordRelations` | Selected record, activity, document access, mutations |
| P1 | `FlatDataFreshnessIndicator` | `ObservedAt`, connection, data quality, current clock and maximum age |
| P1 | `FlatScanInput`: Enter/manual code plus `IFlatScannerAdapter` | Camera permissions, decoder, cancellation cleanup, code lookup and authorization |
| P2 | Existing `FlatOfflineSyncPanel` with `ResolveConflict` callback | Storage/encryption, transport, retry policy, merge; compose existing `FlatConflictResolver` |
| P2 | Existing `FlatScheduler` WorkWeek/Board and Resource on `FlatSchedulerItem` | Shift rules, conflicts, recurrence, timezone, capacity and persistence |
| P2 | `FlatTelemetryPanel`: readings, freshness, alarm acknowledgement, command states, `TrendContent` | MQTT/OPC UA, bounded time-series, limits, safety interlocks and authoritative acknowledgement |
| P2 | `FlatRecordRelations`: explicit edges and exact record selection | Authorized records/edges; no URL navigation or graph queries in the component |
| P3 | `FlatPersonalWorkspace` reuses `FlatDashboardComposer` with favorites/recent shortcuts and `SavedViews` slot | Per-user storage, authorized catalog, existing grid-view provider, navigation and widget data |

## Contrast scope

The canonical JavaScript evaluates rendered backgrounds for `FlatStatusChip`, `FlatNavigationBadge`, filled Mud buttons/chips/badges, FAB, and `[data-opx-auto-contrast]`. It computes linearized sRGB relative luminance and selects whichever of black or white has the greater contrast ratio. For an opaque sRGB result this is at least 4.5:1. Transparent surfaces are composited through actual ancestor backgrounds. Unknown canvas, images/gradients, filters/blending, opacity, disabled controls, and forced-colors are not given a guarantee. Use `data-opx-auto-contrast="false"` on a subtree to preserve intentional custom treatment. Custom filled selected/active templates can opt in explicitly; arbitrary page text is never globally recolored.

Changes are coalesced into animation frames; the observer writes only changed values and does not poll. Test large or high-frequency telemetry screens for workload-specific cost before release. Text embedded inside independently styled custom fragments still needs its own contrast audit.

## Semantics

- Work actions operate only on selected keys still present in `Items`. Results are supplied per item; a successful callback is not proof of backend success.
- Future or missing observations are stale. Online does not imply Good quality. Update `Now` from the host clock when age needs to advance; the component does not start its own timer.
- Command `Sent`/`Accepted` are distinct from `Succeeded`. UI alarm acknowledgement does not stop a machine or clear a backend alarm automatically.
- Scanner adapters must stop camera resources on cancellation/disposal. Codes are bounded, trimmed, and rejected when empty or containing control characters. Scans never automatically open a URL or execute a device command.
- Scheduler, sync, and personal-workspace compositions are shared foundations, not production offline storage or scheduling engines.

## Validation boundary

Use unit/bUnit tests, JavaScript bootstrap/contrast tests, responsive browser checks, and screenshots. Native device proof, full accessibility audit, high-frequency telemetry performance, camera adapters, conflict persistence, and complete production workflows remain host/release acceptance work. Do not mark P0-P3 production-ready from a sample build alone.
