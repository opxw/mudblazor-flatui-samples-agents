# Native shared CRUD verification — 2026-09-09

This is a test report for the current dirty producer checkout, not certification of every consumer form or a published package.

## Hosts and method

- Windows: real MAUI WinUI/WebView2 host, Release `net10.0-windows10.0.19041.0`, build succeeded with zero warnings/errors. EXE SHA256: `F8AA86AE2D272CBEE29F7D179CE2DF3CCFD7F65079BF3D91B28FE579B9490A3F` (EXE only, not a bundle hash).
- Android: Pixel 7 API 36 emulator, gesture navigation; diagnostic Debug APK with embedded assemblies, built with zero warnings/errors. APK SHA256: `EDD8A14A0E153F37BFEDDB7500DD3B411684E2911B48CBE6218FC19EE3B0507A`. Debug allows inspecting the actual native WebView; it is not Release/trimmed proof.
- `scripts/test-native-crud.mjs` attaches to the actual native WebView, never the browser sample. Windows additionally had direct native UI interaction for Simple CRUD.
- Android Back is a real ADB edge swipe. Visible IME is detected from WindowInsets; a keyboard-dismissal Back is sent before form Back when necessary. `mIsInputViewShown` alone is stale and must not determine gesture count.
- Windows matrix uses the form Back button, not OS window close/Alt+F4. Input is automated; this does not prove every keyboard, composition or touch scenario.
- Internal navigation uses normal Blazor links. Initial runs using repeated full native document reloads and stale test dialogs are superseded by the isolated final matrix, not counted as passing evidence.

## Assertions

For modal editors: clean Back, dirty Back confirmation, Continue retains values, restoring initial value becomes clean, Cancel/Discard, and reopening with the original value. Standalone Product Editor: Cancel navigation confirmation, Continue retains values, Discard returns to product management. No Save action or backend write was performed.

Windows final matrix: **12/13 editors passed**. Model CRUD fails only the `revert clean` assertion: `FlatModelCrud.DraftChangedAsync` sets `_dirty = true` without comparing the restored draft to its baseline. The confirmation remains after reverting the value. This is conservative (does not silently discard data), but inconsistent with the standardized value-based editors. Runtime code was not changed in this verification task.

Android final matrix: **12/13 editors passed**, with the same Model CRUD `revert clean` failure. Final results are recorded in `artifacts/native-all-forms-20260909/android/results.json`. Both hosts pass Asset, Simple CRUD, Calendar, Kanban, Email, Product Management, Product Detail, Jobs, ProfileGrid, Components gallery, the keyboard test form, and standalone Product Editor. The Model CRUD case stops at its failed assertion; later checks for that case are not claimed.

The diagnostic Windows host was closed after testing. Emulator keyboard settings remained unchanged (`stylus_handwriting_enabled=null`, `show_ime_with_hard_keyboard=0`). The earlier Release APK is restored after the diagnostic run; its SHA256 is `E49762C970EEB5F3D56E89459509A370589DFA2BAFD731913631E1DB5423EFA4`. Harness syntax check and `git diff --check` passed (existing line-ending warnings only).

Evidence: `artifacts/native-all-forms-20260909/windows/results.json`, per-route question/failure PNGs, and equivalent Android files. Screenshots from the harness show native WebView content, not the surrounding OS chrome.

## Limits

The matrix covers the 13 shared sample editors listed in the harness. It does not establish native OS file/permission dialogs, arbitrary consumer-created forms, Windows close-window cancellation, Android physical devices, all navigation modes/orientations, every input type, or Android Release equivalence. Earlier Release Simple CRUD proof remains separate. No NuGet publication or version bump was performed.
