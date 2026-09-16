# Rich chat content

> Import scope (2.1.33): guidance from the upstream working tree. Referenced new preview content and upstream tests are not automatically copied or rerun in this consumer; inspect the local source map. Package API availability is verified separately from browser/native/backend behavior.

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

Each message permits 64 unique blocks. Each block permits 65,536 text characters, 2,048 title/value characters, 32 columns, 500 rows, 200 chart labels and 12 series. Chart data must be finite and match label counts. Malformed/missing fields and duplicate keys produce explicit display states. The host must additionally bound request size, aggregate conversation size and payload deserialization; render limits do not limit network allocation. Pass table scalar values, not executable/custom formatter objects.

Use global WidgetGap, intrinsic block heights and bounded native horizontal scrolling for tables/code. Do not force table/chart widths onto the page. The chat follows new content only while already near the bottom; scrolling upward releases follow mode. Shell disposal removes observers. Mobile browser checks are not proof of native keyboard or WebView behavior.

## Verification boundary

Automated component tests cover sanitizer rejection, Markdown tables/code, invalid chart/null payloads, unique IDs, stable updates, disabled/exact action callbacks and remote-image opt-in. The sample uses synthetic in-memory content, no AI/backend connection and no real file operation. Native IME/Back, production authorization and transport require host integration tests.
