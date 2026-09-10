# IconPicker

Use the existing package component `FlatMaterialIconPicker`; do not duplicate a reflection catalog or modal in consumers. The host must already register OPX/MudBlazor services and render the canonical providers/assets.

```razor
@using Opx.MudBlazor.FlatUi.Components
@using Opx.MudBlazor.FlatUi.Models

<FlatMaterialIconPicker @bind-Value="SelectedIcon"
                        Label="Icon menu"
                        Title="Pilih icon"
                        Placeholder="Belum ada icon"
                        SearchPlaceholder="Cari nama icon"
                        SelectText="Gunakan"
                        CancelText="Batal"
                        EmptyTitle="Icon tidak ditemukan"
                        EmptyMessage="Coba nama icon lain."
                        ShowMoreText="Tampilkan lagi"
                        PageSize="60" />

@code {
    private FlatMaterialIconSelection? SelectedIcon;
}
```

The text parameters are available starting with 2.1.20. `ValueChanged` includes explicit clear (`null`); `IconSelected` is the confirmed non-null selection. Selecting a tile changes only the modal draft; Cancel does not commit it. Persist `Name` and `Style`, not copied SVG. `Icon` is available for rendering with MudIcon. Search matches names case-insensitively; zero matches (including `wiz` with the current catalog) render an empty state. PageSize is bounded to 12–200. Result tiles use stable case-sensitive style/name keys, preserving distinct catalog entries such as AddChart and Addchart. The package provides shared responsive modal styling; native device validation remains separate.

Copyright (c) 2026 opx. All rights reserved.
