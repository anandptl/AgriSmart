function sendOtp() {
  const email = document.getElementById("email").value;

  fetch("/auth/forgot-password", {
    method: "POST",
    headers: {"Content-Type": "application/json"},
    body: JSON.stringify({ email })
  })
  .then(res => res.json())
  .then(data => {
    if (data.status === "success") {
      Swal.fire({
        icon: "success",
        title: "OTP Sent",
        text: "OTP sent to your email",
        toast: true,
        position: "top-end",
        timer: 2500,
        showConfirmButton: false
      });

      document.getElementById("otpStep").style.display = "block";
    } else {
      Swal.fire("Error", data.message, "error");
    }
  });
}

function verifyOtp() {
  const email = document.getElementById("email").value;
  const otp = document.getElementById("otp").value;

  fetch("/auth/verify-forgot-otp", {
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
        text: "OTP Verified Successfully",
        toast: true,
        position: "top-end",
        timer: 2500,
        showConfirmButton: false
      });

      document.getElementById("passwordStep").style.display = "block";
      document.querySelector("button[onclick='sendOtp()']").disabled = true;
      document.querySelector("button[onclick='verifyOtp()']").disabled = true;
    } else {
      document.getElementById("otpStatus").innerHTML =
        "<span style='color:red'>Invalid OTP</span>";
    }
  });
}

function resetPassword() {
  const email = document.getElementById("email").value;
  const newPassword = document.getElementById("newPassword").value;

  fetch("/auth/reset-password", {
    method: "POST",
    headers: {"Content-Type": "application/json"},
    body: JSON.stringify({ email, newPassword })
  })
  .then(res => res.json())
  .then(data => {
    if (data.status === "success") {
      Swal.fire({
        icon: "success",
        title: "Password Updated",
        text: "You can login now",
      }).then(() => {
        window.location.href = "/login";
      });
    } else {
      Swal.fire("Error", data.message, "error");
    }
  });
}

function togglePassword() {
    const input = document.getElementById("newPassword");
    const eye = document.querySelector(".toggle-eye");

    if (input.type === "password") {
        input.type = "text";
        eye.classList.remove("fa-eye");
        eye.classList.add("fa-eye-slash");
    } else {
        input.type = "password";
        eye.classList.remove("fa-eye-slash");
        eye.classList.add("fa-eye");
    }
}

