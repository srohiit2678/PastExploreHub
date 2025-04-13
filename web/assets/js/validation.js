document.addEventListener("DOMContentLoaded", function () {
    Demo1();
});
function Demo1() {
    var val = 1;
    var textElement = document.getElementById("x");
    if (!textElement) return;

    function updateText() {
        switch (val) {
            case 1:
                textElement.innerHTML = "Chameli Devi";
                val = 2;
                break;
            case 2:
                textElement.innerHTML = "Group Of";
                val = 3;
                break;
            default:
                textElement.innerHTML = "Institutions";
                val = 1;
                break;
        }
        setTimeout(updateText, 1000);
    }

    updateText();
}
      
      // register page
function check() {
    var password = document.getElementById('password').value;    
    var confirmPassword = document.getElementById("confirm-password").value;
    
    if (password.length < 6) {
        document.getElementById('password-error').innerText = "Password must be at least 6 characters long.";
        return false;
    } else {
        document.getElementById('password-error').innerText = "";
    }

    if (password !== confirmPassword) {
        document.getElementById('confirm-password-error').innerText = "Passwords do not match!";
        return false;
    } else {
        document.getElementById('confirm-password-error').innerText = "";
    }

    return true;
}
function validateForm(){
if(check())registerForm.submit();    
}

// login page
function validateLogin() {
    var enroll_id = document.getElementById('enroll_id').value.trim();
    var password =  document.getElementById('password').value.trim();

    if (enroll_id === "" || password === "") {
        alert("Both Enrollment ID and Password are required!");
        return false;
    }
    return true;
}


// 
function searching() {
    document.addEventListener("DOMContentLoaded", function () {
        var searchInput = document.getElementById("search");
        var tableRows = document.querySelectorAll("tbody tr");
        var toggleMenu = document.getElementById("toggle-menu");
        var sidebar = document.querySelector(".sidebar");

        // Check if elements exist before adding event listeners
        if (toggleMenu && sidebar) {
            toggleMenu.addEventListener("click", function () {
                sidebar.classList.toggle("active");
            });
        }

        // Search Functionality
        if (searchInput && tableRows.length > 0) {
            searchInput.addEventListener("keyup", function () {
                var filter = searchInput.value.toLowerCase();
                tableRows.forEach(function (row) {
                    var titleCell = row.children[1]; // Ensure this is the correct column
                    if (titleCell) {
                        var title = titleCell.textContent.toLowerCase();
                        row.style.display = title.includes(filter) ? "" : "none";
                    }
                });
            });
        }
    });
}

function TeacherDashBoard() {
    document.addEventListener("DOMContentLoaded", function () {
        var searchInput = document.getElementById("search");
        var tableRows = document.querySelectorAll("tbody tr");
        var deleteButtons = document.querySelectorAll(".delete");
        var editButtons = document.querySelectorAll(".edit");
        var toggleMenu = document.getElementById("toggle-menu");
        var sidebar = document.querySelector(".sidebar");

        // Toggle sidebar on mobile
        if (toggleMenu && sidebar) {
            toggleMenu.addEventListener("click", function () {
                sidebar.classList.toggle("active");
            });
        }

        // Search Functionality
        if (searchInput && tableRows.length > 0) {
            searchInput.addEventListener("keyup", function () {
                var filter = searchInput.value.toLowerCase();
                tableRows.forEach(function (row) {
                    var titleCell = row.children[1]; // Ensure correct column index
                    if (titleCell) {
                        var title = titleCell.textContent.toLowerCase();
                        row.style.display = title.includes(filter) ? "" : "none";
                    }
                });
            });
        }

        // Delete Confirmation
        if (deleteButtons.length > 0) {
            deleteButtons.forEach(function (button) {
                button.addEventListener("click", function () {
                    if (confirm("Are you sure you want to delete this project?")) {
                        this.closest("tr").remove();
                    }
                });
            });
        }

        // Edit Functionality (Placeholder)
        if (editButtons.length > 0) {
            editButtons.forEach(function (button) {
                button.addEventListener("click", function () {
                    alert("Edit feature will be implemented soon!");
                });
            });
        }
    });
}
