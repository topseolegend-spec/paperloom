/* ---------------------------------------------------------------------------
   Search.

   The index is a single JSON file written at build time - a few tens of KB for
   every template, subcategory and guide - fetched once on first use and
   filtered in the browser. No server, and nothing to keep in sync by hand.
   ------------------------------------------------------------------------- */
(function () {
  var overlay = document.querySelector('.search-overlay');
  var openBtn = document.querySelector('.search-open');
  if (!overlay || !openBtn) return;

  var input = overlay.querySelector('#search-input');
  var results = overlay.querySelector('.search-results');
  var closeBtn = overlay.querySelector('.search-close');
  var root = document.body.getAttribute('data-root') || '';

  var index = null;
  var loading = false;
  var active = -1;

  function load() {
    if (index || loading) return Promise.resolve();
    loading = true;
    return fetch(root + 'search.json')
      .then(function (r) { return r.json(); })
      .then(function (data) { index = data; loading = false; })
      .catch(function () {
        loading = false;
        results.innerHTML = '<p class="search-empty">Search is unavailable right now.</p>';
      });
  }

  var KIND = { t: 'Template', c: 'Category', g: 'Guide' };

  function score(row, q) {
    var name = row.n.toLowerCase();
    var where = (row.c || '').toLowerCase();
    if (name.indexOf(q) === 0) return 0;          // starts with - best
    if (name.indexOf(q) > -1) return 1;           // contains
    if (where.indexOf(q) > -1) return 2;          // its category matches
    if ((row.s || '').toLowerCase().indexOf(q) > -1) return 3;  // its style
    return -1;
  }

  function render(q) {
    if (!index) return;
    if (!q) {
      results.innerHTML = '<p class="search-empty">Type to search ' + index.length + ' templates, categories and guides.</p>';
      active = -1;
      return;
    }
    var hits = [];
    for (var i = 0; i < index.length; i++) {
      var s = score(index[i], q);
      if (s > -1) hits.push({ row: index[i], s: s });
    }
    hits.sort(function (a, b) { return a.s - b.s; });
    hits = hits.slice(0, 12);

    if (!hits.length) {
      results.innerHTML = '<p class="search-empty">Nothing matches &ldquo;' +
        q.replace(/[<>&]/g, '') + '&rdquo;.</p>';
      active = -1;
      return;
    }
    results.innerHTML = hits.map(function (h, i) {
      var r = h.row;
      return '<a class="search-hit" role="option" aria-selected="false" href="' + root + r.u + '" data-i="' + i + '">' +
        '<span class="sh-name">' + r.n + '</span>' +
        '<span class="sh-where">' + (r.c || '') + '</span>' +
        '<span class="sh-kind">' + (KIND[r.t] || '') + '</span></a>';
    }).join('');
    active = -1;
  }

  function setActive(next) {
    var items = results.querySelectorAll('.search-hit');
    if (!items.length) return;
    if (active > -1) items[active].setAttribute('aria-selected', 'false');
    active = (next + items.length) % items.length;
    items[active].setAttribute('aria-selected', 'true');
    items[active].scrollIntoView({ block: 'nearest' });
  }

  function open() {
    overlay.hidden = false;
    document.body.style.overflow = 'hidden';
    load().then(function () { render(input.value.trim().toLowerCase()); });
    setTimeout(function () { input.focus(); }, 20);
  }

  function close() {
    overlay.hidden = true;
    document.body.style.overflow = '';
    openBtn.focus();
  }

  openBtn.addEventListener('click', open);
  closeBtn.addEventListener('click', close);
  overlay.addEventListener('click', function (e) { if (e.target === overlay) close(); });

  input.addEventListener('input', function () {
    render(input.value.trim().toLowerCase());
  });

  input.addEventListener('keydown', function (e) {
    if (e.key === 'ArrowDown') { e.preventDefault(); setActive(active + 1); }
    else if (e.key === 'ArrowUp') { e.preventDefault(); setActive(active - 1); }
    else if (e.key === 'Enter') {
      var items = results.querySelectorAll('.search-hit');
      if (active > -1 && items[active]) { e.preventDefault(); items[active].click(); }
    }
  });

  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape' && !overlay.hidden) { close(); return; }
    // "/" opens search, the way it does almost everywhere else - but not while
    // the reader is typing into a field.
    var tag = (e.target.tagName || '').toLowerCase();
    var typing = tag === 'input' || tag === 'textarea' || e.target.isContentEditable;
    if (e.key === '/' && !typing && overlay.hidden) { e.preventDefault(); open(); }
  });
})();
