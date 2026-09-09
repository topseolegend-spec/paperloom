/* =============================================================================
   Card editor - wording, colours, lettering, ornament, background and size,
   all in the browser. No account, no server: state lives in localStorage and,
   when the reader asks for a share link, in the URL hash.
   ========================================================================== */
(function () {
  var stage = document.querySelector('.detail-stage');
  if (!stage) return;

  var card = stage.querySelector('.card-preview, .doc-preview');
  var slug = stage.getAttribute('data-template');
  if (!card || !slug) return;

  // The field list comes from the page, not from this file, so invitation
  // cards, CVs, invoices and menus all drive the same editor.
  var FIELDS = Array.prototype.map.call(
    card.querySelectorAll('[data-field]'),
    function (el) { return el.getAttribute('data-field'); });
  if (!FIELDS.length) return;
  var FONTS = ['f-cormorant', 'f-playfair', 'f-bodoni', 'f-libre', 'f-marcellus',
               'f-italiana', 'f-cinzel', 'f-cinzel-dec', 'f-script', 'f-parisienne',
               'f-sacramento', 'f-josefin', 'f-tenor', 'f-urdu', 'f-amiri', 'f-naskh'];
  var RTL_FONTS = ['f-urdu', 'f-amiri', 'f-naskh'];
  var BGS = ['bg-plain', 'bg-grad', 'bg-wash', 'bg-edge'];
  // sizes differ per template kind (5x7 / A5 / square for cards, A4 / Letter
  // for documents), so take them from the controls the page rendered
  var SIZES = Array.prototype.map.call(
    document.querySelectorAll('[data-size]'),
    function (b) { return b.getAttribute('data-size'); });
  var STORE_KEY = 'paperloom:' + slug;

  // ---- html <-> plain text ------------------------------------------------

  function htmlToText(html) {
    var div = document.createElement('div');
    div.innerHTML = String(html).replace(/<br\s*\/?>/gi, '\n');
    return (div.textContent || '').replace(/ /g, ' ');
  }

  function textToHtml(text) {
    return String(text)
      .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
      .replace(/\n/g, '<br>');
  }

  // ---- state --------------------------------------------------------------

  function pickClass(list, fallback) {
    for (var i = 0; i < list.length; i++) {
      if (card.classList.contains(list[i])) return list[i];
    }
    return fallback;
  }

  function readCard() {
    var texts = {};
    FIELDS.forEach(function (f) {
      var el = card.querySelector('[data-field="' + f + '"]');
      texts[f] = el ? el.innerHTML : '';
    });
    var onArt = card.querySelector('.card-art .art.is-on');
    return {
      texts: texts,
      bg: card.style.getPropertyValue('--c-bg').trim(),
      ink: card.style.getPropertyValue('--c-ink').trim(),
      accent: card.style.getPropertyValue('--c-accent').trim(),
      font: pickClass(FONTS, 'f-cormorant'),
      bgstyle: pickClass(BGS, 'bg-plain'),
      size: pickClass(SIZES, 'sz-5x7'),
      art: onArt ? onArt.getAttribute('data-art') : 'none',
      foil: card.classList.contains('is-foil'),
      scale: 100
    };
  }

  var initial = readCard();
  var state, undoStack = [];

  function clone(o) { return JSON.parse(JSON.stringify(o)); }

  function encode(obj) {
    var bytes = new TextEncoder().encode(JSON.stringify(obj));
    var bin = '';
    bytes.forEach(function (b) { bin += String.fromCharCode(b); });
    return btoa(bin).replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '');
  }

  function decode(str) {
    try {
      var bin = atob(str.replace(/-/g, '+').replace(/_/g, '/'));
      var bytes = new Uint8Array(bin.length);
      for (var i = 0; i < bin.length; i++) { bytes[i] = bin.charCodeAt(i); }
      return JSON.parse(new TextDecoder().decode(bytes));
    } catch (e) { return null; }
  }

  function merge(saved) {
    var s = clone(initial);
    if (!saved) return s;
    if (saved.texts) {
      FIELDS.forEach(function (f) {
        if (typeof saved.texts[f] === 'string') s.texts[f] = saved.texts[f];
      });
    }
    ['bg', 'ink', 'accent'].forEach(function (k) {
      if (typeof saved[k] === 'string' && /^#[0-9a-f]{3,8}$/i.test(saved[k])) s[k] = saved[k];
    });
    if (FONTS.indexOf(saved.font) !== -1) s.font = saved.font;
    if (BGS.indexOf(saved.bgstyle) !== -1) s.bgstyle = saved.bgstyle;
    if (SIZES.indexOf(saved.size) !== -1) s.size = saved.size;
    if (typeof saved.art === 'string' && card.querySelector('[data-art="' + saved.art + '"]')) s.art = saved.art;
    if (saved.art === 'none') s.art = 'none';
    if (typeof saved.foil === 'boolean') s.foil = saved.foil;
    if (typeof saved.scale === 'number' && saved.scale >= 60 && saved.scale <= 150) s.scale = saved.scale;
    return s;
  }

  var fromHash = location.hash.indexOf('#c=') === 0 ? decode(location.hash.slice(3)) : null;
  if (fromHash) {
    state = merge(fromHash);
  } else {
    var stored = null;
    try { stored = JSON.parse(localStorage.getItem(STORE_KEY) || 'null'); } catch (e) { stored = null; }
    state = merge(stored);
  }

  function save() {
    try { localStorage.setItem(STORE_KEY, JSON.stringify(state)); } catch (e) { /* private mode */ }
  }

  // One undo step per change, but typing collapses into a single entry so a
  // sentence does not fill the stack character by character.
  var lastPush = 0;
  function pushHistory(collapse) {
    var now = Date.now();
    if (collapse && now - lastPush < 900) return;
    lastPush = now;
    undoStack.push(clone(state));
    if (undoStack.length > 40) undoStack.shift();
    var u = document.querySelector('[data-undo]');
    if (u) u.disabled = false;
  }

  // ---- render -------------------------------------------------------------

  function apply() {
    FIELDS.forEach(function (f) {
      var el = card.querySelector('[data-field="' + f + '"]');
      if (el && el.innerHTML !== state.texts[f]) el.innerHTML = state.texts[f];
      var input = document.querySelector('[data-text="' + f + '"]');
      if (input && document.activeElement !== input) {
        var asText = htmlToText(state.texts[f]);
        if (input.value !== asText) input.value = asText;
      }
    });

    card.style.setProperty('--c-bg', state.bg);
    card.style.setProperty('--c-ink', state.ink);
    card.style.setProperty('--c-accent', state.accent);
    card.style.setProperty('--c-soft', state.ink);
    // The stylesheets build translucent tints with rgba(var(--x-rgb), a) rather
    // than color-mix(), because html2canvas cannot parse color-mix and the PNG
    // export fails outright on it. So the components have to travel too.
    card.style.setProperty('--c-accent-rgb', hexToRgb(state.accent));
    card.style.setProperty('--c-ink-rgb', hexToRgb(state.ink));
    card.style.setProperty('--c-bg-rgb', hexToRgb(state.bg));
    card.style.setProperty('--name-scale', String(state.scale / 100));

    FONTS.forEach(function (c) { card.classList.toggle(c, c === state.font); });
    BGS.forEach(function (c) { card.classList.toggle(c, c === state.bgstyle); });
    SIZES.forEach(function (c) { card.classList.toggle(c, c === state.size); });
    card.classList.toggle('is-foil', !!state.foil);

    var rtl = RTL_FONTS.indexOf(state.font) !== -1;
    card.classList.toggle('is-rtl', rtl);
    card.setAttribute('dir', rtl ? 'rtl' : 'ltr');

    card.querySelectorAll('.card-art .art').forEach(function (a) {
      a.classList.toggle('is-on', a.getAttribute('data-art') === state.art);
    });
    // ring ornaments need a narrower text column - cards.css keys off this
    card.setAttribute('data-art', state.art);

    refit();
    syncControls();
  }

  // Re-measure whenever the content changes: adding a line can push the page
  // over, and deleting one gives the room back. Typing is debounced because
  // each measurement forces a reflow.
  var refitTimer = null;

  function refit() {
    if (typeof window.paperloomFit !== 'function') return;
    var fit = window.paperloomFit(card);
    var warn = document.querySelector('.ed-fit-note');
    if (!warn) return;
    warn.hidden = fit > 0.94;
    warn.textContent = fit <= 0.63
      ? 'This is more than one page holds even at the smallest size - shorten a section.'
      : 'Scaled to ' + Math.round(fit * 100) + '% to fit on one page. Shorten a section to get the size back.';
  }

  function scheduleRefit() {
    clearTimeout(refitTimer);
    refitTimer = setTimeout(refit, 120);
  }

  function toHex6(v) {
    if (/^#[0-9a-f]{6}$/i.test(v)) return v;
    if (/^#[0-9a-f]{3}$/i.test(v)) return '#' + v[1] + v[1] + v[2] + v[2] + v[3] + v[3];
    return '#ffffff';
  }

  function hexToRgb(v) {
    var h = toHex6(v).slice(1);
    return [parseInt(h.slice(0, 2), 16), parseInt(h.slice(2, 4), 16), parseInt(h.slice(4, 6), 16)].join(',');
  }

  function press(selector, attr, value) {
    document.querySelectorAll(selector).forEach(function (b) {
      b.setAttribute('aria-pressed', String(b.getAttribute(attr) === value));
    });
  }

  function syncControls() {
    document.querySelectorAll('[data-swatch]').forEach(function (b) {
      var p = b.getAttribute('data-swatch').split(',');
      b.setAttribute('aria-pressed',
        String(p[0] === state.bg && p[1] === state.ink && p[2] === state.accent));
    });
    press('[data-font]', 'data-font', state.font);
    press('[data-art]:not(.art)', 'data-art', state.art);
    press('[data-bg]', 'data-bg', state.bgstyle);
    press('[data-size]', 'data-size', state.size);

    var ids = { 'ed-bg': 'bg', 'ed-ink': 'ink', 'ed-accent': 'accent' };
    Object.keys(ids).forEach(function (id) {
      var el = document.getElementById(id);
      if (el) el.value = toHex6(state[ids[id]]);
    });
    var foil = document.getElementById('ed-foil');
    if (foil) foil.checked = !!state.foil;
    var size = document.getElementById('ed-size');
    if (size && document.activeElement !== size) size.value = String(state.scale);
    var out = document.getElementById('ed-size-out');
    if (out) out.textContent = state.scale + '%';
  }

  // ---- the form -----------------------------------------------------------

  var statusEl = document.querySelector('.ed-status');
  var statusTimer = null;
  function flash(msg) {
    if (!statusEl) return;
    statusEl.textContent = msg;
    clearTimeout(statusTimer);
    statusTimer = setTimeout(function () { statusEl.textContent = ''; }, 2600);
  }

  FIELDS.forEach(function (f) {
    var input = document.querySelector('[data-text="' + f + '"]');
    var target = card.querySelector('[data-field="' + f + '"]');
    if (!input) return;

    input.value = htmlToText(state.texts[f]);

    input.addEventListener('input', function () {
      pushHistory(true);
      state.texts[f] = textToHtml(input.value);
      if (target) target.innerHTML = state.texts[f];
      save();
      scheduleRefit();
      flash('Saved in this browser');
    });

    if (target) {
      input.addEventListener('focus', function () { target.classList.add('is-target'); });
      input.addEventListener('blur', function () { target.classList.remove('is-target'); });
    }
  });

  // ---- inline editing on the card itself ----------------------------------

  card.classList.add('is-editable');
  FIELDS.forEach(function (f) {
    var el = card.querySelector('[data-field="' + f + '"]');
    if (!el) return;
    el.setAttribute('contenteditable', 'true');
    el.setAttribute('spellcheck', 'false');
    el.addEventListener('input', function () {
      pushHistory(true);
      state.texts[f] = el.innerHTML;
      var input = document.querySelector('[data-text="' + f + '"]');
      if (input) input.value = htmlToText(el.innerHTML);
      save();
      scheduleRefit();
      flash('Saved in this browser');
    });
    el.addEventListener('paste', function (e) {
      e.preventDefault();
      var text = (e.clipboardData || window.clipboardData).getData('text/plain');
      document.execCommand('insertText', false, text);
    });
    el.addEventListener('keydown', function (e) {
      if (e.key === 'Enter' && !e.shiftKey && f !== 'venue') e.preventDefault();
    });
  });

  // ---- controls -----------------------------------------------------------

  function bindChips(selector, attr, key) {
    document.querySelectorAll(selector).forEach(function (btn) {
      btn.addEventListener('click', function () {
        pushHistory(false);
        state[key] = btn.getAttribute(attr);
        apply(); save();
      });
    });
  }

  bindChips('[data-font]', 'data-font', 'font');
  bindChips('[data-bg]', 'data-bg', 'bgstyle');
  bindChips('[data-size]', 'data-size', 'size');
  bindChips('.ed-chip[data-art]', 'data-art', 'art');

  document.querySelectorAll('[data-swatch]').forEach(function (btn) {
    btn.addEventListener('click', function () {
      pushHistory(false);
      var p = btn.getAttribute('data-swatch').split(',');
      state.bg = p[0]; state.ink = p[1]; state.accent = p[2];
      state.foil = p[3] === '1';
      apply(); save();
    });
  });

  [['ed-bg', 'bg'], ['ed-ink', 'ink'], ['ed-accent', 'accent']].forEach(function (pair) {
    var input = document.getElementById(pair[0]);
    if (!input) return;
    input.addEventListener('input', function () {
      pushHistory(true);
      state[pair[1]] = input.value;
      apply(); save();
    });
  });

  var foilBox = document.getElementById('ed-foil');
  if (foilBox) {
    foilBox.addEventListener('change', function () {
      pushHistory(false);
      state.foil = foilBox.checked;
      apply(); save();
    });
  }

  var sizeRange = document.getElementById('ed-size');
  if (sizeRange) {
    sizeRange.addEventListener('input', function () {
      pushHistory(true);
      state.scale = parseInt(sizeRange.value, 10);
      apply(); save();
    });
  }

  var undoBtn = document.querySelector('[data-undo]');
  if (undoBtn) {
    undoBtn.addEventListener('click', function () {
      if (!undoStack.length) return;
      state = undoStack.pop();
      apply(); save();
      undoBtn.disabled = undoStack.length === 0;
      flash('Undone');
    });
  }

  var resetBtn = document.querySelector('[data-reset]');
  if (resetBtn) {
    resetBtn.addEventListener('click', function () {
      pushHistory(false);
      state = clone(initial);
      apply(); save();
      if (location.hash) history_replace();
      flash('Back to the original design');
    });
  }

  function history_replace() {
    window.history.replaceState(null, '', location.pathname);
  }

  var shareBtn = document.querySelector('[data-share]');
  if (shareBtn) {
    shareBtn.addEventListener('click', function () {
      var frag = '#c=' + encode(state);
      var url = location.origin + location.pathname + frag;
      window.history.replaceState(null, '', frag);
      if (navigator.clipboard && navigator.clipboard.writeText) {
        navigator.clipboard.writeText(url).then(
          function () { flash('Link copied - anyone who opens it sees your version'); },
          function () { window.prompt('Copy your link:', url); });
      } else {
        window.prompt('Copy your link:', url);
      }
    });
  }

  var printBtn = document.querySelector('[data-print]');
  if (printBtn) printBtn.addEventListener('click', function () { window.print(); });

  // ---- calendar: fill the dates from the month and year --------------------
  // The date cells are not fields - nobody wants to type thirty-one numbers.
  // They are worked out from whatever month and year are in the boxes, so leap
  // years and the weekday the month starts on are handled for you.
  var calGrid = card.querySelector('[data-calendar]');
  if (calGrid) {
    var MONTHS = ['january', 'february', 'march', 'april', 'may', 'june', 'july',
                  'august', 'september', 'october', 'november', 'december'];

    var fillCalendar = function () {
      var cells = calGrid.querySelectorAll('.cal-cell');
      if (!cells.length) return;

      var mRaw = (htmlToText(state.texts.month || '')).trim().toLowerCase();
      var yRaw = parseInt((htmlToText(state.texts.year || '')).replace(/\D/g, ''), 10);

      var mi = -1;
      for (var i = 0; i < 12; i++) {
        if (mRaw && MONTHS[i].indexOf(mRaw.slice(0, 3)) === 0) { mi = i; break; }
      }
      if (mi < 0 || !yRaw || yRaw < 1000 || yRaw > 9999) {
        // Not a month we recognise - leave the grid blank rather than guessing.
        cells.forEach(function (c) { c.textContent = ''; c.classList.add('is-blank'); });
        return;
      }

      var first = new Date(yRaw, mi, 1);
      // Date.getDay() is Sunday-first; the grid starts on Monday.
      var offset = (first.getDay() + 6) % 7;
      var days = new Date(yRaw, mi + 1, 0).getDate();

      cells.forEach(function (c, idx) {
        var day = idx - offset + 1;
        var inMonth = day >= 1 && day <= days;
        c.textContent = inMonth ? String(day) : '';
        c.classList.toggle('is-blank', !inMonth);
      });
    };

    // refit runs on every change - both apply() and the debounced text path go
    // through it - so hooking it once covers everything.
    var baseRefit = refit;
    refit = function () { fillCalendar(); baseRefit(); };
  }

  // ---- mobile: shrink the stage once it is scrolled past --------------------
  // A sentinel above the stage tells us when the full-size preview has left the
  // top of the screen; from then on it sticks as a compact strip so the page
  // stays visible while the form below it is filled in.
  (function () {
    if (!('IntersectionObserver' in window)) return;
    var sentinel = document.createElement('div');
    sentinel.style.cssText = 'height:1px;margin:0;padding:0;';
    stage.parentNode.insertBefore(sentinel, stage);

    var peek = document.createElement('button');
    peek.type = 'button';
    peek.className = 'stage-peek';
    peek.textContent = 'Expand';
    peek.addEventListener('click', function () {
      sentinel.scrollIntoView({ behavior: 'smooth', block: 'start' });
    });
    stage.appendChild(peek);

    // The observer's first callback fires before the page has settled, and it
    // reported the sentinel as already out of view - so the stage went mini at
    // the top of the page, with nothing scrolled. The reader saw the preview
    // paint full size and then jump to a third of it, and the page below it
    // moved up by about 230px: a layout shift of 0.128 on every template page,
    // where Google counts anything above 0.1 as failing.
    //
    // Nothing is scrolled past until something is scrolled, so the scroll
    // position is the honest test, and the observer only decides from there on.
    new IntersectionObserver(function (entries) {
      var scrolled = (window.pageYOffset || document.documentElement.scrollTop || 0) > 4;
      stage.classList.toggle('is-mini', scrolled && !entries[0].isIntersecting);
    }, { rootMargin: '-70px 0px 0px 0px' }).observe(sentinel);
  })();

  // ---- PNG download -------------------------------------------------------

  var pngBtn = document.querySelector('[data-png]');
  if (pngBtn) {
    pngBtn.addEventListener('click', function () {
      if (typeof html2canvas !== 'function') {
        flash('Image export unavailable - use Print or save as PDF');
        return;
      }
      pngBtn.disabled = true;
      var label = pngBtn.textContent;
      pngBtn.textContent = 'Rendering...';
      var ready = document.fonts && document.fonts.ready ? document.fonts.ready : Promise.resolve();
      ready.then(function () {
        // Export width per size. Print formats get 300dpi at their real
        // physical width; screen formats get the exact pixel size the platform
        // asks for, because uploading larger only means the platform
        // recompresses it and it comes back looking worse.
        var PX_TARGET = {
          // print
          'sz-5x7': 1500, 'sz-a5': 1748, 'sz-square': 1500,
          'sz-a4': 2480, 'sz-letter': 2550,
          'sz-cert': 3508, 'sz-cert-letter': 3300,
          'sz-bcard': 1050, 'sz-bcard-eu': 1004,
          'sz-a3': 3508, 'sz-a2': 4961, 'sz-poster-us': 5400,
          // screen
          'sz-ig': 1080, 'sz-ig45': 1080, 'sz-story': 1080,
          'sz-yt': 1280, 'sz-fbcover': 820, 'sz-linkedin': 1584,
          'sz-mrec': 600, 'sz-leaderboard': 1456, 'sz-halfpage': 600,
          'sz-logo': 1500, 'sz-logo-sq': 1500
        };
        var target = PX_TARGET[state.size] || 1500;
        return html2canvas(card, {
          scale: target / card.offsetWidth,
          backgroundColor: null,
          logging: false,
          useCORS: true,
          onclone: function (doc) {
            // html2canvas paints gradient backgrounds but ignores
            // background-clip:text, so foiled text would export as a solid bar.
            // The clone falls back to flat accent text.
            var el = doc.querySelector('.detail-stage .card-preview, .detail-stage .doc-preview');
            if (el) el.classList.add('is-exporting');
          }
        });
      }).then(function (canvas) {
        var link = document.createElement('a');
        link.download = slug + '.png';
        link.href = canvas.toDataURL('image/png');
        link.click();
        flash('Downloaded at print size (' + canvas.width + ' x ' + canvas.height + ' px)');
      }).catch(function () {
        flash('Could not render an image - use Print or save as PDF');
      }).then(function () {
        pngBtn.disabled = false;
        pngBtn.textContent = label;
      });
    });
  }

  apply();
})();
