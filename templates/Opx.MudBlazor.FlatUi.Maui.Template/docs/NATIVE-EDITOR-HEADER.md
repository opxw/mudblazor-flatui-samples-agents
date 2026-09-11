# Native fullscreen editor header

The native panel already reserves `--opx-native-statusbar-height`. The responsive header's `env(safe-area-inset-top)` added a second top reserve, shifting Back below the shell hamburger. This is a package CSS defect when both insets are nonzero.

At the existing fullscreen boundary (760px), the native header now uses a 60px row with no additional top inset, a 40px Back target and the shell's 6px leading gutter. Desktop/modal and ordinary Web header defaults remain unchanged. No API, authorization, data or host override is added.

Validation: `node scripts/test-native-editor-header.mjs` checks actual Chromium CSS safe-area overrides and both button centers at four viewport/inset combinations, then checks Web defaults. Screenshots are synthetic geometry evidence, not emulator evidence. Release sample build passes with `-p:OutputPath=bin/Release/header-inset/`; the default output was locked by an existing preview.

Consumer update: the patch is included in signed NuGet.org 2.1.26. Validation described in this document is upstream evidence, not a new consumer runtime test. Consumers must upgrade matching package assets and rebuild their APK; no HR application source is modified here.

The regression now includes the real processing fieldset wrapper, long scrollable content and visible footer. Restoring the old header inset reproduces a measurable extra gap. `node scripts/test-editor-header-live.mjs` also validates the rendered Blazor modal at 390x844, 740x390 and 760x900: its header starts exactly at the simulated native inset and is 60px tall. Closing preserves the circuit with no page errors. Screenshots are in `artifacts/native-editor-header/live-*.png`. Native insets are simulated in Chromium; this is not a rebuilt consumer APK or Pixel 7 certification.
