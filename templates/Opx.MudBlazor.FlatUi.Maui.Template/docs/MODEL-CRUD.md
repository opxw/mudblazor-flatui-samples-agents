# Model-driven CRUD

`FlatModelCrud<TItem>` generates a searchable paged list, responsive mobile cards, and a create/edit modal from a model. `FlatModelForm<TItem>` exposes the generated form separately for custom workflows.

Modal Browser Back, visible Back, Cancel, and permitted outside close run through `FlatUnsavedChangesGuard`. Dirty close opens the shared locked-backdrop Question MessageBox by default. Supply typed `ConfirmDiscard` when the host needs custom wording or policy; rejecting it preserves the draft and modal, while a confirmed close returns result `false` without refreshing the caller.

## Metadata

The default provider reads public writable properties and supports `Display`, `Required`, `Range`, `Key`, `ScaffoldColumn`, `Editable`, `DataType.MultilineText`, and `DataType.Date`. Enums become selects, Boolean values become checkboxes, and numeric values become number inputs. Pass `Fields` when the host needs explicit visibility, options, formatting, width, or getter/setter behavior; explicit metadata takes precedence over reflection.

Generated text, number, date, select, and multiline fields use an outlined floating label by default. The floating caption comes from `FlatModelFieldDefinition.Label` or `Display(Name)`; `Placeholder` or `Display(Prompt)` remains an optional hint inside the field. Required markers remain in the floating caption. Boolean fields intentionally keep an inline checkbox label. Floating captions use the same responsive and high-density typography as the shared CRUD controls in Light and Dark/Night, with a `1.2` line-height that prevents glyph clipping while keeping the line-box center aligned to the outline. The label surface itself is always transparent; a two-pixel pseudo-element matching the control surface masks only the outline directly behind the caption, avoiding a visible rectangular label block.

In a two-column generated form, an inline Boolean checkbox uses the same 4px top rhythm as the adjacent outlined field. Its checkbox glyph and text are vertically centered against the adjacent control, without increasing the grid row height.

Number formatting uses the same `DisplayFormat` or explicit `FlatModelFieldDefinition.Format` contract in the desktop grid, mobile cards, and generated editor. `FlatModelCrud` and `FlatModelForm` resolve the culture from the host-registered `FlatLocalizationOptions` (`OpxFlatUi:Localization:Culture`); only hosts without that registration fall back to `CultureInfo.CurrentCulture`. A formatted editor supplies a decimal numeric keyboard hint, parses with the resolved culture, and assigns the original numeric property type. Without a format, it keeps native `type="number"` behavior.

## Usage

```razor
<FlatPage Kind="FlatPageKind.Module"
          PrimaryActionVisible="true"
          PrimaryActionLabel="Add product"
          OnPrimaryAction="BeginCreate">
    <ChildContent>
        <FlatModelCrud @ref="_crud"
                       TItem="Product"
                       Items="Products"
                       ItemKey="item => item.Id"
                       AddVisible="false"
                       CreateItem="CreateDraft"
                       SaveRow="SaveRow"
                       DeleteItem="DeleteRow"
                       ConfirmDelete="ConfirmDelete"
                       Changed="ReloadAsync" />
    </ChildContent>
</FlatPage>

@code {
    private FlatModelCrud<Product>? _crud;
    private Task BeginCreate() => _crud?.BeginCreateAsync() ?? Task.CompletedTask;

    public sealed class Product
    {
        [Key, ScaffoldColumn(false)] public string Id { get; set; } = "";
        [Required, Display(Name = "Product name", Order = 1)] public string Name { get; set; } = "";
        [Range(0, 999999999), Display(Order = 2), DisplayFormat(DataFormatString = "{0:N0}")]
        public decimal Price { get; set; }
        [Display(Order = 3)] public bool Active { get; set; }
    }
}
```

`SaveRow` returns `FlatGridEditResult<TItem>` containing the canonical persisted item. The host owns API calls, authorization, concurrency, business validation, collection mutation or reload, delete confirmation, audit, and error logging. Closing or cancelling does not mutate the source and does not invoke `Changed`; successful save/delete invokes exact `RowResult` and then `Changed`.

The reflection provider is intended for ordinary flat DTOs. Nested objects, remote lookups, conditional fields, culture-specific editors, and domain workflows should use explicit `FlatModelFieldDefinition<TItem>` metadata or a custom form. Searchable lookups use `FlatModelFieldKind.SearchComboBox`: local `Options` support label, description, keywords, and disabled state; `SearchOptionsAsync` supplies cancellable host-owned API results. Modal lookup fields use explicit `FlatModelFieldKind.Custom` metadata and render `FlatEntityLookup<TLookup>` through the shared `FieldTemplate`; this supports `GridColumnDefinition` table columns, ASC/DESC-only headers, search scoped to the active sorted column with autofocus and letter/number type-to-search inside the modal, stable `ItemKey`, single selection, and checkbox `MultiSelect` while the host maps selected records to model keys. Lookup modal content is form-less so it can safely open inside the CRUD editor form, and modal-history interception closes only the topmost modal. Any field kind may set `EditorTemplate` to replace only that editor with another visual component while preserving the generated form/designer layout wrapper.

Image fields are explicit rather than inferred from a string or byte-array property. Add a `FlatModelFieldDefinition<TItem>` with `Kind = FlatModelFieldKind.ImageUpload`, then provide `FieldTemplate` on `FlatModelForm` or `FlatModelCrud`. The typed `FlatModelFieldTemplateContext<TItem>` supplies the current draft, disabled state, field metadata, and `NotifyChanged`; call `NotifyChanged` after a successful host callback so dirty-state and close confirmation remain correct. Use `FlatImageUpload` inside the template for multiple preview and autoscale behavior. The host still owns upload/persistence and should assign canonical media IDs or URLs to the draft.

```razor
<FlatModelCrud TItem="Product" Fields="ProductFields" ...>
    <FieldTemplate Context="fieldContext">
        <FlatImageUpload Options="ImageOptions"
                         Disabled="fieldContext.Disabled"
                         Upload="@((request, token) => UploadProductImage(fieldContext, request, token))" />
    </FieldTemplate>
</FlatModelCrud>
```

See `/model-crud` in the sample. Its operations are in-memory and do not prove a live API, database transaction, authorization rule, or persistence result.
The page also exposes a collapsible, copy-ready sample that includes the component declaration, DataAnnotations model, and host-owned save/delete callbacks.

## Visual layout design

Use `FlatModelFormDesigner<TItem>` when users or administrators need to reorder generated fields, choose one/two-column spans, hide fields, assign validated CSS class tokens, or configure bounded padding/margin with a live desktop/mobile preview. Native controls, searchable combos, image fields, and `EditorTemplate` visual components all participate in that same layout. Its normalized `FlatModelFormLayoutDefinition` can be passed directly to `FlatModelForm.Layout` or `FlatModelCrud.FormLayout`.

The designer edits presentation only. Host code owns layout authorization, per-user/tenant persistence, versioning, audit, and the stylesheet behind approved class names. See [Visual model form designer](MODEL-FORM-DESIGNER.md) and `/model-form-designer`.
# Operation safety patch — 2026-09-09

Model CRUD operations use a value snapshot per editor session; reverted serializable values are clean, while unsupported/cyclic snapshots stay conservatively dirty after edits. Delete is single-flight starting before confirmation and releases its lock in finally. A committed Save/Delete must never emit a failure result because a later notification/reload callback fails; report the follow-up failure separately. Cover these contracts with ModelCrudOperationRegressionTests and model-crud-revert.spec.ts.

Success RowResult is delivered before Saved/Deleted and Changed callbacks. A follow-up exception leaves the committed outcome intact and shows a separate generic operation warning. Hosts still own idempotency and persistence. This is a source patch, not a published package or a new native-device verification.
