// Copyright © 2026 opx. All rights reserved.
// Documentation-only capture. Never inject CSS or modify the sample UI.
// Set PLAYWRIGHT_MODULE to an installed @playwright/test ESM entrypoint.
import fs from 'node:fs';
import path from 'node:path';
const { chromium } = await import(process.env.PLAYWRIGHT_MODULE || '@playwright/test');
const base = process.env.PREVIEW_URL || 'http://127.0.0.1:58739';
const out = 'docs/images/showcase';
fs.mkdirSync(out, {recursive:true});
const browser = await chromium.launch();
const context = await browser.newContext({viewport:{width:1440,height:1000},colorScheme:'light',reducedMotion:'reduce'});
const page = await context.newPage();
page.setDefaultTimeout(12000);
const errors=[]; let current='navigation';
page.on('pageerror', e=>errors.push({route:current,message:e.message}));
async function ready(route) {
  current=route; await page.goto(base+route); await page.waitForTimeout(900);
  await page.evaluate(()=>document.fonts.ready);
  if(await page.locator('#blazor-error-ui:visible').count()) throw new Error('Blazor error at '+route);
}
async function shot(name, target=page) {await target.screenshot({path:`${out}/${name}.png`,animations:'disabled'});}
async function settings() {
  await page.getByRole('button',{name:'Open app menu'}).click();
  await page.getByText('Settings',{exact:true}).click();
  await page.getByRole('heading',{name:'Application preferences'}).waitFor();
}
async function mode(name) {
  await settings(); await page.getByText(name,{exact:true}).click();
  await page.getByRole('button',{name:'Save',exact:true}).click(); await page.waitForTimeout(500);
}
await ready('/');
const styles = await page.locator('link[rel="stylesheet"]').evaluateAll(es=>es.map(e=>e.href));
const assetChecks=[];
for(const url of styles) {const r=await context.request.get(url); assetChecks.push({url,status:r.status()}); if(!r.ok() && url.includes('/_content/')) throw new Error('Stylesheet failed: '+url);}
await shot('vertical');
for(let pass=0;pass<15;pass++) {
  const collapsed=page.locator('button[aria-expanded="false"][aria-label^="Toggle "]:visible');
  if(!await collapsed.count()) break;
  await collapsed.first().click(); await page.waitForTimeout(150);
}
const expanded=await page.locator('button[aria-expanded="true"][aria-label^="Toggle "]').count();
await page.evaluate(()=>{for(const e of document.querySelectorAll('aside,aside *')) if(e.scrollTop)e.scrollTop=0;});
await shot('vertical-expanded');
await page.setViewportSize({width:1440,height:2800}); await page.waitForTimeout(400);
const sidebar=page.locator('aside').first();
await shot('vertical-all-groups',sidebar);
await page.setViewportSize({width:1440,height:1000});
await settings(); await shot('settings'); await page.getByRole('button',{name:'Cancel',exact:true}).click();
await mode('Horizontal'); await shot('horizontal');
await mode('Bottom'); await page.setViewportSize({width:390,height:844}); await page.waitForTimeout(500);
await shot('bottom-mobile');
await page.getByRole('button',{name:'ERP',exact:true}).click(); await page.waitForTimeout(500);
await shot('bottomsheet-mobile');
await page.setViewportSize({width:1440,height:1000}); await ready('/'); await mode('Vertical');
const root='samples/Opx.MudBlazor.FlatUi.Showcase/Components/Pages';
const project=fs.readFileSync('samples/Opx.MudBlazor.FlatUi.Sample/Opx.MudBlazor.FlatUi.Sample.csproj','utf8');
const packageVersion=project.match(/Include="Opx\.MudBlazor\.FlatUi"\s+Version="([^"]+)"/)?.[1];
if(!packageVersion)throw new Error('Cannot determine the sample package version');
const manifest={capturedAt:new Date().toISOString(),package:packageVersion,viewport:{width:1440,height:1000},expandedGroups:expanded,assetChecks,entries:[],errors};
for(const file of fs.readdirSync(root).filter(f=>f.endsWith('.razor')).sort()) {
 const source=fs.readFileSync(path.join(root,file),'utf8');
 const routes=[...source.matchAll(/@page\s+"([^"]+)"/g)].map(m=>m[1]);
 const components=[...new Set([...source.matchAll(/<(Flat[A-Z]\w*)\b/g)].map(m=>m[1]))].sort();
 for(const route of routes) {
  try {
   await ready(route);
   const slug=route==='/'?'dashboard':route.slice(1).replaceAll('/','-');
   await shot(slug);
   const entry={route,source:path.join(root,file).replaceAll('\\','/'),components,image:`${slug}.png`,panels:[]};
   const panels=page.locator('section.flat-panel');
   for(let i=0;i<await panels.count();i++) {
    const panel=panels.nth(i);
    if(!await panel.isVisible())continue;
    const title=await panel.evaluate(e=>e.querySelector('header h2,header h3,header strong,.panel-title')?.textContent?.trim() || '');
    if(!title)continue;
    const name=`${slug}-panel-${i+1}`;
    await panel.scrollIntoViewIfNeeded(); await shot(name,panel);
    entry.panels.push({title,image:`${name}.png`});
   }
   manifest.entries.push(entry); console.log('CAPTURED',route,entry.panels.length);
  } catch(e) {errors.push({route,message:e.message});console.log('FAILED',route,e.message);}
 }
}
fs.writeFileSync(`${out}/manifest.json`,JSON.stringify(manifest,null,2)+'\n');
await browser.close();
console.log('DONE',manifest.entries.length,'routes;',errors.length,'errors');
if(errors.length) process.exitCode=1;
