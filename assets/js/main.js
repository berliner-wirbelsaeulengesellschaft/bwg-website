const header = document.querySelector('[data-site-header]');
const menuToggle = document.querySelector('[data-menu-toggle]');
const menu = document.querySelector('[data-menu]');

function updateHeader() {
  header?.classList.toggle('is-scrolled', window.scrollY > 8);
}

function closeMenu({ returnFocus = false } = {}) {
  if (!menuToggle || !menu) return;
  const wasOpen = menuToggle.getAttribute('aria-expanded') === 'true';
  menuToggle.setAttribute('aria-expanded', 'false');
  menuToggle.setAttribute('aria-label', 'Navigation öffnen');
  menu.classList.remove('is-open');
  document.body.classList.remove('menu-open');

  if (returnFocus && wasOpen) menuToggle.focus();
}

menuToggle?.addEventListener('click', () => {
  const shouldOpen = menuToggle.getAttribute('aria-expanded') !== 'true';

  if (!shouldOpen) {
    closeMenu({ returnFocus: true });
    return;
  }

  menuToggle.setAttribute('aria-expanded', String(shouldOpen));
  menuToggle.setAttribute('aria-label', 'Navigation schließen');
  menu?.classList.add('is-open');
  document.body.classList.add('menu-open');
  window.requestAnimationFrame(() => menu?.querySelector('a[href]')?.focus());
});

menu?.querySelectorAll('a').forEach((link) => link.addEventListener('click', closeMenu));

document.addEventListener('keydown', (event) => {
  if (!menuToggle || !menu || menuToggle.getAttribute('aria-expanded') !== 'true') return;

  if (event.key === 'Escape') {
    event.preventDefault();
    closeMenu({ returnFocus: true });
    return;
  }

  if (event.key !== 'Tab') return;

  const focusableElements = [...menu.querySelectorAll('a[href]'), menuToggle];
  const firstElement = focusableElements[0];
  const lastElement = focusableElements.at(-1);

  if (event.shiftKey && document.activeElement === firstElement) {
    event.preventDefault();
    lastElement.focus();
  } else if (!event.shiftKey && document.activeElement === lastElement) {
    event.preventDefault();
    firstElement.focus();
  }
});

window.addEventListener('scroll', updateHeader, { passive: true });
updateHeader();
