# Inline checkbox list

> Consumer import 2.1.37: official package DLL APIs are verified. Historical source-only/older-artifact statements below refer to earlier artifacts, not this baseline. Upstream preview pages, shared menu wiring and host settings are not automatically installed here; local registry and host configuration remain authoritative. No native/live visual certification is implied.

`FlatCheckboxList<T>` renders a labeled group in normal flow, not a dropdown.
It reuses `FlatMultiSelectOption<T>`: Value, Text, optional Icon and Description.
Icons use MudBlazor SVG icon values, are decorative, and can be hidden with ShowIcons.

```razor
<FlatCheckboxList T="string" Label="Modules" Items="@options"
                  @bind-SelectedValues="selected" />
@code {
    private IReadOnlyCollection<string> selected = [];
    private FlatMultiSelectOption<string>[] options =
    [new("docs", "Documents") { Icon = Icons.Material.Outlined.Description }];
}
```

Selection is controlled by the host: commit the returned collection through binding
or SelectedValuesChanged. Existing selections not in the visible options are preserved.
Comparer controls equality and duplicate values; the first duplicate option is shown.
No persistence, authorization or API calls are performed. Hosts supply authorized data.

Disabled disables the group; ReadOnly disables its inputs; ItemDisabled disables
individual options. These presentation flags are not authorization checks.
Label names the fieldset. HelperText is associated with its inputs. EmptyText is
configurable. Rows reserve checkbox/icon space, wrap descriptions and have a 44px
minimum target. Parent composition owns external widget spacing.

Preview: `/components?preview=checkbox-list`, PageId `opx.page.reference.components`.

## Custom content

Use `ItemContent` (`RenderFragment<FlatMultiSelectOption<T>>`) to replace the default
icon/text/description with host Razor content. The option Text remains the accessible
checkbox name. Render non-interactive phrasing content (span, image, avatar) inside
the row label; do not nest links, buttons, inputs or executable/raw untrusted HTML.
Keep separate actions outside this selection label.

`ShowCheckboxes=false` visually hides inputs but retains keyboard access and a
row focus outline. `HighlightSelected=true` adds separated, padded rows with theme
Primary/PrimaryText selection colors. Defaults preserve the original plain list.
This remains multiple selection, not single selection or link navigation. Sample
Custom Content demonstrates avatars, metadata, status and wrapping descriptions.

This addition is source-only, not part of the previously built 2.1.36 artifact.
