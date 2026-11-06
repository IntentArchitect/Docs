// expand a visible, collapsed codebase row by its label: click the arrow drawn left of the label
exports.expandRow = async (shell, label) => {
  const rows = shell.locator('.shell-codebase-row');
  const c = await rows.count();
  for (let i = 0; i < c; i++) {
    const r = rows.nth(i);
    if (!(await r.isVisible())) continue;
    const t = (await r.innerText()).trim();
    if (t !== label) continue;
    const li = r.locator('xpath=ancestor::li[1]');
    const cls = await li.getAttribute('class');
    if (!/tree-collapsed/.test(cls || '')) return 'already';
    const box = await r.boundingBox();
    await shell.mouse.click(box.x - 10, box.y + box.height / 2);
    return 'clicked';
  }
  return 'not-found';
};
