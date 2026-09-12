// Copyright © 2026 opx. All rights reserved.
// Mechanical documentation generation from the browser capture manifest.
import fs from 'node:fs';
const manifest=JSON.parse(fs.readFileSync('docs/images/showcase/manifest.json','utf8'));
const escape=s=>s.replaceAll('&','&amp;').replaceAll('<','&lt;').replaceAll('>','&gt;').replaceAll('"','&quot;');
const title=e=>e.source.split('/').at(-1).replace('.razor','').replace(/([a-z])([A-Z])/g,'$1 $2');
let gallery='';
for(const e of manifest.entries){
 gallery+=`\n<details>\n<summary>${escape(title(e))} — ${escape(e.route)}</summary>\n\n[Canonical source](${e.source}) · Route: \`${e.route}\`\n\n`;
 if(e.components.length)gallery+=e.components.map(c=>`\`${c}\``).join(', ')+'.\n\n';
 gallery+=`![${title(e)} showcase](docs/images/showcase/${e.image})\n\n`;
 for(const p of e.panels) gallery+=`**${p.title}**\n\n![${escape(p.title)} component panel](docs/images/showcase/${p.image})\n\n`;
 gallery+='</details>\n';
}
gallery+='\n<details>\n<summary>Open dialogs and command palette</summary>\n\n';
for(const p of manifest.overlays || [])gallery+=`**${p.title}** · \`${p.route}\`\n\n![${p.title}](docs/images/showcase/${p.image})\n\n`;
gallery+='</details>\n';
const readme=fs.readFileSync('README.md','utf8');
const begin='<!-- BEGIN GENERATED SHOWCASE GALLERY -->';const end='<!-- END GENERATED SHOWCASE GALLERY -->';
if(!readme.includes(begin)||!readme.includes(end))throw new Error('README gallery markers missing');
fs.writeFileSync('README.md',readme.replace(new RegExp(`${begin}[\\s\\S]*?${end}`),`${begin}\n${gallery}\n${end}`));
const components=new Map();
for(const e of manifest.entries)for(const c of e.components){if(!components.has(c))components.set(c,[]);components.get(c).push(e);}
let doc=`# Screenshot catalog\n\n<!-- Copyright © 2026 opx. All rights reserved. -->\n\nThe [README component gallery](../README.md#component-screenshot-gallery) displays all **${manifest.entries.length} shared routes**, **${manifest.entries.reduce((n,e)=>n+e.panels.length,0)} named panel/section captures**, and **${manifest.overlays?.length||0} open overlay previews**. Navigation and Settings have dedicated screenshots. Click a route image below for full resolution. These are actual sample renders, not mockups.\n\n## Component index\n\nThis index is extracted from component tags in the shared Razor pages. It maps composition references to screenshots, not a guarantee that every conditional state is visible in the initial image. Inspect the expanded README panel gallery and open-dialog previews for additional states. Services, model types, host-only shell components, and native-only surfaces are not individual visual examples.\n\n| Component | Showcase screenshot |\n|---|---|\n`;
for(const [c,entries] of [...components].sort(([a],[b])=>a.localeCompare(b)))doc+=`| \`${c}\` | ${entries.map(e=>`[${e.route}](images/showcase/${e.image})`).join(', ')} |\n`;
doc+='\n## Capture evidence and limitations\n\n- Captured on '+manifest.capturedAt.slice(0,10)+' using NuGet '+manifest.package+', Chromium, the local Web sample and original package styles. No injected CSS or replacement UI.\n- Desktop: 1440 × 1000. Phone: 390 × 844. Vertical navigation: all eleven groups expanded, with a taller viewport for the complete tree.\n- Every shared route was captured. Named sections are captured separately to expose below-fold examples. Preview interactions open the message boxes, form modal, command palette and mobile navigation sheet.\n- This is documentation coverage, not exhaustive functional, accessibility, authorization or native-platform testing. Hidden tabs, transient states and virtualized records are not exhaustively photographed. Four MAUI-only routes and native permission/print dialogs need separate emulator/device evidence.\n- MudBlazor, OPX and Showcase stylesheet requests returned 200. The host reference `Opx.MudBlazor.FlatUi.Sample.styles.css` returned 404; no browser page errors were recorded during the route pass. This is an outstanding host asset reference, not evidence of a package CSS defect.\n- Sample data only. Calendar times, activity timestamps and similar demo content may differ in subsequent captures.\n\n## Reproduce\n\nStart the Web sample in Development with `dotnet run --project samples/Opx.MudBlazor.FlatUi.Sample -c Release --no-launch-profile --urls http://127.0.0.1:58739`. Ensure its dependencies are restored and built.\n\nUse Node.js with Playwright Chromium installed. `PLAYWRIGHT_MODULE` may point to an installed `@playwright/test` ESM entrypoint; otherwise standard Node module resolution is used. Set `PREVIEW_URL` if using a different local port. Run sequentially:\n\n```text\nnode scripts/capture-readme-gallery.mjs\nnode scripts/capture-readme-details.mjs\nnode scripts/build-readme-gallery.mjs\n```\n\nReview generated screenshots and the [manifest](images/showcase/manifest.json), including errors and asset statuses, before committing. Capture scripts operate only on the demo host; never target production data.\n';
fs.writeFileSync('docs/SCREENSHOT-GALLERY.md',doc);
console.log('Generated',components.size,'component references;',manifest.entries.length,'routes');
