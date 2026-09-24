# Guidance import for the 2.1.42 consumer

Imported 2026-09-24 from the working tree at D:/projects/git/mudblazor-flat-ui, based on c3d1f91. This is a guidance-only import, not a package upgrade or sample/native-host migration.

## Chat

Use PageId opx.page.assistant.ai-chat and docs/CHAT-CONTENT.md. FlatChatShell.SidebarVisible=false (source contract since 2.1.39) removes sidebar, reserved column and history Back; the thread stays open at all widths. HeaderVisible=false (since 2.1.40) also removes header and its row/actions. Both default true. Preserve host messages/drafts and provide required app/route/native navigation independently.

Canonical upstream AiChat.razor uses full available width with 2px top/inline clearance, preserving inner chat padding and native safe areas. This is an explicit AI Chat composition exception, never a global page-gutter/fullscreen rule. The local /ai-chat route exists, but the new ?single=true wiring and upstream page composition were not copied by this import.

## Scroll boundaries

- At <=900px, package MAUI table/data-grid/chat-table wrappers chain vertical boundary gestures to the nearest scrollable ancestor. Horizontal containment and ancestor modal/chat/root locks remain. Desktop and ordinary Web are unchanged; viewport width alone must never identify MAUI. Do not synthesize forwarded gestures.
- For opx.page.operations.asset-crud, use docs/SHARED-CRUD-DRAFT-GUARDS.md. CrudEditorShell scroll/clip owner is DIV .crud-editor-body; inner .crud-editor-fields is the disabled/grid fieldset. Keep header/footer outside the body, preserve padding/gaps/nested scrolling and verify hit-testing below the clip boundary. Never restore a scrollable grid fieldset as the clipping owner.
- Blocking overlays lock html overflow, not both root and a height-constrained body. Preserve document extent/scroll position, MudBlazor lock-class lifecycle, nested locks and background wheel lock. Package-owned neutralization of body's scroll-locked variants must not unlock the root. Never compensate using delayed scrollTo or restore unrelated positions after route changes.

## Horizontal navigation

Read docs/USER-MENU.md and docs/HYBRID-SAFE-AREA.md. Horizontal labels use max(.8125rem, host UI size * .82759), regular weight/normal spacing, independent of compact account typography. Menu leaf/dropdown buttons and active underline stay square regardless of ordinary-button rounding.

At native widths >=1200px, the Horizontal row starts after 60px AppBar plus resolved top inset; content/refresh clear another 44px row. Native/env inset ownership remains alternative, never additive. Preserve separate Web/MAUI Back pipelines and existing destination rules.

## Evidence and ownership

- Restored 2.1.42 DLL metadata confirms SidebarVisible and HeaderVisible. Package CSS SHA-256 DF655DC5B0AB9B4C453C178C86E6F81276DA67A46A250DF2D0DC1FD2F1D29A57 matches current upstream CSS. This does not prove runtime geometry or every compiled internal markup detail.
- Upstream scripts/test-chat-single.mjs, test-mobile-table-scroll.mjs, test-crud-body-containment.mjs, test-dialog-scroll-position.mjs --live, test-package-safe-area.mjs and test-native-editor-header.mjs are upstream test entrypoints, not scripts installed here. Inspect their setup/target before running; do not claim their historical passes as current consumer evidence.
- Required future acceptance covers actual dialog trigger/open/close/nesting and resumed scroll; long processing CRUD content/footer hit testing; chat visibility combinations/draft retention; Light/Dark, relevant breakpoints and exact native artifact/device evidence.
- Existing local MAUIHost legacy safe-area CSS and newer upstream iOS/adapter composition remain pending migration. Keep the local PageId catalog authoritative and never silently replace NuGet references with source ProjectReferences.
