# P1 / P2 workspace productivity

This is the follow-up to the P0 compatibility gates, not a renumbering of the older multipurpose roadmap. Source-only additions; no release or consumer upgrade is implied.

Canonical PageId: `opx.page.reference.enterprise-toolkit`, route `/enterprise-toolkit`. Shared Web/MAUI example: `samples/Opx.MudBlazor.FlatUi.Showcase/Components/ProductivityExamples.razor`.

## P1: saved views

`FlatGridPreferenceState` retains its existing constructor and adds `Query`, `SearchText`, and `Presentation` (`Auto`, `Table`, `Cards`). Together with `Columns`, a snapshot contains filter tree, sort, grouping, column visibility/order/width, search and view mode. Existing JSON without these properties keeps default behavior.

`FlatSavedViewPicker` accepts `Views`, current `Value`, `ValueChanged` and `SaveRequested`. Callbacks carry detached snapshots, not mutable aliases. It never writes storage itself. Reuse `IFlatGridPreferenceProvider` in the host; include user and company/branch/site scope in the provider implementation. Never share private views across identities or context changes. `FlatGridPreferencesPanel` preserves query/presentation while editing layout; its reset remains a column-layout reset, not an implicit query reset.

The picker rejects schema mismatches for host migration and only lists matching `GridKey` values. Normalize columns against the current authorized column list before applying a snapshot. A saved filter is untrusted presentation input, not query execution permission. Validate field/operator allowlists and schema on the backend too. The demo stores views only in memory and clears them on accepted context change.

```razor
<FlatSavedViewPicker Views="views" Value="view"
                     ValueChanged="ApplyView" SaveRequested="SaveView" />
<FlatGridPreferencesPanel GridKey="orders" Columns="columns" Value="view"
                          ValueChanged="ApplyView" SaveRequested="SaveView" />
```

Apply the same materialized query/search/sort/groups to table and cards. Presentation is a preference, not permission to squeeze a wide table onto a phone: the canonical sample still uses cards at narrow widths. Providers with custom serialization must add the new fields; the package does not migrate host storage automatically.

## P1: context switcher

`FlatContextSwitcher` uses authorized `FlatApplicationContext` tuples supplied by the host. The selector displays company / branch / site together to avoid invalid partial combinations. It does not fetch companies or alter authentication claims.

Set `HasUnsavedChanges` and `ConfirmDiscard` using the shared MessageBox contract. Dirty state without a confirmation callback fails closed. A rejected confirmation keeps the previous context and draft. After confirmation, `ChangeContextAsync(request, cancellationToken)` asks the host to validate and apply the context. Only a successful, still-current response emits `ValueChanged`; disposal cancels and suppresses late updates. The host must enforce permissions server-side and clear/reload caches, selection, views and data after an accepted switch. A cancelled client request does not undo a server mutation.

## P1: advanced filters

`FlatRuleBuilder` supports nested AND/OR `Groups`, typed `Text`, `Number`, `Date`, and `Lookup` fields, inclusive `Between` ranges (`Value` through `UpperValue`), presets and removable active-filter chips. Date values use `yyyy-MM-dd`; numbers use invariant formatting. Lookup values must match supplied options. Nesting is bounded to four levels and 100 total nodes; duplicate condition keys within a group, cycles, invalid enums and malformed ranges are rejected.

`FlatQueryBuilder` emits `FlatQueryDefinition.FilterTree`. **When present, FilterTree is authoritative**: legacy `Filters` is only a flat top-level projection and cannot represent OR, nested groups or upper range values. Existing consumers must explicitly handle FilterTree before adopting the enhanced builder; never silently flatten an advanced query into AND. The sample treats empty groups as no constraint; hosts must define matching semantics consistently.

The builder validates before `RunRequested`; the host must still validate and translate to its own query engine. No SQL, expression compiler, arbitrary endpoint fetch or authorization is implemented. The current editing UI selects one sort/group at a time; snapshots can preserve host-supplied multiple sort/group entries.

## P2: record workspace

`FlatRecordWorkspace<TItem>` composes `FlatMasterDetailWorkspace<TItem>` using `ItemKey` and controlled `SelectedKey`. Replacing/reordering row instances resolves the latest record by key; removing it shows the empty detail state. Keys must be unique and stable.

Supply `DetailContent`, `DocumentsContent`, `ActivityContent`, `ApprovalContent`, and `RelatedContent` templates. Only supplied sections appear, labels can be supplied with `SectionLabels`, and only the selected section mounts. Use existing `FlatDocumentWorkspace`, `FlatAuditTrail`, `FlatWorkflowPanel` and `FlatRecordRelations` in those slots rather than duplicating business UI. The host owns fetch/cancellation, permissions, dirty forms and selection changes. No hidden section is an authorization boundary.

## P2: bulk progress

`FlatBulkOperationProgress` displays host-supplied `FlatBulkItemProgress` per unique record key and aggregate terminal progress. It supports partial success, cancellation intent and `FlatBulkRetryRequest` containing **only failed records with CanRetry=true**. Completed, cancelled and nonretryable failed items never enter retry. Retry is disabled while queued/running work exists or the host is Busy; cancel remains available for active work when enabled. Duplicate/empty item keys disable actions.

The callback does not imply completion or rollback. Host updates `Items`, verifies operation ownership, implements idempotency and cancellation, persists durable results and rechecks authorization. Do not re-run successful records as a bulk retry shortcut. The sample deliberately fails one record, then succeeds only that record on retry; all execution is local simulation.

## Acceptance

- `ProductivityTests`: snapshot/JSON compatibility, column edits, schema boundary, nested range validation, dirty-context accept/reject/disposal, keyed record sections, retry/cancel boundaries.
- `tests/responsive/productivity.spec.ts`: live circuit saved-view restore, guarded context change, record sections and partial bulk retry on desktop/tablet/mobile.
- Use the P0 package-mode gate against the packed DLL; browser and bUnit checks do not prove native MAUI gesture, OS lifecycle, persistence or production authorization behavior.
