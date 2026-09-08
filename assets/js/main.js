/* ---------------------------------------------------------------------------
   Fit-to-page.

   Every template has a fixed paper ratio, so anything taller than the sheet was
   being clipped - a third job or a second qualification would disappear off the
   bottom with nothing to say it had. Here the content is measured against the
   page and, when it is too tall, the whole layout is scaled down to fit, the
   way a real CV shrinks when you have more to fit on one side.

   Sizes are in container query units, so this behaves identically on a
   thumbnail and on the full-size editor preview.
   ------------------------------------------------------------------------- */
window.paperloomFit = (function () {
  var MIN = 0.62;   // below this the type stops being readable

  function fitOne(page) {
    var inner = page.querySelector('.doc-inner, .card-body');
    if (!inner) return 1;

    page.style.setProperty('--fit', '1');
    var avail = inner.clientHeight;
    var needed = inner.scrollHeight;
    if (!avail) return 1;

    var fit = 1;
    if (needed > avail + 1) fit = Math.max(MIN, avail / needed);
    page.style.setProperty('--fit', String(Math.round(fit * 1000) / 1000));
    page.dataset.fit = String(Math.round(fit * 100));
    return fit;
  }

  function fitAll(root) {
    var pages = (root || document).querySelectorAll('.card-preview, .doc-preview');
    Array.prototype.forEach.call(pages, fitOne);
  }

  function run() {
    fitAll(document);
    // Re-measure once webfonts land, since metrics change under them.
    if (document.fonts && document.fonts.ready) {
      document.fonts.ready.then(function () { fitAll(document); });
    }
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', run);
  } else {
    run();
  }
  window.addEventListener('resize', function () { fitAll(document); });

  return fitOne;
})();

(function () {
  var navToggle = document.querySelector('.nav-toggle');
  var nav = document.querySelector('.nav');
  if (navToggle && nav) {
    navToggle.addEventListener('click', function () {
      var open = nav.classList.toggle('open');
      navToggle.setAttribute('aria-expanded', String(open));
    });
  }

  // One dropdown per category. Opening one closes the others.
  var toggles = Array.prototype.slice.call(document.querySelectorAll('.dropdown-toggle'));

  function panelFor(toggle) {
    var id = toggle.getAttribute('data-dd');
    return document.querySelector('.dropdown-panel[data-dd-panel="' + id + '"]');
  }

  function closeAll(except) {
    toggles.forEach(function (t) {
      if (t === except) return;
      var p = panelFor(t);
      if (p) p.hidden = true;
      t.setAttribute('aria-expanded', 'false');
    });
  }

  toggles.forEach(function (toggle) {
    toggle.addEventListener('click', function (e) {
      e.stopPropagation();
      var panel = panelFor(toggle);
      if (!panel) return;
      var open = panel.hidden;
      closeAll(toggle);
      panel.hidden = !open;
      toggle.setAttribute('aria-expanded', String(open));
    });
  });

  if (toggles.length) {
    document.addEventListener('click', function (e) {
      var inside = toggles.some(function (t) {
        var p = panelFor(t);
        return t === e.target || t.contains(e.target) || (p && p.contains(e.target));
      });
      if (!inside) closeAll(null);
    });
    document.addEventListener('keydown', function (e) {
      if (e.key === 'Escape') closeAll(null);
    });
  }
})();
