(function () {
  var navToggle = document.querySelector('.nav-toggle');
  var nav = document.querySelector('.nav');
  if (navToggle && nav) {
    navToggle.addEventListener('click', function () {
      var open = nav.classList.toggle('open');
      navToggle.setAttribute('aria-expanded', String(open));
    });
  }

  var ddToggle = document.querySelector('.dropdown-toggle');
  var ddPanel = document.querySelector('.dropdown-panel');
  if (ddToggle && ddPanel) {
    ddToggle.addEventListener('click', function (e) {
      e.stopPropagation();
      var open = ddPanel.hidden;
      ddPanel.hidden = !open;
      ddToggle.setAttribute('aria-expanded', String(open));
    });
    document.addEventListener('click', function (e) {
      if (!ddPanel.hidden && !ddPanel.contains(e.target) && e.target !== ddToggle) {
        ddPanel.hidden = true;
        ddToggle.setAttribute('aria-expanded', 'false');
      }
    });
    document.addEventListener('keydown', function (e) {
      if (e.key === 'Escape' && !ddPanel.hidden) {
        ddPanel.hidden = true;
        ddToggle.setAttribute('aria-expanded', 'false');
        ddToggle.focus();
      }
    });
  }

  var printBtn = document.querySelector('[data-print]');
  if (printBtn) {
    printBtn.addEventListener('click', function () { window.print(); });
  }
})();
