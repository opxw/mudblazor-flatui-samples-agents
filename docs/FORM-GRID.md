# Form Grid and Gutters

> Consumer import 2.1.37: official package DLL APIs are verified. Historical source-only/older-artifact statements below refer to earlier artifacts, not this baseline. Upstream preview pages, shared menu wiring and host settings are not automatically installed here; local registry and host configuration remain authoritative. No native/live visual certification is implied.

## Vertical and horizontal forms

`FlatFormField` composes an external label and control slot. Required Label and For
must match the child input's InputId (use unique IDs per instance). Omit the child's
floating Label to avoid duplicate labels. Required adds the visible marker only;
the host must also set Required/validation on its input. Horizontal defaults false;
true uses a1:3 label/control grid above600px and stacks on phone. Multiline controls
and helper/error content retain natural heights; the label aligns near the first line.

Preview `/components?preview=form-layouts` shows Vertical Form and Horizontal Form
using FlatFormGrid for row rhythm and host global InputVariant. Native date/time
inputs here illustrate layout, not FlatTimePicker masking or leave business rules.
Samples validate the required name locally, protect changed drafts and do not
send leave requests. Date ranges, URL/email policy and persistence remain host-owned.

Use FlatFormGrid with FlatFormGridItem children for manual form composition.
The grid has12 columns; Span defaults12 and is clamped1..12. At600px and below
every field becomes full width. Wider compositions can use6/6 or6/4/2 spans.
No fixed input height is imposed; textarea/helper/error content grows naturally.

ColumnGap and RowGap independently override gutters in pixels (0..48). Omit them
for global form spacing (12px fallback,10px phone). Explicit values also apply on
mobile. The parent owns external WidgetGap; panel body owns outer padding.

```razor
<FlatFormGrid ColumnGap="16" RowGap="20">
    <FlatFormGridItem Span="6"><MudTextField T="string" Label="First name" /></FlatFormGridItem>
    <FlatFormGridItem Span="6"><MudTextField T="string" Label="Last name" /></FlatFormGridItem>
    <FlatFormGridItem><MudTextField T="string" Label="Address" /></FlatFormGridItem>
</FlatFormGrid>
```

Use the host's FlatUiPreferencesService.InputVariant for every input. These are
layout containers, not forms or validation/persistence engines: hosts supply
MudForm/EditForm, field binding, validation, submit callbacks and draft guards.
For metadata-driven forms continue using FlatModelForm/FlatSchemaForm instead.

Preview `/components?preview=form-grid`, PageId opx.page.reference.components:
two independently validated synthetic forms, required-name error, text/select
controls, password display demo and a checkbox. Submit never authenticates or
sends data; password is not logged/persisted and is cleared on successful demo
validation. A shared guard protects changed drafts. Do not enter real credentials.

Source-only addition, not present in the existing2.1.36 artifact.
