document.addEventListener('DOMContentLoaded', function() {
    const mobileMenuButton = document.getElementById('mobile-menu-button');
    const mobileMenu = document.getElementById('mobile-menu');
    const header = document.getElementById('main-header');
    const headerHoverZone = document.getElementById('header-hover-zone');
    
    // Header scroll behavior
    let lastScrollY = window.scrollY;
    let isHeaderVisible = true;
    
    function handleScroll() {
        const currentScrollY = window.scrollY;
        
        // Clear any pending hover timeout when scrolling
        clearTimeout(hoverTimeout);
        
        // Show header when scrolling up or at the top
        if (currentScrollY < lastScrollY || currentScrollY < 100) {
            if (!isHeaderVisible) {
                header.style.transform = 'translateY(0)';
                headerHoverZone.style.pointerEvents = 'none';
                isHeaderVisible = true;
            }
        } 
        // Hide header when scrolling down (but not at the very top)
        else if (currentScrollY > lastScrollY && currentScrollY > 100) {
            if (isHeaderVisible) {
                header.style.transform = 'translateY(-100%)';
                headerHoverZone.style.pointerEvents = 'auto';
                isHeaderVisible = false;
            }
        }
        
        lastScrollY = currentScrollY;
    }
    
    // Header hover behavior
    let hoverTimeout;
    
    function showHeader() {
        if (!isHeaderVisible) {
            header.style.transform = 'translateY(0)';
            headerHoverZone.style.pointerEvents = 'none';
            isHeaderVisible = true;
        }
        clearTimeout(hoverTimeout);
    }
    
    function hideHeader() {
        if (window.scrollY > 100 && isHeaderVisible) {
            hoverTimeout = setTimeout(() => {
                if (isHeaderVisible) {
                    header.style.transform = 'translateY(-100%)';
                    headerHoverZone.style.pointerEvents = 'auto';
                    isHeaderVisible = false;
                }
            }, 500);
        }
    }
    
    // Hover zone events
    headerHoverZone.addEventListener('mouseenter', showHeader);
    headerHoverZone.addEventListener('mouseleave', hideHeader);
    
    // Header events (when header is visible)
    header.addEventListener('mouseenter', function() {
        clearTimeout(hoverTimeout);
    });
    
    header.addEventListener('mouseleave', function() {
        hideHeader();
    });
    
    // Add scroll event listener
    window.addEventListener('scroll', handleScroll, { passive: true });
    
    // Logo link scroll to top functionality
    const logoLink = document.getElementById('logo-link');
    logoLink.addEventListener('click', function(e) {
        e.preventDefault();
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });

    mobileMenuButton.addEventListener('click', function() {
        mobileMenu.classList.toggle('hidden');
    });
    
    // Close mobile menu when a link is clicked
    const navLinks = document.querySelectorAll('#mobile-menu a');
    navLinks.forEach(link => {
        link.addEventListener('click', () => {
             mobileMenu.classList.add('hidden');
        });
    });

    // Scroll-triggered animations
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-active');
            }
        });
    }, observerOptions);

    // Observe elements with animation classes
    const animatedElements = document.querySelectorAll('.animate-fade-in-up, .animate-fade-in-left, .animate-fade-in-right');
    animatedElements.forEach(el => {
        observer.observe(el);
    });

    // Smooth scrolling for navigation links
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

    // Mobile About View More functionality
    const aboutViewMoreBtn = document.getElementById('about-view-more');
    const aboutViewLessBtn = document.getElementById('about-view-less');
    const aboutMoreContent = document.getElementById('about-more-content');
    const aboutSkillsContent = document.getElementById('about-skills-content');
    
    if (aboutViewMoreBtn && aboutViewLessBtn && aboutMoreContent && aboutSkillsContent) {
        aboutViewMoreBtn.addEventListener('click', function() {
            aboutMoreContent.classList.remove('hidden');
            aboutSkillsContent.classList.remove('hidden');
            aboutViewMoreBtn.style.display = 'none';
            aboutViewLessBtn.style.display = 'block';
            
            // Scroll to top of about section on mobile
            if (window.innerWidth < 768) {
                document.getElementById('about').scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        });
        
        aboutViewLessBtn.addEventListener('click', function() {
            aboutMoreContent.classList.add('hidden');
            aboutSkillsContent.classList.add('hidden');
            aboutViewMoreBtn.style.display = 'block';
            aboutViewLessBtn.style.display = 'none';
            
            // Scroll back to the top of the About Me box content on mobile
            if (window.innerWidth < 768) {
                // Find the About Me box container and scroll to its top
                const aboutBox = aboutViewMoreBtn.closest('.rounded-lg');
                if (aboutBox) {
                    aboutBox.scrollIntoView({ behavior: 'smooth', block: 'start' });
                }
            }
        });
        
        // Initially hide the View Less button
        aboutViewLessBtn.style.display = 'none';
    }

    // Mobile Project View More functionality
    const projectButtons = [
        { btn: 'pike-view-more', content: 'pike-more-content' },
        { btn: 'nn-view-more', content: 'nn-more-content' },
        { btn: 'algorithm-view-more', content: 'algorithm-more-content' },
        { btn: 'vcs-view-more', content: 'vcs-more-content' },
        { btn: 'recipe-view-more', content: 'recipe-more-content' }
    ];

    projectButtons.forEach(({ btn, content }) => {
        const button = document.getElementById(btn);
        const contentDiv = document.getElementById(content);
        
        if (button && contentDiv) {
            // Find the project container (the parent div with the project content)
            const projectContainer = button.closest('.rounded-lg');
            
            button.addEventListener('click', function() {
                if (contentDiv.classList.contains('hidden')) {
                    contentDiv.classList.remove('hidden');
                    button.textContent = 'View Less';
                    // Scroll to top of projects section on mobile
                    if (window.innerWidth < 768) {
                        document.getElementById('projects').scrollIntoView({ behavior: 'smooth', block: 'start' });
                    }
                } else {
                    contentDiv.classList.add('hidden');
                    button.textContent = 'View More';
                    // Scroll back to the top of the specific project container on mobile
                    if (window.innerWidth < 768 && projectContainer) {
                        // Add a small offset to account for the fixed header
                        const headerHeight = 64; // 4rem = 64px (smaller mobile header)
                        const elementPosition = projectContainer.getBoundingClientRect().top + window.pageYOffset;
                        const offsetPosition = elementPosition - headerHeight;
                        
                        window.scrollTo({
                            top: offsetPosition,
                            behavior: 'smooth'
                        });
                    }
                }
            });
        }
    });
});
