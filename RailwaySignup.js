function validateForm() {
    const email = document.getElementById("email").value;
    const phone = document.getElementById("phonenumber").value;
    const password = document.getElementById("password").value;
    const confirmPassword = document.getElementById("confirm-password").value;

    const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z]+\.[a-zA-Z]{2,4}$/;
    const phonePattern = /^\d{10}$/; // Allowing 10-digit format
    const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

    const isValidEmail = emailPattern.test(email);
    const isValidPhone = phonePattern.test(phone);
    const isValidPassword = passwordPattern.test(password);

    if (!isValidEmail) {
        document.getElementById("email-error").textContent = "Invalid email format.";
    } else {
        document.getElementById("email-error").textContent = "";
    }

    if (!isValidPhone) {
        document.getElementById("phone-error").textContent = "Invalid phone number format (10 digits required).";
    } else {
        document.getElementById("phone-error").textContent = "";
    }

    if (!isValidPassword) {
        document.getElementById("password-error").textContent = "Invalid password format.";
    } else {
        document.getElementById("password-error").textContent = "";
    }

    if (password !== confirmPassword) {
        document.getElementById("password-error").textContent = "Passwords do not match. Please re-enter.";
        return false;
    }

    return true;
}
