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
    var password = document.getElementById('password').value.trim();

    if (enroll_id === "" || password === "") {
        alert("Both Enrollment ID and Password are required!");
        return false;
    }
    return true;
}
