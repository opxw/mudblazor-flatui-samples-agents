# Shared CRUD draft protection

> Import 2026-09-24 for NuGet 2.1.42: upstream guidance, examples and historical test reports below are not a claim that new page/host wiring or regression scripts are installed or tested in this consumer. See the local skill reference upstream-2.1.42.md and local source map for scope. Package/current-source CSS matches; native/runtime validation remains separate.

## Overlay scroll position

Lock document scrolling on `html` only while a blocking overlay is mounted. Locking both root and a `height:100%` body collapses the document extent and resets its scroll position. For Mud dialog overlays, neutralize only the body's `scroll-locked`/`scroll-locked-no-padding` overflow while the root remains locked; preserve MudBlazor's class lifecycle and nesting. Do not restore arbitrary saved positions after route changes or add consumer CSS. Verify opening, closing, nested overlays, background wheel lock, and resumed scrolling with `node scripts/test-dialog-scroll-position.mjs --live` against the canonical preview. This is browser evidence, not native MAUI certification.

Canonical pages stay in the Showcase RCL consumed by both Web and MAUI. The reference is `opx.page.operations.asset-crud`; Simple CRUD, Calendar, Kanban, Email compose, product management/detail/editor, vacancies, profile creation, component gallery and keyboard form follow the same lifecycle.

- Compare every editable value with an independent opening snapshot. Use value records/tuples or a deterministic snapshot for collections, not a sticky dirty flag or title-only check.
- Focused input changes count immediately. Returning all values to their initial state is clean.
- Create/Edit/Reply/Forward captures a fresh baseline; prefilled content alone is not a change.
- Back, Cancel and permitted backdrop use the shared discard question. Continue editing retains the draft; Discard closes without saving or refreshing the caller.
- Successful save updates the baseline. Sample simulations remain simulations; the host owns real validation, persistence, authorization and errors.
- Do not supply an always-true ConfirmClose callback. Preserve intentional business-specific decisions and read-only report modals.
- Standalone editors use FlatUnsavedChangesGuard for navigation and explicit Cancel. Clean guards do not register NavigationLock, avoiding unnecessary interference with modal history.
- Carry modal max-height through processing/form wrappers. Keep header/footer fixed and only the draft body scrollable, including long forms.
- `CrudEditorShell` uses a DIV `.crud-editor-body` as the scroll/clip owner and an inner `.crud-editor-fields` fieldset for disabled semantics and grid spacing. A scrollable grid fieldset can paint nested content beyond its bounds in Chromium; do not restore that structure. Preserve body padding, field gaps, nested scroll and footer position. Run `scripts/test-crud-body-containment.mjs` and native-header geometry checks; browser evidence does not certify a consumer or native device.

Regression: `tests/responsive/shared-crud-guards.spec.ts` and `crud-draft-guard.spec.ts` cover desktop/tablet/phone lifecycle. Native Back/IME claims require a rebuilt Android artifact and emulator/device tests; Web history-bridge checks alone are insufficient. Consumer custom forms must adopt the same IsDirty/baseline contract; the package cannot infer arbitrary model edits.

## Verification checkpoint — 2026-09-09

Follow-up: [Native shared CRUD verification](NATIVE-CRUD-VERIFICATION.md) expands this checkpoint to actual Windows and Android hosts and records the Model CRUD revert-to-clean inconsistency. The earlier checkpoint below is retained as Release evidence, not a claim that every editor passes.

39 browser cases passed (36 modal/Asset plus 3 standalone editor), 298 .NET tests passed, repository audit checked 66 Razor pages. Release Web/Android builds passed without warnings/errors. On Pixel 7 API 36, the rebuilt sample verified Simple CRUD clean Back, keyboard dismissal before dirty confirmation, Continue preservation, Discard, and clean reopening. Evidence: `artifacts/shared-crud-native-20260909`; APK SHA256 `E49762C970EEB5F3D56E89459509A370589DFA2BAFD731913631E1DB5423EFA4`. This does not certify every native form, Windows, or landscape. No NuGet version bump/publication.
