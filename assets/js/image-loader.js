// Modern image loading and optimization
document.addEventListener('DOMContentLoaded', function() {
    const lazyImages = document.querySelectorAll('[data-src]');
    
    const imageOptions = {
        threshold: 0.1,
        rootMargin: '50px'
    };
    
    const imageObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                loadImage(img);
                observer.unobserve(img);
            }
        });
    }, imageOptions);
    
    function loadImage(img) {
        const src = img.getAttribute('data-src');
        if (!src) return;
        
        img.src = src;
        img.classList.add('fade-in');
        
        img.onload = () => {
            img.classList.add('loaded');
            img.removeAttribute('data-src');
        };
    }
    
    lazyImages.forEach(img => imageObserver.observe(img));
}); 