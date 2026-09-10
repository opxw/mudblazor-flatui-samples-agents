# Shared CRUD draft protection

Canonical pages stay in the Showcase RCL consumed by both Web and MAUI. The reference is `opx.page.operations.asset-crud`; Simple CRUD, Calendar, Kanban, Email compose, product management/detail/editor, vacancies, profile creation, component gallery and keyboard form follow the same lifecycle.

- Compare every editable value with an independent opening snapshot. Use value records/tuples or a deterministic snapshot for collections, not a sticky dirty flag or title-only check.
- Focused input changes count immediately. Returning all values to their initial state is clean.
- Create/Edit/Reply/Forward captures a fresh baseline; prefilled content alone is not a change.
- Back, Cancel and permitted backdrop use the shared discard question. Continue editing retains the draft; Discard closes without saving or refreshing the caller.
- Successful save updates the baseline. Sample simulations remain simulations; the host owns real validation, persistence, authorization and errors.
- Do not supply an always-true ConfirmClose callback. Preserve intentional business-specific decisions and read-only report modals.
- Standalone editors use FlatUnsavedChangesGuard for navigation and explicit Cancel. Clean guards do not register NavigationLock, avoiding unnecessary interference with modal history.
- Carry modal max-height through processing/form wrappers. Keep header/footer fixed and only the draft body scrollable, including long forms.

Regression: `tests/responsive/shared-crud-guards.spec.ts` and `crud-draft-guard.spec.ts` cover desktop/tablet/phone lifecycle. Native Back/IME claims require a rebuilt Android artifact and emulator/device tests; Web history-bridge checks alone are insufficient. Consumer custom forms must adopt the same IsDirty/baseline contract; the package cannot infer arbitrary model edits.

## Verification checkpoint — 2026-09-09

Follow-up: [Native shared CRUD verification](NATIVE-CRUD-VERIFICATION.md) expands this checkpoint to actual Windows and Android hosts and records the Model CRUD revert-to-clean inconsistency. The earlier checkpoint below is retained as Release evidence, not a claim that every editor passes.

39 browser cases passed (36 modal/Asset plus 3 standalone editor), 298 .NET tests passed, repository audit checked 66 Razor pages. Release Web/Android builds passed without warnings/errors. On Pixel 7 API 36, the rebuilt sample verified Simple CRUD clean Back, keyboard dismissal before dirty confirmation, Continue preservation, Discard, and clean reopening. Evidence: `artifacts/shared-crud-native-20260909`; APK SHA256 `E49762C970EEB5F3D56E89459509A370589DFA2BAFD731913631E1DB5423EFA4`. This does not certify every native form, Windows, or landscape. No NuGet version bump/publication.
