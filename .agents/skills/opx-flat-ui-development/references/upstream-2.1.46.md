# Guidance import for the 2.1.46 consumer

Imported 2026-10-06 from `D:/projects/git/mudblazor-flat-ui`, working tree based on a0742d4, including uncommitted guidance. This is a guidance import, not an installation of upstream sample wiring or native adapters. Keep NuGet-only references, original package CSS, existing PageIds, positive padding and separate Web/MAUI Back ownership.

## Chat: opx.page.assistant.ai-chat

Read docs/CHAT-CONTENT.md. Capture the submitted host draft, clear and render the composer before awaiting transport/streaming/persistence, keep sending single-flight, and never overwrite a newer draft with stale text after failure. Keep SidebarVisible/HeaderVisible optional and independent of host navigation.

Use stable message/block IDs, AccessibleSummary for structured-only messages, explicit delivery and streaming states, and exact callback-only message/block actions. Retry reuses the client message ID; only the backend can enforce idempotency. Code is displayed, never executed. Markdown and HTML use the package sanitizer; images require host authorization and explicit remote opt-in. Attachment progress is not proof of upload. Hosts own bounded history, draft/scroll persistence, export, branching, authorization and transport. Restore conversation scroll only after that conversation renders through the package bridge.

AI Chat alone has the upstream 2px top/inline composition exception; it does not replace global 16px mobile gutters. Existing local sample wiring is unchanged by this import.

## Layout: opx.page.operations.asset-crud and opx.page.reference.dynamic-menu

Read docs/UI-NON-OVERLAP.md. Direct desktop module pages (>900px) distribute remaining viewport height after the 60px AppBar or 104px Horizontal shell, intrinsic page actions and native insets once, leaving a 16px bottom gutter. Toolbar/pager stay outside the single data scroller; do not use 88vh. Following real content, including Sample code disclosure, disables the final-grid full-height composition. Hidden nodes, scripts/styles, fixed overlays and FAB hosts do not count as following content. Mobile/custom panels retain their own contracts.

Horizontal AppBar/menu use one continuous surface, no 4px gap, one subtle 1px separator and a 44px menu row. Native insets are counted once. On mobile pages with table footer and normal-flow FAB, package spacing uses 16px rather than floating-FAB 88px reserve; do not duplicate Bottom-navigation safe-area clearance. No consumer CSS overrides.

## Attribution

Application author is fixed to `opx`; do not scaffold OpxFlatUi:Application:Author. Legacy setter compatibility does not override attribution. Render ResolvedAuthor once in the host head and retain runtime Powered by opx attribution. Chat/comment authors remain independent domain data.

## Evidence boundaries

Official NuGet 2.1.46 signature verified. Package CSS SHA256: 71BF6AE517ED4292944710BA144666DBABF9AF4FAB3E5959B6642F8F49F63CEA. NuGet repository metadata records a0742d4; the upstream working tree includes newer changes and is not itself release proof.

Upstream scripts test-ai-chat-p0-p2.mjs, test-ai-chat-markdown-output.mjs, test-chat-composer-clear.mjs, test-desktop-grid-height.mjs and test-horizontal-appbar-seam.mjs are reference-only, not copied or executed here. Browser and source test reports are not consumer or Android/iOS device certification. Preserve pending native safe-area host migration.
