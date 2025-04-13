// Wait for the document to be fully loaded
document.addEventListener('DOMContentLoaded', function() {
    // Get the elements
    var editButton = document.getElementById('edit-profile');
    var saveButton = document.getElementById('save-profile');
    var cancelButton = document.getElementById('cancel-edit');
    var profileForm = document.getElementById('profile-form');
    var inputFields = document.querySelectorAll('.info-value');
    
    // Store original values for cancel functionality
    var originalValues = {};
    
    // Add click event listener to Edit button
    editButton.addEventListener('click', function() {
        // Show Save and Cancel buttons
        saveButton.style.display = 'inline-block';
        cancelButton.style.display = 'inline-block';
        // Hide Edit button
        editButton.style.display = 'none';
        
        // Make input fields editable
        inputFields.forEach(function(input) {
            // Store original value
            originalValues[input.id] = input.value;
            
            // Make field editable
            input.removeAttribute('readonly');
            input.classList.add('editable');
            
            // Student ID should not be editable
            if (input.id === 'student-id-input') {
                input.setAttribute('readonly', true);
                input.classList.remove('editable');
            }
        });
    });
    
    // Add click event listener to Save button
    saveButton.addEventListener('click', function() {
        // Update profile name display
        var nameInput = document.getElementById('name-input');
        document.querySelector('.profile-name').textContent = nameInput.value;
        document.querySelector('.sidebar-header h3').textContent = 'Hello, ' + nameInput.value;
        
        // Make input fields readonly again
        inputFields.forEach(function(input) {
            input.setAttribute('readonly', true);
            input.classList.remove('editable');
        });
        
        // Show Edit button, hide Save and Cancel buttons
        editButton.style.display = 'inline-block';
        saveButton.style.display = 'none';
        cancelButton.style.display = 'none';
        
        // Clear original values
        originalValues = {};
        
        // You would typically send the form data to a server here
        console.log('Profile updated successfully!');
    });
    
    // Add click event listener to Cancel button
    cancelButton.addEventListener('click', function() {
        // Restore original values
        for (var id in originalValues) {
            if (originalValues.hasOwnProperty(id)) {
                document.getElementById(id).value = originalValues[id];
            }
        }
        
        // Make input fields readonly again
        inputFields.forEach(function(input) {
            input.setAttribute('readonly', true);
            input.classList.remove('editable');
        });
        
        // Show Edit button, hide Save and Cancel buttons
        editButton.style.display = 'inline-block';
        saveButton.style.display = 'none';
        cancelButton.style.display = 'none';
        
        // Clear original values
        originalValues = {};
    });
    
    // Initialize responsive sidebar toggle
    var toggleMenuButton = document.getElementById('toggle-menu');
    var sidebar = document.querySelector('.sidebar');
    var mainContent = document.querySelector('.main-content');
    
    if (toggleMenuButton) {
        toggleMenuButton.addEventListener('click', function() {
            sidebar.classList.toggle('collapsed');
            mainContent.classList.toggle('expanded');
        });
    }
});
