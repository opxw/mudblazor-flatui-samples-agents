# Hybrid recovery P0–P2

Canonical PageId: `opx.page.reference.experience-toolkit` (`/experience-toolkit`).

Consumer import: this repository already uses public NuGet 2.1.27 in all hosts and Showcase. The package-mode switches/local-feed commands below describe upstream artifact testing, not a requirement to add source references or a local feed to this consumer. Earlier upstream native runs certify only their recorded artifacts; this upgrade requires its own device evidence.

## P0 — retained menu history and package-mode hosts

FlatAppShell keeps one FlatBottomNavigation instance for its lifetime. `Active=false`
renders no navigation or menu and releases overlay/refresh leases, but retains the
bounded visited trail. Returning to Bottom restores the current history entry.
Changing the host-authorized Items reference invalidates old snapshots even while
inactive. This survives responsive composition and presentation changes, not a new
shell, browser reload, server circuit loss or process death. No global static state.

Both Web and MAUI plus the shared Showcase honor `UseFlatUiProjectReference=false`
and `FlatUiPackageVersion`. Pass the local package feed via
`RestoreAdditionalProjectSources` and an isolated `RestorePackagesPath` when testing
a same-version repack. Verify the resolved assets say `package`, not `project`.
Existing IME, nested modal and dirty-form Back precedence is unchanged.

Use `scripts/build-hybrid-package-sample.ps1 -PackagePath <nupkg>` for a standalone
Android Debug APK (`-Target Windows` for Windows). It embeds assemblies, isolates
the cache by hash and checks the resolved package. A default Fast Deployment Debug
APK cannot be installed independently with ADB. Build shared host targets sequentially
to avoid competing writes to Showcase project.assets.json.

## P1 — workspace and deep-link access

`FlatWorkspaceRecovery` reuses `IFlatWorkspaceStateProvider`: load the exact scoped
key/version, restore query/filter/page/selection, fetch authorized records, then set
FlatScrollRestoration.Ready. Save captures independent dictionary snapshots and
finite nonnegative scroll positions. Missing/version-mismatched state is ignored.
The host must scope by user/tenant/page, validate saved query keys and record access,
handle storage failures and clear state at logout/context changes.

`FlatDeepLinkGate.ResolveAsync(url, authorize, cancellationToken)` accepts only
normalized internal routes. The required host callback performs login/session and
route authorization; unauthorized/forbidden results contain no navigable value.
Cancellation after asynchronous login prevents a stale successful result. The
host navigates only on success, rechecks actual endpoint permissions, and cancels
pending requests on logout/context changes. External HTTP(S) links remain an
explicit host policy, never an implicit redirect. This helper is not an auth system.

## P2 — opt-in durable draft recovery

`FlatDraftRecovery<T>` reuses `IFlatOfflineDraftStore<T>`. Supply an independent
snapshot function, a scoped schema-bearing key, maximum age and expected server
base version. Inspect rejects foreign, expired, future-dated or incompatible drafts
without deleting them. It does not restore UI or submit work. Obtain explicit user
consent before assigning the returned value. Save is explicit and PendingSync=false;
Remove is for explicit discard or successful authoritative save only. Serialize
concurrent writes in the host, encrypt sensitive content and exclude credentials.

HybridRecoveryExamples demonstrates reload/process-restart persistence with browser
storage ONLY for synthetic data. It intentionally persists the fixed search `demo`,
not arbitrary entered text, and the fixed string `Synthetic draft`. This demo store
is not suitable for real ERP/HR data. Production hosts implement encrypted/scoped
storage and conflict policy. No background automatic submission is introduced.

## Gates

- HybridRecoveryTests: denied/unsafe/canceled links, query/pager/selection snapshots,
  scope/version/expiry rejection and explicit draft deletion.
- BottomMenuHistoryTests and bottom-menu-history.spec.ts: inactive sidebar transition,
  restored Finance trail, Back and Forward in Sheet/MainView.
- hybrid-recovery.spec.ts: real browser reload, persisted pager/selection/scroll,
  explicit draft consent and host access decisions.
- Native package-mode testing must bind NuGet and APK hashes. Browser reload is not
  native process-death, IME, rotation or Windows device certification.
