// Copyright © 2026 opx. All rights reserved.
// Capture below-fold showcase sections and open preview overlays without CSS overrides.
import fs from 'node:fs';
const {chromium}=await import(process.env.PLAYWRIGHT_MODULE || '@playwright/test');
const out='docs/images/showcase';
const manifest=JSON.parse(fs.readFileSync(`${out}/manifest.json`,'utf8'));
const browser=await chromium.launch();
const page=await browser.newPage({viewport:{width:1440,height:1000},colorScheme:'light',reducedMotion:'reduce'});
page.setDefaultTimeout(10000);
const base=process.env.PREVIEW_URL || 'http://127.0.0.1:58739';
async function ready(route){await page.goto(base+route);await page.locator('.monitor-main,.auth-page,.login-page').first().waitFor({timeout:6000}).catch(()=>{});await page.waitForTimeout(500);}
for(const entry of manifest.entries){
 const source=fs.readFileSync(entry.source,'utf8');
 if(!source.includes('<article') && !source.includes('widget-showcase-section'))continue;
 await ready(entry.route);
 const panels=page.locator('article.flat-panel,section.widget-showcase-section');
 for(let i=0;i<await panels.count();i++){
  const panel=panels.nth(i); if(!await panel.isVisible())continue;
  const title=await panel.evaluate(e=>e.querySelector('header strong,header h2,h2')?.textContent?.trim() || '');
  if(!title)continue;
  const image=`${entry.image.replace('.png','')}-detail-${i+1}.png`;
  await panel.scrollIntoViewIfNeeded();await panel.screenshot({path:`${out}/${image}`,animations:'disabled'});
  if(!entry.panels.some(p=>p.image===image))entry.panels.push({title,image});
 }
 console.log('DETAILS',entry.route,entry.panels.length);
}
manifest.overlays=[];
for(const [route,button,title,image] of [
 ['/components','Question','Question message box','message-box-question.png'],
 ['/components','Warning','Warning message box','message-box-warning.png'],
 ['/components','Info','Information message box','message-box-info.png'],
 ['/components','Error','Error message box','message-box-error.png'],
 ['/components','Open form modal','Form modal','form-modal.png'],
 ['/experience-toolkit','Open palette','Command palette','command-palette.png']
]){
 await ready(route);
 const trigger=page.getByRole('button',{name:button,exact:true});
 if(!await trigger.count()){console.log('MISSING',button);continue;}
 await trigger.click(); await page.waitForTimeout(400);
 await page.screenshot({path:`${out}/${image}`,animations:'disabled'});
 manifest.overlays.push({route,title,image});
}
fs.writeFileSync(`${out}/manifest.json`,JSON.stringify(manifest,null,2)+'\n');
await browser.close();
