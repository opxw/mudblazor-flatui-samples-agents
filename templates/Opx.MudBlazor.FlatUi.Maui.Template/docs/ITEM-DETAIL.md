# Item Detail sample

FlatProductDetail owns its internal 16px padding on desktop and mobile. At <=900px the gallery and summary stack with a 16px gap; the summary adds no second inset. Preserve native scrolling and intrinsic content height.

Copyright (c) 2026 opx. All rights reserved.

`opx.page.commerce.item-detail` at `/item-detail` is a domain-neutral shared Web/MAUI Showcase page. It reuses FlatProductDetail, FlatProductMetric, FlatProfileAvatar, FlatStatusChip, FlatInfoItem, FlatCollaborationPanel and MudTabs. No new public package component is introduced.

Inspired by the composition of https://themesbrand.com/velzon/html/master/apps-nft-item-details.html without copying its artwork or content. Three original local SVG palettes are selectable by thumbnail or wrapping Previous/Next buttons. Selection has accessible pressed state. Owner avatars remain circular. Desktop uses the existing two-column component; mobile stacks naturally with native page scrolling.

Details and Activity are always present. `?hideReviews=true` omits reviews; `?commerce=true` includes demo reference price and offer-request intent. No countdown is shown without a real host deadline. Reviews use Razor text encoding and local callbacks. Access/offer requests record intent only, never successful access, bids, purchases or payments. Favorites and review data reset on reload.

Host applications own item queries, authorized image sources, formatting, prices/deadlines, permissions, review moderation, audit, persistence and transaction results. Query options are presentation examples, never authorization. Existing browser/shell/native Back history remains untouched; there is no hardcoded Dashboard redirect or guessed parent path. Comment composer drafts retain the existing lifecycle; standalone unsaved-review protection is not added here. Browser proof does not certify native MAUI runtime.

> Import scope (2.1.31): upstream documentation from `D:\projects\git\mudblazor-flat-ui` at `e7c743d`. New showcase pages, preview launchers, host registrations and upstream test results described here are not automatically installed or certified in this consumer by a package/rules upgrade. Follow the local source map before invoking a route or script.
