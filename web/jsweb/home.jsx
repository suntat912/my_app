// Xử lý chuyển đổi tab active
const navItems = document.querySelectorAll('.nav-item');
navItems.forEach(item => {
    item.addEventListener('click', () => {
        navItems.forEach(i => i.classList.remove('active'));
        item.classList.add('active');
    });
});

// Xử lý dots indicator
const dots = document.querySelectorAll('.dot');
let currentDot = 0;

setInterval(() => {
    dots[currentDot].classList.remove('active');
    currentDot = (currentDot + 1) % dots.length;
    dots[currentDot].classList.add('active');
}, 3000);