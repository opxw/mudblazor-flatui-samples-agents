# Ticket Detail sample

Copyright (c) 2026 opx. All rights reserved.

PageId `opx.page.operations.ticket-detail`, route `/ticket-detail` in shared Showcase. Desktop has main content and a detail/files rail; <=900px follows summary, content, files in source order. Existing FlatPage, FlatPanel, FlatInfoItem, FlatStatusChip and FlatCollaborationPanel provide the composition.

Local sample handlers demonstrate status, assignment, checklist, comment, reply, download intent and confirmed attachment removal. Replies carry the exact thread key. All values are synthetic and reset on reload. `?readOnly=true` disables mutation controls and handler mutations; per-file capabilities independently hide download/delete actions. This query option demonstrates UI behavior, not authorization.

No backend, authentication, file bytes/download transport or stored-file deletion is implemented. Download clearly reports an intent only. Hosts must enforce authorization, file scope, payload validation, concurrency and persistence in their services. Never substitute the sample's local permissions for server checks. Code and comments render through ordinary Razor text encoding; no MarkupString or execution is used. Comment draft lifecycle follows the existing collaboration composer, without a new standalone unsaved-draft guard.

> Import scope (2.1.31): upstream documentation from `D:\projects\git\mudblazor-flat-ui` at `e7c743d`. New showcase pages, preview launchers, host registrations and upstream test results described here are not automatically installed or certified in this consumer by a package/rules upgrade. Follow the local source map before invoking a route or script.
