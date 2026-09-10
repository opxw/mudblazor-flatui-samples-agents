# Tree Grid

## Sibling and root ordering

Expansion is keyed by item identity, never visible row index. `DefaultExpanded` seeds newly observed nodes only; collapsing all folders, rerendering or reordering existing items must not reset the user's choices. Rows retain keyed DOM identity through reorder.

Set `AllowReorder="true"` only when the host persists ordering. During desktop drag, drop on the top/bottom edge for Before/After; the middle retains Inside (make child). `MoveItem` receives `Position`, `TargetKey`, and `NewSiblingIndex` (zero-based among destination siblings after removing the moving item). Same-parent/root moves now reach this callback. The host must persist parent and sibling order atomically and refresh `Items` in that order; changing ParentKey alone cannot reorder roots. Existing hosts default to `AllowReorder=false` for compatibility. Self/descendant moves remain rejected. Native touch reordering is not added by this option.

Copyright (c) 2026 opx. All rights reserved.

`FlatTreeGrid<TItem,TKey>` displays hierarchical rows from host-supplied `ItemKey` and `ParentKey` selectors. It supports expand/collapse, Web drag/drop, and touch/keyboard-friendly promote/indent actions.

```razor
<FlatTreeGrid TItem="Node" TKey="string"
              Items="Nodes"
              ItemKey="node => node.Id"
              ParentKey="node => node.ParentId"
              TreeTemplate="TreeCell"
              DetailTemplate="DetailCell"
              MoveItem="PersistMove"
              MoveResult="HandleResult" />
```

`MoveItem` receives `FlatTreeGridMoveRequest<TItem,TKey>` with `OldParentKey` and generated `NewParentKey`. Persist that parent key through the host API/database and return the canonical item using `FlatTreeGridMoveResult.Success`. Failed moves do not mutate the source collection.

The component rejects self/descendant moves to prevent cycles. The host still owns authorization, concurrency, validation, ordering among siblings, persistence, audit, and collection refresh. Browser drag/drop is Web evidence only; native MAUI touch reordering requires a host adapter and device validation.

At `900px` and below, the hierarchy becomes a Windows Explorer-style continuous list. Parent nodes use folder icons and chevrons, leaves use file icons, indentation is bounded, child rows retain dotted branch connectors, and details become secondary text. Move actions live in each row's three-dot menu instead of occupying the list surface. Desktop keeps grid columns and Web drag/drop.
