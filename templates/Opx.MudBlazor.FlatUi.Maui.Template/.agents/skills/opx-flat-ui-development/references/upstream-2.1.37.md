# NuGet 2.1.37 guidance import

Source: D:/projects/git/mudblazor-flat-ui at c3d1f91. Official restored DLL metadata confirms the APIs below. Imported documentation describes upstream samples, not newly installed local routes. Preserve the local PageId registry, NuGet-only boundary, Web/MAUI Back separation and pending legacy native safe-area migration.

## Forms and content

- Use FlatFormGrid and FlatFormGridItem for manual forms (opx.page.reference.components; docs/FORM-GRID.md). Twelve-column spans clamp to 1..12 and stack at <=600px. Independent RowGap/ColumnGap clamp to 0..48; defaults follow global spacing. Preserve host InputVariant, intrinsic textarea/helper/error heights and parent-owned WidgetGap. Hosts own forms, validation, draft guards and persistence; metadata forms still use FlatModelForm/FlatSchemaForm.
- External labels use FlatFormField with a unique For matching child InputId. Omit duplicate child floating Label. Horizontal uses a 1:3 label/control split above 600px, stacking below. Required is a visual marker, not validation.
- Compose FlatContentCard over FlatPanel (docs/CONTENT-CARDS.md). Use logical Start/Center/End body alignment, global body padding, 12px internal gap and natural height; absent slots reserve no region. Parent owns outer spacing. Actions never imply authorization or business execution.

## Choice lists

- Use FlatCheckboxList<T> with FlatMultiSelectOption<T>, controlled SelectedValues and comparer semantics; preserve selections outside the visible subset. Icons are decorative. See docs/CHECKBOX-LIST.md.
- ItemContent inside a selection label must be non-interactive phrasing content. Place independent links/buttons outside. Option Text stays the accessible name; ShowCheckboxes=false preserves keyboard access/focus, HighlightSelected is optional, and Bordered controls separators independently.
- Use FlatListGroup<TItem> with trailing FlatStatusChip for badges, and FlatRadioList<T> with nullable SelectedOption for one choice (docs/LIST-VARIANTS.md). Null is not a zero-valued option. Compare by Value and keep native radio names instance-unique. Preserve wrapping 44px targets, visible status text, host permission filtering and persistence.

## User menu

- Read docs/USER-MENU.md. Mobile retains avatar, bounded name and dropdown chevron; only subtitle hides. Full identity remains in the menu header.
- Display.AppBarUserInfoVisible defaults true; FlatUserMenu.Visible=false omits trigger/menu/spacing/focus targets without changing authorization or independent sidebar identity.
- Vertical retains sidebar identity/Logout. Horizontal uses FlatAppShell.AppBarUserContent and suppresses duplicate sidebar UserContent, including mobile. Bottom remains unchanged. Keep Settings independently reachable and logout host-owned.
- Custom activators call MenuContext.ToggleAsync. Test the actual visible trigger (including after reconnect), not only OpenMenuAsync.
- Upstream notification-button opt-in and ShowcaseUserMenu wiring are sample-host changes, not automatic effects of this package upgrade.

## Verification boundary

Official API/signature, consumer builds and audits do not prove browser dropdown, responsive geometry, native keyboard/Back or backend behavior. Do not copy upstream demo claims as consumer test results. New form/card/list preview content has not been imported here.
