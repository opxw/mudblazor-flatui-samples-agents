# Hybrid P0-P2 verification — 2026-09-09

## Vertical drawer patch, 16:21 — supersedes sidebar failure below

FlatAppShell now registers only the open responsive drawer with the overlay
coordinator and a native refresh suspension lease. Close/route/layout/desktop
transition/disposal releases these; persistent desktop sidebar is unaffected.
297 tests pass, including drawer Back/refresh restoration and desktop transition.
Android Release built without warnings/errors; audit66 and targeted diff check pass.
Pixel7 screenshots vertical-patched-before/after prove drawer Back retains Dashboard;
vertical-patched-page proves it retains Experience Toolkit on a non-root route.
Subsequent modal/page Back returns Dashboard (vertical-patched-route).
Evidence: artifacts/android-smoke/20260909-160950; new vertical-drawer-patched.apk
SHA256 DD8D46C2E4FA3BE7FDCCE390CD0872C1828606F0392636D515215C8BBBEF93DF.
Original Bottom setting restored. No NuGet publication/version bump. Settings
header safe-area observation remains separate and unpatched; no new IME claim.

## Vertical menu follow-up, 16:16 — partial failure

Same installed Back-patched APK tested in Vertical mode via Settings.
Sidebar opens, Data & Reports expands, and Experience Toolkit leaf navigation
closes the sidebar. Modal Back retains Experience Toolkit; next Back returns
Dashboard (vertical-modal.png, vertical-modal-back.png, vertical-route-back.png).
FAIL: Back with the sidebar open at Dashboard returns to Android launcher instead
of dismissing the sidebar (vertical-sidebar.png and vertical-sidebar-back.png).
Do not certify all overlay Back paths. No runtime patch made in this test-only
turn. Settings header also visibly overlaps the status bar; separate follow-up.
Evidence under artifacts/android-smoke/20260909-160950. Original Bottom preference
restored afterward (vertical-test-restored.png); sample remains on Dashboard.

## Follow-up: Android route Back patch, 16:11

Prior APK exited from Experience Toolkit instead of returning to Dashboard.
MainActivity now owns paired Back keys: IME, overlay, explicit WebView history,
then root fallback. MainPage uses CanGoBack/GoBack, not guessed parent URLs.
Real IME/predictive-gesture acceptance remains pending.

New APK SHA256: `E97C840AB6FE086E43F6D0F5273C109AB59B54F6539F4B12B87D6E1B5BDDEA92`.
Evidence/APK: `artifacts/android-smoke/20260909-160950/back-route-patched.apk`.
Reviewed screenshots 07-10 in that directory confirm page -> modal -> Back to
same page -> Back to Dashboard. Screenshot11 confirms root Back to launcher.
Installed with app data preserved; reopened after root test. Android Release:
zero warnings/errors. Eight existing overlay/lifecycle tests rerun with --no-build
passed; native changes were compiled and tested on the emulator, not by bUnit.
Audit66 and targeted diff check passed. No NuGet version change/publication.
Consumer MAUI adapters must be updated. Earlier broader counts below belong to
the prior hardening run, not this APK.

Implementation contract: [HYBRID-HARDENING.md](HYBRID-HARDENING.md).
At the time of this historical verification run, package source remained 2.1.21 and no publication or consumer deployment was performed. The accepted consumer baseline is now the separately verified official 2.1.22 package.
Extensive pre-existing dirty worktree preserved.

## Executed

- Exact temporary package/fresh-consumer gate: 296 tests passed, fresh consumer
  Release build passed. Temporary package is not a delivered release.
- Selected browser suites: 35 passed, 1 desktop touch/IME skip; desktop, tablet
  and phone. Includes native hit-test contract, card scrolling, refresh modes,
  modal history/insets, mounted resume, keyboard refresh and explicit retry.
- Android and Windows Release builds: zero warnings/errors. Repository audit:
  66 Razor pages passed. Git diff whitespace check passed.
- Pixel 7 API36 x86_64: installed final Release APK without deleting app data.
  Screenshot review confirms native refresh counter 0 to 2 on separate pulls,
  inner-list scroll to 129px without increment, return to top, modal safe-area,
  Back closes modal while retaining Experience Toolkit, then pull increments to
  3. Disabled plus another pull leaves counter 3. Smoke script also exercised
  rotation, same-process resume, content swipe and sheet Back; its automatic
  result remains NeedsVisualReview, not universal UI certification.

## Exact Android artifact

- File: `artifacts/android-smoke/20260909-155415/hybrid-hardening.apk`
- SHA256: `2CB9781ACF38C8A0E80E0781618C05593B10A595A726B6E2207CA4400AD7DD93`
- Sample version 1.0 / code 1; ABIs arm64-v8a and x86_64; no PDB entries.
- apksigner verification passed; Android Debug certificate, NOT production signing.
- Companion compatibility JSON deliberately does not certify other platforms.

Evidence in the same directory: `08-auto-repeat.png`, `09-inner-up.png`,
`10-modal.png`, `11-modal-back-refresh.png`, `12-disabled.png`.
Browser evidence: `artifacts/hybrid-hardening-final-verified`.

## Boundaries

Real IME acceptance is pending: Gboard stylus onboarding interfered with the
keyboard scenario; simulated browser viewport tests do not replace it.
Windows native interaction, physical Android devices, TalkBack/Narrator,
process-death restoration and full consumer integration remain unverified.
iOS/macOS are not canonical native targets. Offline/retry is host-owned UI,
not an automatic replay or networking implementation. MAUI consumers need the
canonical native adapter changes as well as package changes.
