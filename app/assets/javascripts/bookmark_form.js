// Enhanced Bookmark Form Interactions
document.addEventListener('DOMContentLoaded', function() {
  const bookmarkForm = document.querySelector('.bookmark-form');
  
  if (bookmarkForm) {
    // URL validation and preview
    const urlField = bookmarkForm.querySelector('#bookmark_address');
    if (urlField) {
      urlField.addEventListener('blur', function() {
        validateUrl(this);
      });
      
      urlField.addEventListener('input', function() {
        clearValidation(this);
      });
    }
    
    // Auto-focus first empty field
    const firstEmptyField = bookmarkForm.querySelector('input[type="text"]:not([readonly]):not([value]), input[type="url"]:not([readonly]):not([value])');
    if (firstEmptyField && !firstEmptyField.value.trim()) {
      firstEmptyField.focus();
    }
    
    // Enhanced form submission
    bookmarkForm.addEventListener('submit', function(e) {
      if (!validateForm(this)) {
        e.preventDefault();
        return false;
      }
      
      // Add loading state
      const submitBtn = this.querySelector('input[type="submit"], button[type="submit"]');
      if (submitBtn) {
        submitBtn.disabled = true;
        submitBtn.classList.add('loading');
        const originalText = submitBtn.value || submitBtn.textContent;
        submitBtn.value = 'Saving...';
        
        // Reset if form submission fails
        setTimeout(() => {
          submitBtn.disabled = false;
          submitBtn.classList.remove('loading');
          submitBtn.value = originalText;
        }, 5000);
      }
    });
    
    // Tag input enhancements
    const tagField = bookmarkForm.querySelector('#bookmark_tag_list');
    if (tagField) {
      tagField.addEventListener('keydown', function(e) {
        if (e.key === 'Enter') {
          e.preventDefault();
          // Add tag behavior can be implemented here
        }
      });
    }
  }
});

function validateUrl(field) {
  const url = field.value.trim();
  const urlPattern = /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/;
  
  if (url && !urlPattern.test(url)) {
    showFieldError(field, 'Please enter a valid URL');
    return false;
  } else if (url) {
    showFieldSuccess(field, 'URL looks good!');
    return true;
  }
  
  clearValidation(field);
  return true;
}

function validateForm(form) {
  let isValid = true;
  
  // Required field validation
  const requiredFields = form.querySelectorAll('input[required], textarea[required]');
  requiredFields.forEach(field => {
    if (!field.value.trim()) {
      showFieldError(field, 'This field is required');
      isValid = false;
    }
  });
  
  // URL validation
  const urlField = form.querySelector('#bookmark_address');
  if (urlField && !validateUrl(urlField)) {
    isValid = false;
  }
  
  return isValid;
}

function showFieldError(field, message) {
  clearValidation(field);
  field.classList.add('is-invalid');
  
  const feedback = document.createElement('div');
  feedback.className = 'invalid-feedback';
  feedback.textContent = message;
  field.parentNode.appendChild(feedback);
}

function showFieldSuccess(field, message) {
  clearValidation(field);
  field.classList.add('is-valid');
  
  if (message) {
    const feedback = document.createElement('div');
    feedback.className = 'valid-feedback';
    feedback.textContent = message;
    field.parentNode.appendChild(feedback);
  }
}

function clearValidation(field) {
  field.classList.remove('is-invalid', 'is-valid');
  
  // Remove existing feedback
  const existingFeedback = field.parentNode.querySelectorAll('.invalid-feedback, .valid-feedback');
  existingFeedback.forEach(feedback => feedback.remove());
}