# Card grid template

Copyright (c) 2026 opx. All rights reserved.

`FlatCardGrid<TItem>` is a generic searchable Grid/List container for member directories, product cards, projects, media, assets, or other card-based collections. `FlatProfileCard` provides the visual card presentation, while `FlatProfileListItem` provides a compact directory row with identity, identifier, secondary role, metadata, host-supplied badges, and an optional navigation chevron.

```razor
<FlatCardGrid TItem="Member"
              Items="@FilteredMembers"
              ItemTemplate="MemberTemplate"
              SearchText="@_search"
              SearchTextChanged="@(value => _search = value)"
              View="@_view"
              ViewChanged="@(value => _view = value)"
              AddText="Add member"
              OnAdd="OpenAddMember" />

@code {
    private RenderFragment<Member> MemberTemplate => member =>
        @<FlatProfileCard Name="@member.Name"
                          Subtitle="@member.Role"
                          Initials="@member.Initials"
                          Stats="@member.Stats" />;
}
```

For a compact people directory, keep the container in List mode and switch the item template:

```razor
<FlatProfileListItem Name="@member.Name"
                     Identifier="@member.Number"
                     Subtitle="@member.Role"
                     MetaText="@member.Department"
                     ImageUrl="@member.PhotoUrl"
                     OnClick="@(() => OpenMember(member))">
    <Badges>
        <FlatStatusChip Text="@member.Category" Color="Color.Secondary" />
        <FlatStatusChip Text="@member.Access" Color="Color.Success" />
    </Badges>
</FlatProfileListItem>
```

## Grid parameters

- `Items` and `ItemTemplate` keep the container domain-neutral.
- `SearchTrailingActions` renders compact show/hide filter controls inside the search field at its trailing edge. Use it for the filter sheet toggle instead of creating a second toolbar row; keep reset/apply actions inside the filter surface.
- `ToolbarActions` remains available for actions that are not part of search/filter interaction. The action container is omitted when no view, overflow, custom, or add action is visible.
- `SearchText` / `SearchTextChanged` expose immediate host-owned filtering.
- `View` / `ViewChanged` support `FlatCardGridView.Grid` and `FlatCardGridView.List`.
- `ShowViewToggle`, `ShowOverflow`, `AddVisible`, and `ToolbarActions` control the one-line toolbar.
- `OnAdd` and `OnOverflow` emit intent only; persistence and authorization remain in the host.
- `EmptyContent`, `EmptyTitle`, and `EmptyMessage` customize the empty result.

## Profile card parameters

`FlatProfileCard` accepts name, subtitle/designation, initials or lazy-loaded avatar URL, optional lazy-loaded cover URL, cover tone, favorite state, reusable statistic pairs, and favorite/more/view callbacks. Missing images fall back to initials and a theme-aware cover.

`FlatProfileListItem` emits only `OnClick`; navigation, authorization, data loading, and mutations remain host-owned. Its row, controls, and badges retain flat zero-radius geometry. `FlatProfileAvatar` remains circular by design because a human identity avatar is a semantic geometry exception, including when rendered inside the compact row.

Desktop uses four cards, reduces to three and two cards at narrower widths, and uses one card below 600px. List mode becomes a compact horizontal row and removes non-essential stats at phone width. The sample page uses a mobile icon-only FAB instead of duplicating the desktop Add button. Data in `/profile-grid` is static page memory and does not prove a user directory or API integration.
