# FlatRibbon

> Consumer import 2.1.36: official NuGet signature and DLL API presence are verified here. References below to local packaging, Showcase integration and previews describe the upstream source, not newly copied consumer pages or live/native verification. Existing local source mappings remain authoritative.

PageId: opx.page.reference.components. Preview: /components?preview=ribbon.

Use a ribbon band for a short status plus optional adjacent content:

```razor
<FlatPanel>
    <FlatRibbon Text="Success" Color="Color.Success">
        Rounded Ribbon
    </FlatRibbon>
</FlatPanel>
<FlatRibbon Text="Info" Color="Color.Info" Position="FlatRibbonPosition.End">
    Rounded Ribbon Right
</FlatRibbon>
```

Text is encoded, not HTML. Start/End follow inherited direction; End is right
in LTR and left in RTL. Rounded defaults true; false gives a square edge.
Class extends the root, ChildContent supplies adjacent content. Theme palette
background and matching text tokens supply colors. Default/invalid colors use Primary.
There is no click callback or interactive badge role; place a real button in
ChildContent when needed.

Label and content remain in normal flow with a 12px gap. With content, label
width is capped at 45% and long words wrap; the row grows naturally. Blank labels
reserve no badge. The parent owns inter-widget spacing through WidgetGap. Ribbon
inner corners are a deliberate scoped exception to the global flat radius rule.
Do not add absolute positioning or overlay arbitrary consumer content.

Included in the local 2.1.36 artifact built on 2026-09-17. The earlier 2.1.35
artifact does not include it. Local packaging does not publish or upgrade consumers.
