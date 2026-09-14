# FlatMediaObject

Copyright (c) 2026 opx. All rights reserved.

Presentation-only media/content composition, previewed in `/components` (opx.page.reference.components). `MediaContent` accepts an avatar, image, icon or host fragment. `ChildContent` accepts text, controls or nested FlatMediaObject. Optional `Title` is encoded text, not HTML.

`Side`: FlatMediaSide.Start (default) or End, logical and RTL-aware. `Alignment`: FlatMediaAlignment.Top (default), Center or Bottom. Unknown enum values fall back to Start/Top. `Gap` defaults to 12px, clamped to 0–48. `Class` supports host composition.

Media occupies at most 40% of the row and keeps intrinsic dimensions; body wraps within remaining space. No fixed row height, border, surface, click handler or scroll interception is added. Missing media creates no empty slot. Keep deep nesting shallow on phones. End changes visual order only: DOM/focus order remains media then body, so avoid misleading keyboard order with interactive media.

Use FlatProfileAvatar for circular identity images. Provide alt text for meaningful images and labels for controls. Host owns data, authorization and all child callbacks.

```razor
<FlatMediaObject Title="Activity" Alignment="FlatMediaAlignment.Center">
    <MediaContent><FlatProfileAvatar Name="Demo User" Initials="DU" Size="40" /></MediaContent>
    <ChildContent><p>Host-supplied activity description.</p></ChildContent>
</FlatMediaObject>
```

> Import scope (2.1.31): upstream documentation from `D:\projects\git\mudblazor-flat-ui` at `e7c743d`. New showcase pages, preview launchers, host registrations and upstream test results described here are not automatically installed or certified in this consumer by a package/rules upgrade. Follow the local source map before invoking a route or script.
