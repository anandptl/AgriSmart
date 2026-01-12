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


function sendSignupOtp() {
  const email = document.getElementById("signupEmail").value;

  fetch("/auth/send-otp", {
    method: "POST",
    headers: {"Content-Type": "application/json"},
    body: JSON.stringify({ email })
  })
  .then(res => res.json())
  .then(data => {
    if (data.status === "success") {
	
      Swal.fire({
        icon: "success",
        title: "Please Wait",
        text: data.message,
        timer: 2500,
        showConfirmButton: false,
        toast: true,
        position: "top-end"
      });
    } else {
      Swal.fire({
        icon: "error",
        title: "Error",
        text: data.message,
        timer: 3000,
        showConfirmButton: false,
        toast: true,
        position: "top-end"
      });
    }
  })
  .catch(() => {
    Swal.fire({
      icon: "error",
      title: "Server Error",
      text: "Something went wrong!",
      toast: true,
      position: "top-end",
      timer: 3000,
      showConfirmButton: false
    });
  });
}

function verifySignupOtp() {
  const email = document.getElementById("signupEmail").value;
  const otp = document.getElementById("signupOtp").value;

  fetch("/auth/signup-verify-otp", {
    method: "POST",
    headers: {"Content-Type": "application/json"},
    body: JSON.stringify({ email, otp })
  })
  .then(res => res.json())
  .then(data => {
    if (data.status === "success") {
		
	document.getElementById("otpStatus").innerHTML =
	       "<span style='color:green'>OTP Verified ✔</span>";
      Swal.fire({
        icon: "success",
        title: "Verified",
        text: "OTP Verified Successfully ✔",
        toast: true,
        position: "top-end",
        timer: 2500,
        showConfirmButton: false
      });
	  
	document.getElementById("createAccountBtn").style.display = "block";
	document.querySelector("button[onclick='sendSignupOtp()']").disabled = true;
	document.querySelector("button[onclick='verifySignupOtp()']").disabled = true;

	
    } else {
	document.getElementById("otpStatus").innerHTML =
	        "<span style='color:red'>Invalid OTP ❌</span>";
      Swal.fire({
        icon: "error",
        title: "Invalid OTP",
        text: data.message,
        toast: true,
        position: "top-end",
        timer: 3000,
        showConfirmButton: false
      });
    }
  });
}
