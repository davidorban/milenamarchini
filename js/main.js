// Menu mobile
document.addEventListener('DOMContentLoaded', () => {
  const hamburger = document.querySelector('.hamburger');
  const navMenu = document.querySelector('.nav-menu');

  if (hamburger && navMenu) {
    hamburger.addEventListener('click', () => {
      navMenu.classList.toggle('active');
    });

    // Chiudi il menu quando si clicca su un link
    document.querySelectorAll('.nav-link').forEach(link => {
      link.addEventListener('click', () => {
        navMenu.classList.remove('active');
      });
    });
  }

  // Animazione al caricamento della pagina
  const animateOnScroll = () => {
    const elements = document.querySelectorAll('.fade-in');
    
    elements.forEach(element => {
      const elementPosition = element.getBoundingClientRect().top;
      const windowHeight = window.innerHeight;
      
      if (elementPosition < windowHeight - 100) {
        element.classList.add('visible');
      }
    });
  };

  // Esegui l'animazione al caricamento e allo scroll
  window.addEventListener('scroll', animateOnScroll);
  animateOnScroll(); // Esegui all'avvio

  // Gestione form di contatto
  const contactForm = document.getElementById('contact-form');
  if (contactForm) {
    contactForm.addEventListener('submit', (e) => {
      e.preventDefault();
      
      // Qui andrebbe l'integrazione con un servizio di invio email
      // Per ora mostriamo solo un messaggio di successo
      const formData = new FormData(contactForm);
      let formValues = {};
      
      for (let [key, value] of formData.entries()) {
        formValues[key] = value;
      }
      
      console.log('Form inviato:', formValues);
      
      // Mostra messaggio di successo
      const successMessage = document.createElement('div');
      successMessage.className = 'alert success';
      successMessage.textContent = 'Grazie per il tuo messaggio! Ti risponderemo al più presto.';
      
      contactForm.reset();
      contactForm.parentNode.insertBefore(successMessage, contactForm);
      
      // Rimuovi il messaggio dopo 5 secondi
      setTimeout(() => {
        successMessage.remove();
      }, 5000);
    });
  }
});

// Filtro progetti
function filterProjects(category) {
  const projects = document.querySelectorAll('.project-card');
  const filterButtons = document.querySelectorAll('.filter-btn');
  
  // Aggiorna i pulsanti attivi
  filterButtons.forEach(btn => {
    if (btn.getAttribute('data-category') === category) {
      btn.classList.add('active');
    } else {
      btn.classList.remove('active');
    }
  });
  
  // Filtra i progetti
  projects.forEach(project => {
    const projectCategory = project.getAttribute('data-category');
    
    if (category === 'tutti' || projectCategory === category) {
      project.style.display = 'block';
      setTimeout(() => {
        project.style.opacity = '1';
      }, 100);
    } else {
      project.style.opacity = '0';
      setTimeout(() => {
        project.style.display = 'none';
      }, 300);
    }
  });
}
