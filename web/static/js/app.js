/* Gloves Shop - Application JavaScript */

// Cart State
let cart = JSON.parse(localStorage.getItem('cart')) || [];

// Update cart count in header
function updateCartCount() {
    const countElements = document.querySelectorAll('.cart-count');
    countElements.forEach(el => {
        el.textContent = cart.length;
    });
}

// Add to cart
function addToCart(name, price) {
    cart.push({ name, price, quantity: 1 });
    localStorage.setItem('cart', JSON.stringify(cart));
    updateCartCount();
    showNotification('Added to cart: ' + name);
}

// Show notification
function showNotification(message) {
    const notification = document.createElement('div');
    notification.style.cssText = `
        position: fixed;
        bottom: 20px;
        right: 20px;
        background: #1a1a1a;
        color: white;
        padding: 16px 24px;
        border-radius: 4px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.3);
        z-index: 9999;
        font-size: 0.95em;
    `;
    notification.textContent = message;
    document.body.appendChild(notification);
    
    setTimeout(() => {
        notification.style.opacity = '0';
        notification.style.transition = 'opacity 0.3s';
        setTimeout(() => notification.remove(), 300);
    }, 2500);
}

// Search
function performSearch(event) {
    if (event) event.preventDefault();
    const query = document.getElementById('searchInput').value;
    if (query.trim()) {
        window.location.href = 'search.html?q=' + encodeURIComponent(query);
    }
}

// Initialize
document.addEventListener('DOMContentLoaded', function() {
    updateCartCount();
    
    // Add to cart buttons
    document.querySelectorAll('.add-to-cart-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            const card = this.closest('.product-card');
            const name = card.querySelector('.product-name').textContent;
            const price = card.querySelector('.current-price').textContent;
            addToCart(name, price);
        });
    });
});