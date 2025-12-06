// Password Eye Toggle
document.querySelectorAll(".toggle-eye").forEach(eye => {
  eye.addEventListener("click", () => {
    let input = eye.previousElementSibling;

    if (input.type === "password") {
      input.type = "text";
      eye.classList.replace("fa-eye", "fa-eye-slash");
    } else {
      input.type = "password";
      eye.classList.replace("fa-eye-slash", "fa-eye");
    }
  });
});

// Tab switching
const signinTab = document.getElementById("signinTab");
const signupTab = document.getElementById("signupTab");
const signinSection = document.getElementById("signinSection");
const signupSection = document.getElementById("signupSection");
const goSignup = document.getElementById("goSignup");
const goSignin = document.getElementById("goSignin");

signinTab.onclick = () => {
  signinTab.classList.add("active");
  signupTab.classList.remove("active");
  signinSection.style.display = "block";
  signupSection.style.display = "none";
};

signupTab.onclick = () => {
  signupTab.classList.add("active");
  signinTab.classList.remove("active");
  signinSection.style.display = "none";
  signupSection.style.display = "block";
};

goSignup.onclick = () => signupTab.click();
goSignin.onclick = () => signinTab.click();
