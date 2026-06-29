// yaml.org Custom JavaScript

// MathJax configuration
window.MathJax = {
  tex: {
    inlineMath: [['$', '$'], ['\\(', '\\)']],
    displayMath: [['$$', '$$'], ['\\[', '\\]']],
    processEscapes: true,
    processEnvironments: true
  },
  options: {
    ignoreHtmlClass: 'tex2jax_ignore',
    processHtmlClass: 'tex2jax_process'
  }
};

// Custom functionality for yaml.org
document.addEventListener('DOMContentLoaded', function() {
  
  // Add smooth scrolling to anchor links
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      e.preventDefault();
      const target = document.querySelector(this.getAttribute('href'));
      if (target) {
        target.scrollIntoView({
          behavior: 'smooth',
          block: 'start'
        });
      }
    });
  });

  // Add sponsor card hover effects
  document.querySelectorAll('.sponsor-card').forEach(card => {
    card.addEventListener('mouseenter', function() {
      this.style.transform = 'translateY(-4px)';
    });
    
    card.addEventListener('mouseleave', function() {
      this.style.transform = 'translateY(0)';
    });
  });

  // Add stats counter animation
  function animateCounters() {
    document.querySelectorAll('.stat-number').forEach(counter => {
      const target = parseInt(counter.textContent);
      const duration = 2000;
      const step = target / (duration / 16);
      let current = 0;
      
      const timer = setInterval(() => {
        current += step;
        if (current >= target) {
          current = target;
          clearInterval(timer);
        }
        counter.textContent = Math.floor(current).toLocaleString();
      }, 16);
    });
  }

  // Trigger counter animation when stats come into view
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        animateCounters();
        observer.unobserve(entry.target);
      }
    });
  });

  const statsSection = document.querySelector('.stats-grid');
  if (statsSection) {
    observer.observe(statsSection);
  }

  // Add mobile menu improvements
  const mobileMenuToggle = document.querySelector('.md-header__button');
  if (mobileMenuToggle) {
    mobileMenuToggle.addEventListener('click', function() {
      document.body.classList.toggle('mobile-menu-open');
    });
  }

  // Add search highlighting
  const searchInput = document.querySelector('.md-search__input');
  if (searchInput) {
    searchInput.addEventListener('input', function() {
      const query = this.value.toLowerCase();
      if (query.length > 2) {
        highlightSearchResults(query);
      } else {
        clearSearchHighlights();
      }
    });
  }

  // Search result highlighting function
  function highlightSearchResults(query) {
    clearSearchHighlights();
    
    document.querySelectorAll('main').forEach(main => {
      const walker = document.createTreeWalker(
        main,
        NodeFilter.SHOW_TEXT,
        null,
        false
      );

      let node;
      while (node = walker.nextNode()) {
        const text = node.textContent;
        if (text.toLowerCase().includes(query)) {
          const span = document.createElement('span');
          span.className = 'search-highlight';
          span.style.backgroundColor = 'rgba(255, 193, 7, 0.3)';
          span.style.padding = '2px 4px';
          span.style.borderRadius = '2px';
          
          const regex = new RegExp(`(${query})`, 'gi');
          const highlightedText = text.replace(regex, '<span class="search-highlight">$1</span>');
          
          const wrapper = document.createElement('span');
          wrapper.innerHTML = highlightedText;
          node.parentNode.replaceChild(wrapper, node);
        }
      }
    });
  }

  // Clear search highlights
  function clearSearchHighlights() {
    document.querySelectorAll('.search-highlight').forEach(highlight => {
      const parent = highlight.parentNode;
      parent.replaceChild(document.createTextNode(highlight.textContent), highlight);
      parent.normalize();
    });
  }

  // Add sponsor tier selection
  document.querySelectorAll('.sponsor-tier-selector').forEach(selector => {
    selector.addEventListener('change', function() {
      const selectedTier = this.value;
      updateSponsorDisplay(selectedTier);
    });
  });

  // Update sponsor display based on selection
  function updateSponsorDisplay(tier) {
    document.querySelectorAll('.sponsor-card').forEach(card => {
      if (tier === 'all' || card.classList.contains(tier)) {
        card.style.display = 'block';
      } else {
        card.style.display = 'none';
      }
    });
  }

  // Add smooth page transitions
  document.querySelectorAll('a[href^="/"]').forEach(link => {
    link.addEventListener('click', function(e) {
      if (this.hostname === window.location.hostname) {
        e.preventDefault();
        const targetUrl = this.href;
        
        // Add loading state
        document.body.classList.add('page-loading');
        
        // Simulate page transition
        setTimeout(() => {
          window.location.href = targetUrl;
        }, 300);
      }
    });
  });

  // Add back to top button
  const backToTopButton = document.createElement('button');
  backToTopButton.innerHTML = '↑';
  backToTopButton.className = 'back-to-top';
  backToTopButton.style.cssText = `
    position: fixed;
    bottom: 20px;
    right: 20px;
    width: 50px;
    height: 50px;
    border-radius: 50%;
    background: var(--yaml-primary);
    color: white;
    border: none;
    cursor: pointer;
    font-size: 20px;
    opacity: 0;
    transition: opacity 0.3s ease;
    z-index: 1000;
  `;

  document.body.appendChild(backToTopButton);

  // Show/hide back to top button
  window.addEventListener('scroll', function() {
    if (window.pageYOffset > 300) {
      backToTopButton.style.opacity = '1';
    } else {
      backToTopButton.style.opacity = '0';
    }
  });

  // Back to top functionality
  backToTopButton.addEventListener('click', function() {
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    });
  });

  // Add sponsor contact form handling
  const sponsorForms = document.querySelectorAll('.sponsor-contact-form');
  sponsorForms.forEach(form => {
    form.addEventListener('submit', function(e) {
      e.preventDefault();
      
      // Get form data
      const formData = new FormData(this);
      const data = Object.fromEntries(formData);
      
      // Show success message
      showNotification('Thank you for your interest! We\'ll be in touch soon.', 'success');
      
      // Reset form
      this.reset();
    });
  });

  // Notification system
  function showNotification(message, type = 'info') {
    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;
    notification.textContent = message;
    notification.style.cssText = `
      position: fixed;
      top: 20px;
      right: 20px;
      padding: 1rem 1.5rem;
      border-radius: 4px;
      color: white;
      font-weight: 500;
      z-index: 1001;
      transform: translateX(100%);
      transition: transform 0.3s ease;
    `;

    // Set background color based on type
    switch (type) {
      case 'success':
        notification.style.background = 'var(--yaml-secondary)';
        break;
      case 'error':
        notification.style.background = '#f44336';
        break;
      default:
        notification.style.background = 'var(--yaml-primary)';
    }

    document.body.appendChild(notification);

    // Animate in
    setTimeout(() => {
      notification.style.transform = 'translateX(0)';
    }, 100);

    // Auto-remove after 5 seconds
    setTimeout(() => {
      notification.style.transform = 'translateX(100%)';
      setTimeout(() => {
        document.body.removeChild(notification);
      }, 300);
    }, 5000);
  }

  console.log('yaml.org JavaScript loaded successfully!');
}); 
