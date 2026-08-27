# Job Landing

Copyright (c) 2026 opx. All rights reserved.

The `/job-landing` sample demonstrates a public careers portal in `WebsiteLayout`: sticky public navigation, search hero, hiring process, categories, responsive vacancy results, featured employers, email application, subscription CTA, and footer.

Use `FlatJobEmailApplicationDialog<TJob>` when a candidate may apply by email. It validates the candidate name, email address, optional phone/message, and explicit consent, then returns the exact selected job through `FlatJobEmailApplication<TJob>`.

The component does not use `mailto:`, send email, upload a resume, or persist applicant data. The sample reports explicitly that no email was sent. A production host owns vacancy search, authorization, applicant identity, resume upload/scanning, consent lifecycle, persistence, interview workflow, status, analytics, delivery, unsubscribe, retention, and privacy compliance.

At `900px` and below, filters and results stack to one column. At `600px` and below, content remains touch-friendly and free of document-level horizontal overflow.
