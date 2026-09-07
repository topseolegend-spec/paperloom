/* =============================================================================
   Card editor - wording, colours, lettering, ornament, background and size,
   all in the browser. No account, no server: state lives in localStorage and,
   when the reader asks for a share link, in the URL hash.
   ========================================================================== */
(function () {
  var stage = document.querySelector('.detail-stage');
  if (!stage) return;

  var card = stage.querySelector('.card-preview');
  var slug = stage.getAttribute('data-template');
  if (!card || !slug) return;

  var FIELDS = ['pre', 'title', 'mid', 'date', 'venue', 'note'];
  var FONTS = ['f-cormorant', 'f-playfair', 'f-bodoni', 'f-libre', 'f-marcellus',
               'f-italiana', 'f-cinzel', 'f-cinzel-dec', 'f-script', 'f-parisienne',
               'f-sacramento', 'f-josefin', 'f-tenor', 'f-urdu', 'f-amiri', 'f-naskh'];
  var RTL_FONTS = ['f-urdu', 'f-amiri', 'f-naskh'];
  var BGS = ['bg-plain', 'bg-grad', 'bg-wash', 'bg-edge'];
  var SIZES = ['sz-5x7', 'sz-a5', 'sz-square'];
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

    syncControls();
  }

  function toHex6(v) {
    if (/^#[0-9a-f]{6}$/i.test(v)) return v;
    if (/^#[0-9a-f]{3}$/i.test(v)) return '#' + v[1] + v[1] + v[2] + v[2] + v[3] + v[3];
    return '#ffffff';
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
        // 1500px on the long edge = 300dpi at 5 inches
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
