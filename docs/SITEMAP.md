# Module map / Sitemap

`opx.page.navigation.sitemap` at `/sitemap` adapts the shared host ShowcaseNavigationCatalog into FlatDynamicMenuItem records and validates with FlatDynamicMenuBuilder. Consumer hosts must supply an already-authorized tree with original stable IDs and Url. The synthetic catalog lacks IDs: its adapter hashes full title ancestry, stable under sibling reorder but intentionally not rename/reparent. Duplicate identities fail closed through the builder.

No title-to-route mapping is used. Url passes the package NormalizeUrl used by dynamic menus. Ordinary links preserve browser/shell navigation and Back; the sitemap does not synthesize Bottom-menu submenu entries. Navigating back restores the q query, not a guessed sidebar/bottom trail. Native Back still requires the existing host adapter.

Expansion is an ID set, not row indexes. Search auto-expands only visible matching branches with ancestors, does not mutate the expansion set, and stores q via replace navigation. Clearing search restores the manual expansion state. Invalid/empty trees show feedback. Desktop supports horizontal root columns and vertical mode; <=900px always stacks with native page scrolling and no gesture interception.

Reference: https://themesbrand.com/velzon/html/master/pages-sitemap.html . This sample is a module-map adaptation, not a copy of template assets. Authorization/filtering and endpoint access enforcement remain host-owned; the showcase exposes its synthetic public demo menu only.

> Import scope (2.1.31): upstream documentation from `D:\projects\git\mudblazor-flat-ui` at `e7c743d`. New showcase pages, preview launchers, host registrations and upstream test results described here are not automatically installed or certified in this consumer by a package/rules upgrade. Follow the local source map before invoking a route or script.
