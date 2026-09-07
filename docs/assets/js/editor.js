/* =============================================================================
   Card editor - edit text, colours, typeface and script direction in the
   browser. No account, no server: state lives in localStorage and, when the
   reader asks for a share link, in the URL hash.
   ========================================================================== */
(function () {
  var stage = document.querySelector('.detail-stage');
  if (!stage) return;

  var card = stage.querySelector('.card-preview');
  var slug = stage.getAttribute('data-template');
  if (!card || !slug) return;

  var FIELDS = ['pre', 'title', 'mid', 'date', 'venue'];
  var FONT_CLASSES = ['f-script', 'f-cormorant', 'f-cinzel', 'f-josefin',
                      'f-marcellus', 'f-urdu', 'f-amiri'];
  var RTL_FONTS = ['f-urdu', 'f-amiri'];
  var STORE_KEY = 'paperloom:' + slug;

  // ---- state -------------------------------------------------------------

  function readCard() {
    var texts = {};
    FIELDS.forEach(function (f) {
      var el = card.querySelector('[data-field="' + f + '"]');
      texts[f] = el ? el.innerHTML : '';
    });
    var current = FONT_CLASSES.filter(function (c) { return card.classList.contains(c); })[0];
    return {
      texts: texts,
      bg: card.style.getPropertyValue('--c-bg').trim(),
      ink: card.style.getPropertyValue('--c-ink').trim(),
      accent: card.style.getPropertyValue('--c-accent').trim(),
      font: current || 'f-cormorant'
    };
  }

  var initial = readCard();
  var state = null;

  function clone(o) { return JSON.parse(JSON.stringify(o)); }

  function encode(obj) {
    var bytes = new TextEncoder().encode(JSON.stringify(obj));
    var bin = '';
    bytes.forEach(function (b) { bin += String.fromCharCode(b); });
    return btoa(bin).replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '');
  }

  function decode(str) {
    try {
      var b64 = str.replace(/-/g, '+').replace(/_/g, '/');
      var bin = atob(b64);
      var bytes = new Uint8Array(bin.length);
      for (var i = 0; i < bin.length; i++) { bytes[i] = bin.charCodeAt(i); }
      return JSON.parse(new TextDecoder().decode(bytes));
    } catch (e) { return null; }
  }

  function merge(saved) {
    var s = clone(initial);
    if (!saved) return s;
    if (saved.texts) { FIELDS.forEach(function (f) {
      if (typeof saved.texts[f] === 'string') s.texts[f] = saved.texts[f];
    }); }
    ['bg', 'ink', 'accent'].forEach(function (k) {
      if (typeof saved[k] === 'string' && /^#[0-9a-f]{3,8}$/i.test(saved[k])) s[k] = saved[k];
    });
    if (FONT_CLASSES.indexOf(saved.font) !== -1) s.font = saved.font;
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

  // ---- render ------------------------------------------------------------

  function apply() {
    FIELDS.forEach(function (f) {
      var el = card.querySelector('[data-field="' + f + '"]');
      if (el && el.innerHTML !== state.texts[f]) el.innerHTML = state.texts[f];
    });
    card.style.setProperty('--c-bg', state.bg);
    card.style.setProperty('--c-ink', state.ink);
    card.style.setProperty('--c-accent', state.accent);
    card.style.setProperty('--c-soft', state.ink);
    FONT_CLASSES.forEach(function (c) { card.classList.toggle(c, c === state.font); });
    card.classList.toggle('is-rtl', RTL_FONTS.indexOf(state.font) !== -1);
    card.setAttribute('dir', RTL_FONTS.indexOf(state.font) !== -1 ? 'rtl' : 'ltr');
    syncControls();
  }

  function syncControls() {
    document.querySelectorAll('[data-swatch]').forEach(function (b) {
      var p = b.getAttribute('data-swatch').split(',');
      b.setAttribute('aria-pressed', String(p[0] === state.bg && p[1] === state.ink && p[2] === state.accent));
    });
    document.querySelectorAll('[data-font]').forEach(function (b) {
      b.setAttribute('aria-pressed', String(b.getAttribute('data-font') === state.font));
    });
    var bgI = document.getElementById('ed-bg');
    var inkI = document.getElementById('ed-ink');
    var acI = document.getElementById('ed-accent');
    if (bgI) bgI.value = toHex6(state.bg);
    if (inkI) inkI.value = toHex6(state.ink);
    if (acI) acI.value = toHex6(state.accent);
  }

  function toHex6(v) {
    if (/^#[0-9a-f]{6}$/i.test(v)) return v;
    if (/^#[0-9a-f]{3}$/i.test(v)) {
      return '#' + v[1] + v[1] + v[2] + v[2] + v[3] + v[3];
    }
    return '#ffffff';
  }

  // ---- inline editing ----------------------------------------------------

  card.classList.add('is-editable');
  FIELDS.forEach(function (f) {
    var el = card.querySelector('[data-field="' + f + '"]');
    if (!el) return;
    el.setAttribute('contenteditable', 'true');
    el.setAttribute('spellcheck', 'false');
    el.addEventListener('input', function () {
      state.texts[f] = el.innerHTML;
      save();
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

  // ---- controls ----------------------------------------------------------

  var statusEl = document.querySelector('.ed-status');
  var statusTimer = null;
  function flash(msg) {
    if (!statusEl) return;
    statusEl.textContent = msg;
    clearTimeout(statusTimer);
    statusTimer = setTimeout(function () { statusEl.textContent = ''; }, 2600);
  }

  document.querySelectorAll('[data-swatch]').forEach(function (btn) {
    btn.addEventListener('click', function () {
      var p = btn.getAttribute('data-swatch').split(',');
      state.bg = p[0]; state.ink = p[1]; state.accent = p[2];
      apply(); save();
    });
  });

  [['ed-bg', 'bg'], ['ed-ink', 'ink'], ['ed-accent', 'accent']].forEach(function (pair) {
    var input = document.getElementById(pair[0]);
    if (!input) return;
    input.addEventListener('input', function () {
      state[pair[1]] = input.value;
      apply(); save();
    });
  });

  document.querySelectorAll('[data-font]').forEach(function (btn) {
    btn.addEventListener('click', function () {
      state.font = btn.getAttribute('data-font');
      apply(); save();
    });
  });

  var resetBtn = document.querySelector('[data-reset]');
  if (resetBtn) {
    resetBtn.addEventListener('click', function () {
      state = clone(initial);
      apply(); save();
      if (location.hash) history.replaceState(null, '', location.pathname);
      flash('Back to the original design');
    });
  }

  var shareBtn = document.querySelector('[data-share]');
  if (shareBtn) {
    shareBtn.addEventListener('click', function () {
      var url = location.origin + location.pathname + '#c=' + encode(state);
      history.replaceState(null, '', '#c=' + encode(state));
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

  // ---- PNG download ------------------------------------------------------

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
        // 1500px wide = 5in at 300dpi
        return html2canvas(card, {
          scale: 1500 / card.offsetWidth,
          backgroundColor: null,
          logging: false,
          useCORS: true
        });
      }).then(function (canvas) {
        var link = document.createElement('a');
        link.download = slug + '.png';
        link.href = canvas.toDataURL('image/png');
        link.click();
        flash('Downloaded at print size (1500 x 2100 px)');
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
