# CRUD Asset draft protection

The shared `/crud` showcase (PageId `opx.page.operations.asset-crud`) uses the package's default `FlatFormModal` discard guard. It no longer supplies an always-true `ConfirmClose` callback.

Each Create/Edit starts with an independent snapshot of every draft value. Record value equality determines `IsDirty`; text inputs update immediately, including while focused. Reverting all values is clean. Successful simulated Save updates the baseline. Save remains a demonstration, not persistence of catalog records.

Back, Cancel and permitted desktop backdrop close request confirmation only for changed drafts. Continue editing keeps draft values; discard returns false without caller refresh or catalog mutation. The shared confirmation is locked and requires an explicit choice.

## Verification, 2026-09-09

- `crud-draft-guard.spec.ts`: 6 passed across desktop, tablet and mobile. Covers clean Create/Edit, focused dirty Back, Continue/Discard, Cancel, desktop backdrop, revert-to-clean, reopen after discard, and dirty state after simulated Save.
- .NET Release suite: 297 passed. Repository audit: 66 Razor pages passed. Targeted diff check passed.
- Android Release: zero warnings/errors. Rebuilt APK installed on Pixel7 API36. Native Vertical CRUD Asset clean edit closes on edge Back; dirty edit with real Gboard hides IME first, then asks confirmation; Continue retains draft, Discard returns original list. No premature exit.
- Screenshots: `artifacts/crud-draft-native-20260909/dirty-question.png`, `continue-retains-draft.png`, `discard-list.png`. Web evidence: `artifacts/crud-draft-final-20260909`.
- APK: `artifacts/crud-draft-native-20260909/crud-draft-patched.apk`, SHA256 `649A4350B8274EC48C2EF4BC479A31F27BF5BB7494D187D01ECCF7BC5BB36968`.

Temporary emulator IME settings restored; Vertical/Auto unchanged, emulator left on CRUD Asset list. Native Bottom/landscape not rerun for this exact APK. Existing other sample callbacks (including Simple CRUD) are outside this patch. No NuGet publication or version bump; native/browser proof applies to the built shared Showcase, not already-released packages or consumers.
