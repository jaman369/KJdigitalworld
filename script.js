/* ========================================
   KJ DIGITAL WORLD - Main JavaScript
   Optimized for Performance
   ======================================== */

// ---- Loading Screen ----
const loader = document.getElementById('loader');
if (loader) {
  const hideLoader = () => {
    loader.classList.add('hidden');
    // Remove from DOM after transition to free resources
    loader.addEventListener('transitionend', () => {
      loader.remove();
    }, { once: true });
  };
  window.addEventListener('load', () => setTimeout(hideLoader, 600));
  // Fallback
  setTimeout(hideLoader, 2000);
}

// ---- Navbar Scroll Effect ----
const navbar = document.getElementById('navbar');
let lastScrollY = 0;
let ticking = false;

function updateNavbar() {
  if (navbar) {
    if (lastScrollY > 50) {
      navbar.classList.add('scrolled');
    } else {
      navbar.classList.remove('scrolled');
    }
  }
  ticking = false;
}

window.addEventListener('scroll', () => {
  lastScrollY = window.scrollY;
  if (!ticking) {
    requestAnimationFrame(updateNavbar);
    ticking = true;
  }
}, { passive: true });

// Initial check
updateNavbar();

// ---- Mobile Nav Toggle ----
const navToggle = document.getElementById('navToggle');
const navLinks = document.getElementById('navLinks');

if (navToggle && navLinks) {
  navToggle.addEventListener('click', () => {
    navToggle.classList.toggle('active');
    navLinks.classList.toggle('open');
    document.body.style.overflow = navLinks.classList.contains('open') ? 'hidden' : '';
  });

  navLinks.querySelectorAll('a').forEach(link => {
    link.addEventListener('click', () => {
      navToggle.classList.remove('active');
      navLinks.classList.remove('open');
      document.body.style.overflow = '';
    });
  });
}

// ---- Active Nav Link ----
requestAnimationFrame(() => {
  const currentPage = window.location.pathname.split('/').pop() || 'index.html';
  document.querySelectorAll('.nav-links a:not(.nav-cta)').forEach(link => {
    const href = link.getAttribute('href');
    if (href === currentPage || (currentPage === '' && href === 'index.html')) {
      link.classList.add('active');
    }
  });
});

// ---- Scroll Animations (IntersectionObserver) ----
const scrollObserver = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.classList.add('visible');
      const children = entry.target.querySelectorAll('.stagger-child');
      children.forEach((child, i) => {
        child.style.transitionDelay = `${i * 0.1}s`;
        child.classList.add('visible');
      });
      scrollObserver.unobserve(entry.target);
    }
  });
}, { threshold: 0.1, rootMargin: '0px 0px -50px 0px' });

document.querySelectorAll('.animate-on-scroll').forEach(el => {
  scrollObserver.observe(el);
});

// ---- Counter Animation ----
function animateCounter(element) {
  const target = parseInt(element.getAttribute('data-count'));
  const suffix = element.getAttribute('data-suffix') || '';
  const duration = 1500;
  const startTime = performance.now();

  function step(currentTime) {
    const elapsed = currentTime - startTime;
    const progress = Math.min(elapsed / duration, 1);
    // Ease out cubic
    const eased = 1 - Math.pow(1 - progress, 3);
    element.textContent = Math.floor(target * eased) + suffix;
    if (progress < 1) {
      requestAnimationFrame(step);
    }
  }

  requestAnimationFrame(step);
}

const counterObserver = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      animateCounter(entry.target);
      counterObserver.unobserve(entry.target);
    }
  });
}, { threshold: 0.5 });

document.querySelectorAll('[data-count]').forEach(counter => {
  counterObserver.observe(counter);
});

// ---- Skill Bar Animation ----
const skillObserver = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      const fill = entry.target.querySelector('.skill-bar-fill');
      if (fill) {
        fill.style.width = fill.getAttribute('data-width') + '%';
      }
      skillObserver.unobserve(entry.target);
    }
  });
}, { threshold: 0.3 });

document.querySelectorAll('.skill-bar-item').forEach(bar => {
  skillObserver.observe(bar);
});

// ---- Scroll to Top Button ----
const scrollTopBtn = document.getElementById('scrollTop');
if (scrollTopBtn) {
  let scrollTopTicking = false;

  window.addEventListener('scroll', () => {
    if (!scrollTopTicking) {
      requestAnimationFrame(() => {
        if (window.scrollY > 500) {
          scrollTopBtn.classList.add('visible');
        } else {
          scrollTopBtn.classList.remove('visible');
        }
        scrollTopTicking = false;
      });
      scrollTopTicking = true;
    }
  }, { passive: true });

  scrollTopBtn.addEventListener('click', () => {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });
}

// ---- Contact Form ----
const contactForm = document.getElementById('contactForm');

const WEB3FORMS_ACCESS_KEY = '0fb8d7d9-5f7d-4098-98e3-f2cc4e9d4c9e';

if (contactForm) {
  contactForm.addEventListener('submit', (e) => {
    e.preventDefault();
    const inputs = contactForm.querySelectorAll('input[required], textarea[required]');
    let valid = true;

    inputs.forEach(input => {
      if (!input.value.trim()) {
        valid = false;
        input.style.borderColor = 'var(--danger)';
        setTimeout(() => { input.style.borderColor = ''; }, 2000);
      }
    });

    if (valid) {
      const submitBtn = contactForm.querySelector('.form-submit-btn, .f-submit, .btn-submit, button[type="submit"]');
      const originalBtnText = submitBtn.innerHTML;
      submitBtn.disabled = true;
      submitBtn.innerHTML = 'Sending...';

      const formData = new FormData(contactForm);
      formData.append('access_key', WEB3FORMS_ACCESS_KEY);
      
      // Ensure specific fields (like the custom budget chips) are appended if not automatically present
      const budgetVal = document.getElementById('budgetInput')?.value;
      if (budgetVal && !formData.has('budget')) {
        formData.append('budget', budgetVal);
      }
      
      // Optional: Add metadata
      formData.append('_subject', 'New Contact Form Submission');
      formData.append('_page', window.location.href);

      fetch('https://api.web3forms.com/submit', {
        method: 'POST',
        headers: {
          'Accept': 'application/json'
        },
        body: formData
      })
      .then(response => response.json())
      .then(result => {
        if (result.success) {
          // Show success state
          contactForm.style.display = 'none';
          const successMsg = document.getElementById('formSuccess');
          if (successMsg) successMsg.style.display = 'block';

          setTimeout(() => {
            contactForm.reset();
            contactForm.style.display = '';
            if (successMsg) successMsg.style.display = 'none';
          }, 5000);
        } else {
          console.warn('Form submission failed:', result.message);
          alert('Submission failed: ' + result.message);
        }
      })
      .catch(error => {
        console.error('Error submitting form:', error);
        alert('There was an error sending your message. Please try again.');
      })
      .finally(() => {
        submitBtn.disabled = false;
        submitBtn.innerHTML = originalBtnText;
      });
    }
  });
}

// ---- Budget Chips Logic ----
const budgetChips = document.querySelectorAll('.budget-chips .b-chip, .budget-pills .b-pill');
const budgetInput = document.getElementById('budgetInput');
if (budgetChips.length > 0 && budgetInput) {
  // Initialize selection
  const initValue = budgetInput.value;
  let found = false;
  budgetChips.forEach(chip => {
    if (chip.textContent.trim() === initValue) {
      chip.classList.add('sel');
      found = true;
    }
  });
  if (!found) {
    budgetChips[0].classList.add('sel');
    budgetInput.value = budgetChips[0].textContent.trim();
  }

  budgetChips.forEach(chip => {
    chip.addEventListener('click', () => {
      // Remove active styling from all chips
      budgetChips.forEach(c => c.classList.remove('sel'));
      // Add active styling to clicked chip
      chip.classList.add('sel');
      
      // Update hidden input value
      budgetInput.value = chip.textContent.trim();
    });
  });
}

// ---- FAQ Accordion Logic ----
const faqQuestions = document.querySelectorAll('.faq-q');
faqQuestions.forEach(question => {
  question.addEventListener('click', () => {
    const parent = question.closest('.faq-item');
    // Toggle current
    parent.classList.toggle('open');
    // Close others
    document.querySelectorAll('.faq-item').forEach(item => {
      if (item !== parent) item.classList.remove('open');
    });
  });
});

// ---- Smooth scroll for anchor links ----
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
  anchor.addEventListener('click', function (e) {
    const target = document.querySelector(this.getAttribute('href'));
    if (target) {
      e.preventDefault();
      target.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }
  });
});

// ---- Typing Effect for Hero ----
const typingElement = document.querySelector('.typing-text');
if (typingElement) {
  const words = ['SEO Expert', 'Ads Strategist', 'Web Designer', 'Content Creator'];
  let wordIndex = 0;
  let charIndex = 0;
  let isDeleting = false;

  function typeWord() {
    const currentWord = words[wordIndex];
    let typeSpeed;

    if (isDeleting) {
      typingElement.textContent = currentWord.substring(0, charIndex - 1);
      charIndex--;
      typeSpeed = 50;
    } else {
      typingElement.textContent = currentWord.substring(0, charIndex + 1);
      charIndex++;
      typeSpeed = 100;
    }

    if (!isDeleting && charIndex === currentWord.length) {
      typeSpeed = 2000;
      isDeleting = true;
    } else if (isDeleting && charIndex === 0) {
      isDeleting = false;
      wordIndex = (wordIndex + 1) % words.length;
      typeSpeed = 300;
    }

    setTimeout(typeWord, typeSpeed);
  }

  typeWord();
}

// ---- Parallax on mouse move (desktop only, rAF optimized) ----
const heroVisual = document.querySelector('.hero-visual');
if (heroVisual && window.matchMedia('(min-width: 768px)').matches) {
  let mouseX = 0, mouseY = 0;
  let rafId = null;

  document.addEventListener('mousemove', (e) => {
    mouseX = (e.clientX / window.innerWidth - 0.5) * 20;
    mouseY = (e.clientY / window.innerHeight - 0.5) * 20;
    if (!rafId) {
      rafId = requestAnimationFrame(() => {
        heroVisual.style.transform = `translate3d(${mouseX}px, ${mouseY}px, 0)`;
        rafId = null;
      });
    }
  }, { passive: true });
}

// ---- Brand Marquee Duplication ----
requestAnimationFrame(() => {
  const brandsTrack = document.querySelector('.marquee-track');
  if (brandsTrack) {
    brandsTrack.innerHTML += brandsTrack.innerHTML;
  }
});
