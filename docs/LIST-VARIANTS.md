# List groups, badges, checkbox and radio rows

> Consumer import 2.1.37: official package DLL APIs are verified. Historical source-only/older-artifact statements below refer to earlier artifacts, not this baseline. Upstream preview pages, shared menu wiring and host settings are not automatically installed here; local registry and host configuration remain authoritative. No native/live visual certification is implied.

Canonical preview: `/components?preview=checkbox-list`, PageId
`opx.page.reference.components`. ListVariantsPreview composes three responsive
panels (3 desktop, 2 tablet, 1 phone), using parent-owned WidgetGap.

- `FlatListGroup<TItem>`: semantic ul/li with required ItemContent and optional
  TrailingContent. Use FlatStatusChip in the trailing slot for priority or counts.
  It is presentation only; no implicit selection or navigation.
- `FlatCheckboxList<T>`: Bordered=true adds contiguous rows with separators
  independently of HighlightSelected. SelectedValues remains multiple selection.
- `FlatRadioList<T>`: Items reuse FlatMultiSelectOption<T>. Bind SelectedOption
  and SelectedOptionChanged for exactly one choice. Null represents no selection,
  including value types such as int where zero is a valid option. Compare options
  by Value with optional Comparer, not record identity. Each instance has a unique
  native radio name, so keyboard arrows and groups stay independent.

Radio supports optional icons/descriptions, ItemContent, group Disabled/ReadOnly,
ItemDisabled, localized Label/EmptyText and Class. Bordered defaults true.
Custom radio content must follow checkbox label restrictions: non-interactive
phrasing content only. Keep independent buttons/links outside selection labels.

Hosts own permission filtering, data, mutation and persistence. Samples are inert
demo selections. Text/status remain visible rather than relying only on color.
Rows wrap with a 44px minimum target and 10x16px inset. Native radio circles are
an intentional semantic exception to flat geometry.

Source-only addition; not included in the previous 2.1.36 artifact.
