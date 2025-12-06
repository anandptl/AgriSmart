const sidebar = document.querySelector(".sidebar");
const main = document.querySelector(".main");

const overlay = document.createElement('div');
overlay.className = 'overlay';
document.body.appendChild(overlay);

function toggleSidebar() {
  sidebar.classList.toggle("active");
  main.classList.toggle("expanded");
  overlay.classList.toggle("active");
}

overlay.addEventListener('click', toggleSidebar);

