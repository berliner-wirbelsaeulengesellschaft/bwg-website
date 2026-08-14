const header = document.querySelector('[data-site-header]');
const menuToggle = document.querySelector('[data-menu-toggle]');
const menu = document.querySelector('[data-menu]');

function updateHeader() {
  header?.classList.toggle('is-scrolled', window.scrollY > 8);
}

function closeMenu() {
  if (!menuToggle || !menu) return;
  menuToggle.setAttribute('aria-expanded', 'false');
  menuToggle.setAttribute('aria-label', 'Navigation öffnen');
  menu.classList.remove('is-open');
  document.body.classList.remove('menu-open');
}

menuToggle?.addEventListener('click', () => {
  const shouldOpen = menuToggle.getAttribute('aria-expanded') !== 'true';
  menuToggle.setAttribute('aria-expanded', String(shouldOpen));
  menuToggle.setAttribute('aria-label', shouldOpen ? 'Navigation schließen' : 'Navigation öffnen');
  menu?.classList.toggle('is-open', shouldOpen);
  document.body.classList.toggle('menu-open', shouldOpen);
});

menu?.querySelectorAll('a').forEach((link) => link.addEventListener('click', closeMenu));

document.addEventListener('keydown', (event) => {
  if (event.key === 'Escape') closeMenu();
});

window.addEventListener('scroll', updateHeader, { passive: true });
updateHeader();
