# Digital marketplace landing

Copyright (c) 2026 opx. All rights reserved.

PageId: `opx.page.public.digital-marketplace`; route: `/nft-landing`.
Canonical source: shared Showcase `Components/Pages/NftLanding.razor` under `WebsiteLayout`.

Inspired by the section structure of the Velzon NFT landing reference, not its source or artwork. Original schematic SVG previews require no remote media, scripts, or wallet SDKs.

Includes hero, section navigation, six demo collections, category/favorite filtering, expandable details, process cards, fictional creators and CTA. Favorites exist only in the mounted page instance and reset on navigation/reload. Category and favorite state are shared through viewport resize. Detail disclosure is inline, not a separate route or modal.

Reuses FlatCatalogGrid/Card and circular FlatProfileAvatar. Desktop has three catalog columns, tablet two, phone one, with natural scrolling. This is a sample composition, not a new public package API. Authentication, verified identity, licensing, price, availability, publishing, wallet connection and transactions are intentionally not implemented.

> Import scope (2.1.31): upstream documentation from `D:\projects\git\mudblazor-flat-ui` at `e7c743d`. New showcase pages, preview launchers, host registrations and upstream test results described here are not automatically installed or certified in this consumer by a package/rules upgrade. Follow the local source map before invoking a route or script.
