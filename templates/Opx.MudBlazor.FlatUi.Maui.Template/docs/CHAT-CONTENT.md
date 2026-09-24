# Rich chat content

> Import 2026-09-24 for NuGet 2.1.42: upstream guidance, examples and historical test reports below are not a claim that new page/host wiring or regression scripts are installed or tested in this consumer. See the local skill reference upstream-2.1.42.md and local source map for scope. Package/current-source CSS matches; native/runtime validation remains separate.

## Single conversation

Use `HeaderVisible="false"` to omit the conversation header and its grid row completely, leaving messages plus composer. Default true preserves existing behavior. `/ai-chat?single=true` hides both sidebar and header. Header visibility is available starting with 2.1.40; hiding it also removes its Back/action controls, so the host must retain any required navigation elsewhere.

The canonical AI Chat page fills the available main content width with 2px clearance on each inline edge and 2px above the chat beneath the app shell, without the ordinary 1500px page cap. This explicit page exception does not change other pages, app navigation width, native safe-area ownership, or the chat's internal header/message/composer padding.

Set `FlatChatShell.SidebarVisible="false"` to omit the sidebar and its reserved desktop column. The thread stays open at every width regardless of `ConversationOpen`; no Back-to-history control is rendered. `Sidebar` is optional. Default `true` preserves existing history behavior. Changing visibility does not reset host messages/drafts; route and native Back remain host-owned.

```razor
<FlatChatShell SidebarVisible="false">
    <Header>Assistant</Header>
    <Messages>@* Host-owned messages *@</Messages>
    <Composer>@* Host-owned composer *@</Composer>
</FlatChatShell>
```

Canonical demonstration: `/ai-chat?single=true`; `/ai-chat` retains history. This additive API is available starting with 2.1.39. Retain existing header/message/composer padding, scroll ownership and safe-area behavior.

`FlatChatMessage.Text` remains encoded plain text. Supply `Blocks` to render ordered rich content instead. Reuse stable message keys and unique block IDs when replacing immutable snapshots during streaming. `IsStreaming` displays an updating state; transport, cancellation and conversation storage belong to the host. See the offline `/ai-chat` sample.

## Supported blocks

- Text, Markdown (including pipe tables and fenced code), sanitized HTML.
- Typed tables with stable row/column keys and optional host-localized formats.
- Typed Line/Bar charts with an expandable source-data table; no executable chart configuration.
- Metrics through `FlatStatCard`, images with alt text, attachments and action buttons.

```razor
<FlatChatMessage Text="" Author="Assistant" Blocks="blocks"
                 IsStreaming="streaming" ActionSelected="HandleAction" />
```

Create blocks with `new FlatChatBlock("answer", FlatChatBlockKind.Markdown) { Text = answer }`. Replace that block with the same ID as streaming data arrives. `ActionSelected` returns `FlatChatAction(BlockId, ActionId)` only. The host must resolve identifiers against authorized resources and revalidate permission at execution time. UI disabled flags are not authorization. Attachments do not automatically download, delete or upload anything.

## Trust boundary

Markdown raw HTML is disabled. Both Markdown output and explicit HTML pass through a DOM sanitizer with a formatting/table/link allowlist. No scripts, styles, event handlers, embeds, forms, SVG or markup images are allowed. Links permit local slash-prefixed paths or HTTP/HTTPS URLs without userinfo; protocol-relative URLs and backslashes are rejected. This is formatting support, not arbitrary HTML applications. Fenced code is displayed, never executed.

Images use a separate block. Remote image loading is disabled by default; `AllowRemoteImages` is an explicit host opt-in. Even local image URLs must be authorized by the host. Prefer host-approved media identifiers resolved to read-only image endpoints; remote loading can disclose network metadata. Do not put credentials in URLs. Rich content does not bypass route authorization, CSP or backend validation.

Dependencies: [Markdig](https://github.com/xoofx/markdig) and [HtmlSanitizer](https://github.com/mganss/HtmlSanitizer). Maintain security updates and regression tests; sanitizer tests are not a universal security guarantee.

## Limits and layout

MAUI responsive table surfaces (<=900px) allow vertical scroll chaining to the nearest scrollable ancestor once at their top/bottom limit. This covers data-grid, standard table-scroll and rich-chat table wrappers; horizontal scrolling remains contained. An ancestor modal or chat-message scroller still owns its boundary, so this does not unlock the background page through overlays. Desktop/Web behavior is unchanged. `scripts/test-mobile-table-scroll.mjs` verifies touch chaining in Chromium; Android/iOS WebView evidence remains separate.

Each message permits 64 unique blocks. Each block permits 65,536 text characters, 2,048 title/value characters, 32 columns, 500 rows, 200 chart labels and 12 series. Chart data must be finite and match label counts. Malformed/missing fields and duplicate keys produce explicit display states. The host must additionally bound request size, aggregate conversation size and payload deserialization; render limits do not limit network allocation. Pass table scalar values, not executable/custom formatter objects.

Use global WidgetGap, intrinsic block heights and bounded native horizontal scrolling for tables/code. Do not force table/chart widths onto the page. The chat follows new content only while already near the bottom; scrolling upward releases follow mode. Shell disposal removes observers. Mobile browser checks are not proof of native keyboard or WebView behavior.

## Verification boundary

Automated component tests cover sanitizer rejection, Markdown tables/code, invalid chart/null payloads, unique IDs, stable updates, disabled/exact action callbacks and remote-image opt-in. The sample uses synthetic in-memory content, no AI/backend connection and no real file operation. Native IME/Back, production authorization and transport require host integration tests.
