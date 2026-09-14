# Profile Settings sample

`opx.page.account.profile-settings`, shared `/profile-settings` page. Reuses FlatPage, FlatPanel, FlatProfileAvatar, FlatMultiSelect, FlatUnsavedChangesGuard and global input variants. Desktop rail/form split becomes one column at <=900px; section buttons scroll horizontally. FlatPage retains the shared keyboard/viewport infrastructure; real device IME testing remains separate.

Independent draft/saved snapshots include fields, photo choice, sorted skills, stable-key links, experience and privacy preferences. Reverting values becomes clean. Tab switches, Cancel and internal Back use the same locked discard question. Continue editing keeps the section and draft; Discard restores the saved snapshot. External unload uses NavigationLock browser confirmation.

Profile completion is a host-supplied 65% demo snapshot, never recalculated by UI. Photo callback selects/removes bundled artwork only; no upload transport is provided. Password action requests the host security flow without collecting credentials. Save validates name/email and HTTP(S) portfolio links, copies a local snapshot and explicitly does not claim server persistence. Privacy controls do not authorize backend access. Hosts must implement authenticated services, photo validation, concurrency, error handling and authoritative completion values.

> Import scope (2.1.31): upstream documentation from `D:\projects\git\mudblazor-flat-ui` at `e7c743d`. New showcase pages, preview launchers, host registrations and upstream test results described here are not automatically installed or certified in this consumer by a package/rules upgrade. Follow the local source map before invoking a route or script.
