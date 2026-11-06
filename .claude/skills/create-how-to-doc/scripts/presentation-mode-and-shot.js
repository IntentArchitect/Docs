// Example step for ia.cjs: turn on presentation mode in the shell and chat renderers,
// open the Codebase pane, and save a screenshot to $OUT/overview.png.
// Run: set OUT=<working folder> && node ia.cjs presentation-mode-and-shot.js
module.exports = async (h) => {
  const presentationMode = () => {
    angular.element(document.querySelector("html")).injector().get("EventAggregator").publish("set-presentation-mode", true);
    return true;
  };
  await h.find('/shell/').evaluate(presentationMode);
  await h.find('/ai-chat').evaluate(presentationMode).catch(e => String(e));
  await h.ia('/shell/', (ia) => ia.shell.openSidebarPanel('codebase'));
  await h.sleep(2500);
  const tabs = await h.ia('/shell/', (ia) => ia.shell.listTabs());
  const out = await h.shot(process.env.OUT + '/overview.png', 1);
  return { tabs, out };
};
