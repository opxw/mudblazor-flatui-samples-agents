# Application readiness integration

The shared Showcase is the Web/MAUI composition source. Reuse existing components;
do not create parallel search, inbox, upload, workspace or conflict systems.

## Single preview

Run `./scripts/start-preview.ps1` from this repository. The Windows launcher owns
one sample listener on loopback port 58744 and isolates build intermediates in
`.artifacts/preview`. It stops only sample executables resolved inside this
workspace, rejects a foreign listener, serializes launches, and checks recursive
CSS imports before reporting READY. Do not start competing source previews or
reuse older ports. Ordinary tests/builds must use separate artifact directories.
This controls the launcher, not unrelated manual processes. A successful HTML
response alone is not a stylesheet or UI acceptance test.

## Existing components and host boundaries

| Concern | Integration | Production responsibility |
| --- | --- | --- |
| Search/menu | Web and MAUI shells use scoped `ShowcaseAccessPolicy`; retain permitted ancestors and recheck notification destinations | Replace public-showroom policy with trusted permissions; advance Revision and rerender on changes. Authorize routes and operations server-side; hiding menus is not security. |
| Inbox | `ShowcaseInboxButton` opens existing `FlatFormModal` / `FlatNotificationCenter`; read status survives in-circuit navigation | Durable per-user inbox, delivery, tenant scope and read acknowledgements |
| Upload | Existing `FlatFileUpload` validates initial attempts and retries; invalid type/MIME/size cannot invoke host; in-flight/current row excluded from retry count | Validate actual bytes server-side, upload transport, malware policy, cancellation, storage and authorization |
| States | Existing `FlatWidget`, failure panels and recovery UI; Dashboard Ready/Loading/Empty/Error and explicit Retry | Feed actual service state. Static pages need not fake loading. Every asynchronous host page still needs individual state integration. |
| Preferences | Existing dashboard provider saves allowlisted layout and period under synthetic A/B browser profiles | Authenticated identity-scoped provider, schema migration, sign-out cleanup and storage policy. A/B are not user accounts; period demonstrates persistence, not a data query. |
| Master/detail | Experience Toolkit retains local search and native list scroll on return | Durable route/workspace recovery and current-record permission checks |
| Conflict/audit | Existing resolver clears choices for changed record/server fields and disables busy actions; demo rejects stale versions and appends before/after audit | Atomic server version comparison, authorized mutation and durable audit transaction |
| Localization | Notification and audit timestamps now use existing `FlatValueFormatter` and `FlatLocalizationOptions` | Supply culture/time zone; retain UTC instants. Existing number/currency examples remain host-formatted; this is not translation of every sample caption. |

Upload sample includes an explicit first-attempt failure switch to exercise retry.
No real file transfer occurs there. Demo preferences store only fixed widget keys,
visibility/order and an enum preset, never entered form data or credentials.

## Verification on 2026-09-14

- 434 .NET tests passed, including invalid-upload retry, valid transport retry,
  conflict reset/busy, timestamp localization, authorized tree/search and inbox checks.
- Web preview compiled; Android Release build succeeded with zero warnings/errors.
- Repository audit: 71 Razor pages. Initial geometry audit: 79 routes at 390/1280
  in Dark; Components and Monitoring had mobile overflow. Shared sample grid-child
  sizing and code-block owned scrolling fixed both; focused retests passed.
- Light initial geometry audit: all 79 routes at 390/1280, no document overflow.
- Browser: dirty form Back/continue retains input; reverting closes cleanly;
  master/detail restores search and 730px list position; A/B preferences isolate
  periods and survive reload; stale conflict rejected then fresh resolution audited;
  inbox detail navigation and Back restore the originating route without a modal.
- Constrained 390x400 viewport: focused field 14 remained above the form footer.
  This is browser geometry evidence, not Android IME or predictive Back proof.
- Six recursive stylesheets still pass after isolated unit and Android builds.

## Remaining acceptance work

Do not mark all P0-P2 conditions certified: exhaustive contrast/spacing across all
interactive states, long/localized text, all asynchronous page states, screen reader,
native Android keyboard/predictive Back, Windows runtime and production host services
remain separate gates. Initial route overflow checks do not certify those conditions.
No release version change, package publication or production deployment was performed.

> Import scope (2.1.31): upstream documentation from `D:\projects\git\mudblazor-flat-ui` at `e7c743d`. New showcase pages, preview launchers, host registrations and upstream test results described here are not automatically installed or certified in this consumer by a package/rules upgrade. Follow the local source map before invoking a route or script.
