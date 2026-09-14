# FlatSidePanel

`FlatSidePanel<TData>` is a modal dialog anchored to the physical Left or Right screen edge, not an inline `FlatPanel`. It reuses `FlatFormModal` for Back, focus/overlay lifecycle, scroll lock, safe areas and dirty-close confirmation. Header/footer stay fixed; the panel body scrolls. At <=600px the panel fills the width for touch use. Width defaults to420px and is clamped to280–1200px and the viewport.

```razor
<FlatSidePanel TData="ProfileDraft" @bind-Open="panelOpen"
               Title="Edit profile" Side="FlatPanelSide.Right" WidthPx="420"
               Data="profile" CreateDraft="CloneProfile" OnResult="HandleResult" Context="draft">
    <MudTextField @bind-Value="draft.Name" Label="Name" Immediate="true" />
</FlatSidePanel>
```

- `CreateDraft` is required and runs once per opening. The host must clone every nested mutable value; returning the original reference defeats cancel isolation. For immutable data, returning the same instance is safe.
- `Data` is incoming state; `ChildContent` receives the independent draft. Parent re-renders while open do not replace edits. Reopening creates a fresh draft.
- Apply returns `FlatSidePanelResult<TData>(Confirmed: true, Data: draft)`. Cancel, Back and permitted backdrop close return `Confirmed: false` with default Data. Consumers must check Confirmed, especially with value types. Closing by externally setting Open=false does not synthesize a user result.
- Bind `Open`/`OpenChanged`. `OnResult` exchanges typed data with the opener; authorization, persistence and validation remain host-owned. This API does not imply a dialog-service registration or awaitable ShowPanel API.
- `CanApply` controls the primary action; action labels are configurable. `IsDirty` and `ConfirmDiscard` opt into the existing unsaved-change guard. The default IsDirty=false permits draft discard without another question. `CloseOnOutsideClick` defaults true; disabling it leaves explicit Cancel/Back available.
- Content is form-less to avoid nested HTML forms. Save to the backend in the host workflow; the panel returns an edited draft, not a persistence-success claim.

Shared sample: `/crud-simple?preview=side-panel`, left/right buttons, cloned synthetic profile and confirmed/cancelled result. Verify both anchors, scroll/footer reachability, Apply/Cancel/Back, and responsive width. Browser tests do not certify native OS Back/IME behavior.

> Import scope (2.1.31): upstream documentation from `D:\projects\git\mudblazor-flat-ui` at `e7c743d`. New showcase pages, preview launchers, host registrations and upstream test results described here are not automatically installed or certified in this consumer by a package/rules upgrade. Follow the local source map before invoking a route or script.
