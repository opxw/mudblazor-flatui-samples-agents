# Content cards

> Consumer import 2.1.37: official package DLL APIs are verified. Historical source-only/older-artifact statements below refer to earlier artifacts, not this baseline. Upstream preview pages, shared menu wiring and host settings are not automatically installed here; local registry and host configuration remain authoritative. No native/live visual certification is implied.

FlatContentCard composes FlatPanel rather than duplicating header/footer behavior.
Use HeaderTitle or HeaderContent, HeaderActions, Icon/IconColor, Title, Description,
ChildContent, Actions and Footer. All slots are host Razor fragments; plain strings
are encoded. Actions do not imply navigation, payment or workflow permission.

Alignment uses FlatContentAlignment.Start/Center/End (logical, RTL-aware) for the
body. Header/footer retain their own composition. Use a MudButton with FullWidth
inside Actions for the reference-style full-width action.

Body uses global --opx-panel-body-padding, a12px internal gap and natural height.
Parent owns WidgetGap; do not force equal heights, absolute content or duplicate
padding. Empty optional regions do not render. Quotes can use blockquote/cite in
ChildContent. Templates own their interactive callbacks and accessible labels.

Preview /components?preview=content-cards under opx.page.reference.components
shows nine variants in3/2/1 columns. Synthetic sample buttons only notify demo
intent; dismiss examples do not actually remove cards or perform payments.

Source-only addition; previous2.1.36 artifact does not include it.
