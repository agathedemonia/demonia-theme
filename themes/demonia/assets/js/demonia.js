/**
 * Démonia : interactions de l'en-tête (reprise de site-header.tsx, mega-menu.tsx,
 * mobile-nav.tsx et use-scroll-direction.ts de la maquette Lovable), sans dépendance.
 *
 * Les classes ci-dessous sont écrites en entier pour que Tailwind les génère :
 * tw:max-h-0 tw:max-h-16 tw:rotate-180 tw:text-label-deep tw:border-label tw:text-label
 * tw:border-transparent tw:text-night/50 tw:overflow-hidden
 */
(function () {
  'use strict';

  var header = document.querySelector('[data-dm-header]');
  if (!header) return;

  function splitCls(value) {
    return (value || '').split(/\s+/).filter(Boolean);
  }

  // ===== État clair / sombre (classes portées par data-cls-light / data-cls-dark) =====
  var scrolled = false;

  function applyVariant() {
    document.querySelectorAll('[data-cls-light], [data-cls-dark]').forEach(function (el) {
      var light = splitCls(el.getAttribute('data-cls-light'));
      var dark = splitCls(el.getAttribute('data-cls-dark'));
      var off = scrolled ? light : dark;
      var on = scrolled ? dark : light;
      off.forEach(function (c) { if (on.indexOf(c) === -1) el.classList.remove(c); });
      on.forEach(function (c) { el.classList.add(c); });
    });
    header.setAttribute('data-scrolled', scrolled ? 'true' : 'false');

    // Menu beige et bandeau des pratiques : repliés à la descente.
    header.querySelectorAll('[data-dm-collapsible]').forEach(function (el) {
      el.classList.toggle('tw:max-h-0', scrolled);
      el.classList.toggle('tw:max-h-16', !scrolled);
      if (scrolled) el.setAttribute('aria-hidden', 'true'); else el.removeAttribute('aria-hidden');
      el.querySelectorAll('[data-dm-focusable]').forEach(function (f) {
        if (scrolled) f.setAttribute('tabindex', '-1'); else f.removeAttribute('tabindex');
      });
    });
  }

  function setScrolled(value) {
    if (value === scrolled) return;
    scrolled = value;
    if (scrolled) closeMega();
    applyVariant();
  }

  // Mouvement cumulé dans une même direction, seuil de 60 px (comme Lovable) :
  // les petites oscillations ne font pas clignoter l'en-tête.
  var lastY = window.scrollY;
  var acc = 0;
  function onScroll() {
    var y = window.scrollY;
    var d = y - lastY;
    lastY = y;
    if (y <= 10) { acc = 0; setScrolled(false); return; }
    acc = d * acc < 0 ? d : acc + d;
    if (acc > 60) { setScrolled(true); acc = 0; }
    else if (acc < -60) { setScrolled(false); acc = 0; }
  }

  // ===== Grand menu déroulant (ordinateur) =====
  var openMegaId = null;

  function setMega(id) {
    openMegaId = id;
    header.querySelectorAll('[data-dm-mega]').forEach(function (panel) {
      panel.hidden = panel.id !== id;
    });
    header.querySelectorAll('[data-dm-mega-trigger]').forEach(function (t) {
      var isOpen = t.getAttribute('data-dm-mega-trigger') === id;
      t.classList.toggle('tw:text-label-deep', isOpen);
      var btn = t.querySelector('button');
      if (btn) {
        btn.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
        var icon = btn.querySelector('svg');
        if (icon) icon.classList.toggle('tw:rotate-180', isOpen);
      }
    });
  }
  function closeMega() { if (openMegaId) setMega(null); }

  header.querySelectorAll('[data-dm-mega-trigger]').forEach(function (t) {
    var id = t.getAttribute('data-dm-mega-trigger');
    t.addEventListener('mouseenter', function () { setMega(id); });
    var btn = t.querySelector('button');
    if (btn) btn.addEventListener('click', function () { setMega(openMegaId === id ? null : id); });
  });
  header.querySelectorAll('[data-dm-mega-close]').forEach(function (a) {
    a.addEventListener('mouseenter', closeMega);
  });
  var megaZone = header.querySelector('[data-dm-mega-zone]');
  if (megaZone) megaZone.addEventListener('mouseleave', closeMega);

  // ===== Tiroir mobile =====
  var drawer = document.querySelector('[data-dm-drawer]');
  var drawerOpener = header.querySelector('[data-dm-drawer-open]');
  var lastFocus = null;

  function openDrawer() {
    if (!drawer) return;
    lastFocus = document.activeElement;
    drawer.hidden = false;
    document.documentElement.style.overflow = 'hidden';
    if (drawerOpener) drawerOpener.setAttribute('aria-expanded', 'true');
    var panel = drawer.querySelector('[data-dm-drawer-panel]');
    if (panel) panel.focus();
  }
  function closeDrawer() {
    if (!drawer || drawer.hidden) return;
    drawer.hidden = true;
    document.documentElement.style.overflow = '';
    if (drawerOpener) drawerOpener.setAttribute('aria-expanded', 'false');
    drawer.querySelectorAll('[data-dm-accordion]').forEach(function (b) { setAccordion(b, false); });
    if (lastFocus && lastFocus.focus) lastFocus.focus();
  }
  function setAccordion(btn, open) {
    btn.setAttribute('aria-expanded', open ? 'true' : 'false');
    var panel = btn.nextElementSibling;
    if (panel) panel.hidden = !open;
    var icon = btn.querySelector('svg');
    if (icon) icon.classList.toggle('tw:rotate-180', open);
  }

  if (drawerOpener) drawerOpener.addEventListener('click', openDrawer);
  if (drawer) {
    drawer.querySelectorAll('[data-dm-drawer-close]').forEach(function (el) {
      el.addEventListener('click', closeDrawer);
    });
    drawer.querySelectorAll('a').forEach(function (a) { a.addEventListener('click', closeDrawer); });
    drawer.querySelectorAll('[data-dm-tab]').forEach(function (tab) {
      tab.addEventListener('click', function () {
        var name = tab.getAttribute('data-dm-tab');
        drawer.querySelectorAll('[data-dm-tab]').forEach(function (t) {
          var active = t === tab;
          t.setAttribute('aria-selected', active ? 'true' : 'false');
          t.classList.toggle('tw:border-label', active);
          t.classList.toggle('tw:text-label', active);
          t.classList.toggle('tw:border-transparent', !active);
          t.classList.toggle('tw:text-night/50', !active);
        });
        drawer.querySelectorAll('[data-dm-panel]').forEach(function (p) {
          p.hidden = p.getAttribute('data-dm-panel') !== name;
        });
        drawer.querySelectorAll('[data-dm-accordion]').forEach(function (b) { setAccordion(b, false); });
      });
    });
    // Une seule sous-catégorie ouverte à la fois, comme dans la maquette.
    drawer.querySelectorAll('[data-dm-accordion]').forEach(function (btn) {
      btn.addEventListener('click', function () {
        var willOpen = btn.getAttribute('aria-expanded') !== 'true';
        drawer.querySelectorAll('[data-dm-accordion]').forEach(function (b) { setAccordion(b, false); });
        setAccordion(btn, willOpen);
      });
    });
  }

  document.addEventListener('keydown', function (e) {
    if (e.key !== 'Escape') return;
    closeMega();
    closeDrawer();
  });
  window.addEventListener('scroll', function () {
    closeMega();
    onScroll();
  }, { passive: true });
  window.addEventListener('resize', function () {
    if (window.innerWidth >= 768) closeDrawer();
  });

  // Le module panier remplace son bloc après chaque ajout : on réapplique l'état.
  new MutationObserver(function (mutations) {
    for (var i = 0; i < mutations.length; i++) {
      if (mutations[i].addedNodes.length) { applyVariant(); return; }
    }
  }).observe(header, { childList: true, subtree: true });

  applyVariant();
  onScroll();
})();
