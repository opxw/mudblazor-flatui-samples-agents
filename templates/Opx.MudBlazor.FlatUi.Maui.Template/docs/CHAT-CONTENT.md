# Rich chat content

> Imported guidance 2026-10-06 from upstream working tree based on a0742d4. Sample wiring and regression scripts described below are upstream references, not local additions or executed consumer/native tests. See the local upstream-2.1.46.md skill reference for scope.

## Single conversation

Use `HeaderVisible="false"` to omit the conversation header and its grid row completely, leaving messages plus composer. Default true preserves existing behavior. `/ai-chat?single=true` hides both sidebar and header. Header visibility is available starting with 2.1.40; hiding it also removes its Back/action controls, so the host must retain any required navigation elsewhere.

The canonical AI Chat page fills the available main content width with 2px clearance on each inline edge and 2px above the chat beneath the app shell, without the ordinary 1500px page cap. This explicit page exception does not change other pages, app navigation width, native safe-area ownership, or the chat's internal header/message/composer padding.

Set `FlatChatShell.SidebarVisible="false"` to omit the sidebar and its reserved desktop column. The thread stays open at every width regardless of `ConversationOpen`; no Back-to-history control is rendered. `Sidebar` is optional. Default `true` preserves existing history behavior. Changing visibility does not reset host messages/drafts; route and native Back remain host-owned.

On submit, copy the trimmed host draft into the outgoing message, clear the bound composer value, and flush that render before awaiting transport, streaming, or persistence. This keeps Send visually immediate while the sent message remains available for retry/error handling. Keep submission single-flight; do not restore stale text over a newer draft when an asynchronous host callback fails.

```razor
<FlatChatShell SidebarVisible="false">
    <Header>Assistant</Header>
    <Messages>@* Host-owned messages *@</Messages>
    <Composer>@* Host-owned composer *@</Composer>
</FlatChatShell>
```

Canonical demonstration: `/ai-chat?single=true`; `/ai-chat` retains history. This additive API is available starting with 2.1.39. Retain existing header/message/composer padding, scroll ownership and safe-area behavior.

`FlatChatMessage.Text` remains encoded plain text. Supply `Blocks` to render ordered rich content instead. Reuse stable message keys and unique block IDs when replacing immutable snapshots during streaming. Prefer `StreamingState` (`Connecting`, `Streaming`, `Stopped`, `Completed`, `Failed`) over the compatibility-only `IsStreaming` flag, and use `DeliveryState` (`Sending`, `Sent`, `Failed`) for outgoing messages. Transport, cancellation and conversation storage belong to the host. See the offline `/ai-chat` sample.

Every outgoing send should carry a stable host-visible client ID, such as `FlatChatSendRequest.ClientMessageId`. Retrying must reuse that ID; generating a new response is a different intent. This gives the backend an idempotency key but does not make the operation idempotent unless the backend persists and enforces it. `AvailableActions` only controls presentation. `MessageActionSelected` returns an exact `FlatChatMessageAction(MessageId, Kind)` and never performs retry, copy, feedback, branching or export by itself.

## Supported blocks

- Text, Markdown (including pipe tables, fenced code, task lists, autolinks and horizontal rules), sanitized HTML.
- Typed tables with stable row/column keys and optional host-localized formats.
- Typed Line/Bar charts with an expandable source-data table; no executable chart configuration.
- Metrics through `FlatStatCard`, images with alt text, code toolbars, citations, attachments with progress/state, and action buttons.

```razor
<FlatChatMessage Text="" Author="Assistant" Blocks="blocks"
                 MessageId="message.Id" AccessibleSummary="message.Summary"
                 StreamingState="message.StreamingState"
                 AvailableActions="message.Actions"
                 ActionSelected="HandleBlockAction"
                 MessageActionSelected="HandleMessageAction" />
```

Create blocks with `new FlatChatBlock("answer", FlatChatBlockKind.Markdown) { Text = answer }`. Replace that block with the same ID as streaming data arrives. `ActionSelected` returns `FlatChatAction(BlockId, ActionId)` only. The host must resolve identifiers against authorized resources and revalidate permission at execution time. UI disabled flags are not authorization. Attachments do not automatically download, delete or upload anything.

For block-only messages, provide `AccessibleSummary`; otherwise the component derives a short label from block title/text/value. Code blocks expose a language label and optional callback-only Copy action. Citation URLs are displayed as text and opened only through a host callback. Attachment blocks accept type, size, progress and `Ready`/`Uploading`/`Completed`/`Failed`/`Cancelled` state, while validation, storage, cancel and retry remain host-owned.

## Long-running conversations

Keep search, bounded history, branching, exports, draft persistence and per-conversation scroll position in the host. `FlatChatShell.GetScrollPositionAsync()` and `RestoreScrollPositionAsync(position)` provide a safe browser bridge; persist only ordinary numeric offsets and restore after the target conversation renders. The sample keeps the newest messages in a bounded window and loads older entries on demand. Production hosts may virtualize, but must preserve semantic reading order and live-region behavior.

Transcript export emits `FlatChatTranscriptRequest(ConversationId, Format)` only. The host applies permission, redaction, audit and file generation. Branching copies identifiers/content into a new host conversation only after the host accepts the intent. Draft and scroll persistence in the sample are in-memory demonstrations, not durable storage.

## Trust boundary

Markdown raw HTML is disabled. Both Markdown output and explicit HTML pass through a DOM sanitizer with a formatting/table/link allowlist. No scripts, styles, event handlers, embeds, forms, SVG or markup images are allowed. Links permit local slash-prefixed paths or HTTP/HTTPS URLs without userinfo; protocol-relative URLs and backslashes are rejected. This is formatting support, not arbitrary HTML applications. Fenced code is displayed, never executed.

Images use a separate block. Remote image loading is disabled by default; `AllowRemoteImages` is an explicit host opt-in. Even local image URLs must be authorized by the host. Prefer host-approved media identifiers resolved to read-only image endpoints; remote loading can disclose network metadata. Do not put credentials in URLs. Rich content does not bypass route authorization, CSP or backend validation.

Dependencies: [Markdig](https://github.com/xoofx/markdig) and [HtmlSanitizer](https://github.com/mganss/HtmlSanitizer). Maintain security updates and regression tests; sanitizer tests are not a universal security guarantee.

## Limits and layout

MAUI responsive table surfaces (<=900px) allow vertical scroll chaining to the nearest scrollable ancestor once at their top/bottom limit. This covers data-grid, standard table-scroll and rich-chat table wrappers; horizontal scrolling remains contained. An ancestor modal or chat-message scroller still owns its boundary, so this does not unlock the background page through overlays. Desktop/Web behavior is unchanged. `scripts/test-mobile-table-scroll.mjs` verifies touch chaining in Chromium; Android/iOS WebView evidence remains separate.

Each message permits 64 unique blocks. Each block permits 65,536 text characters, 2,048 title/value characters, 32 columns, 500 rows, 200 chart labels and 12 series. Chart data must be finite and match label counts. Attachment size must be non-negative and progress finite within 0-100. Malformed/missing fields and duplicate keys produce explicit display states. The host must additionally bound request size, aggregate conversation size and payload deserialization; render limits do not limit network allocation. Pass table scalar values, not executable/custom formatter objects.

Use global WidgetGap, intrinsic block heights and bounded native horizontal scrolling for tables/code. Do not force table/chart widths onto the page. The chat follows new content only while already near the bottom; scrolling upward releases follow mode. Shell disposal removes observers. Mobile browser checks are not proof of native keyboard or WebView behavior.

## Verification boundary

Automated component tests cover sanitizer rejection, Markdown structures, accessible block summaries, invalid chart/attachment/null payloads, unique IDs, stable updates, exact block/message callbacks, scroll capture/restore and remote-image opt-in. The sample uses synthetic in-memory content, no AI/backend connection, no durable export and no real file operation. Native IME/Back, production authorization, backend idempotency and transport require host integration tests.
