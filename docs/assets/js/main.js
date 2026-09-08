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
