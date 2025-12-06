// Smooth scroll to crop section on "Explore Features" click
const exploreBtn = document.querySelector('.secondary');
if (exploreBtn) {
  exploreBtn.addEventListener('click', () => {
    document.querySelector('.crops').scrollIntoView({ behavior: 'smooth' });
  });
}

// Optional: Smooth scroll for all internal links
document.querySelectorAll('a[href^="#"]').forEach(link => {
  link.addEventListener('click', e => {
    e.preventDefault();
    document.querySelector(link.getAttribute('href')).scrollIntoView({ behavior: 'smooth' });
  });
});
