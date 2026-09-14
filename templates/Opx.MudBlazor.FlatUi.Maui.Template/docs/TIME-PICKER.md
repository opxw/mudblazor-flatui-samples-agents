# FlatTimePicker

Reusable masked time-of-day input with a shared picker modal; not a duration or timezone converter. The host owns the nullable `TimeSpan` value, validation at submission, persistence and timezone interpretation. Values must be in `[00:00:00, 24:00:00)`.

```razor
<FlatTimePicker @bind-Time="startTime" Format="HH:mm:ss" Label="Start time" />
<FlatTimePicker @bind-Time="startTime" Format="hh:mm tt" Label="Start time" />
```

| Format | Mask | Picker |
| --- | --- | --- |
| `HH:mm` | `00:00` | 00–23 hours, minutes; no AM/PM |
| `HH:mm:ss` | `00:00:00` | Hours, minutes, seconds; no AM/PM |
| `hh:mm tt` | `00:00 aa` | 01–12 hours, minutes, AM/PM |
| `hh:mm:ss tt` | `00:00:00 aa` | Hours, minutes, seconds, AM/PM |

`hh:mm` and `hh:mm:ss` automatically append `tt`. Other formats fall back to `HH:mm`; arbitrary .NET format strings are not supported. AM/PM uses invariant English markers, with lowercase input normalized by the mask. `12 AM` is midnight; `12 PM` is noon. Separators and digit counts are fixed by the selected format.

Only a complete valid typed time emits `TimeChanged`; incomplete or out-of-range input shows `InvalidTimeText` and does not overwrite the last host value. Clearing emits null. Hosts must validate submission rather than treating the last emitted value as proof the current text is valid. `Required`, `Error`, and `ErrorText` are forwarded to the field; this component does not supply a typed EditContext `For` expression.

Picker changes are a draft: Apply commits, Cancel/Back/permitted backdrop discard. No nested HTML form is created. The shared modal owns responsive layout and Back behavior. `Disabled`/`ReadOnly` prevent edits and picker opening. Field appearance follows the scoped input variant unless `Variant` is supplied; labels/actions can be localized through parameters.

Changing format is display-only, with no callback or loss of the stored seconds. Picker Apply preserves existing seconds when their selector is hidden. A typed minute-only value explicitly commits seconds as zero. No implicit current-time default is taken: opening an empty picker starts at midnight and Cancel preserves null.

Canonical integration: Calendar (`opx.page.schedule.calendar`) event editor. Shared preview: `/crud-simple?preview=time-picker`, with four inputs bound to one synthetic time. Test `TimePickerTests`; verify actual masked typing, AM/PM and seconds selection separately in the browser. Web evidence does not prove native IME/Back behavior.

> Import scope (2.1.31): upstream documentation from `D:\projects\git\mudblazor-flat-ui` at `e7c743d`. New showcase pages, preview launchers, host registrations and upstream test results described here are not automatically installed or certified in this consumer by a package/rules upgrade. Follow the local source map before invoking a route or script.
