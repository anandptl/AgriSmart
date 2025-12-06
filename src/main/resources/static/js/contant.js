document.getElementById("contactForm").addEventListener("submit", function(e){
  e.preventDefault();

  let name = document.getElementById("name").value.trim();
  let email = document.getElementById("email").value.trim();
  let message = document.getElementById("message").value.trim();
  let status = document.getElementById("formStatus");

  if(name === "" || email === "" || message === ""){
    status.style.color = "yellow";
    status.textContent = "Please fill all fields!";
    return;
  }

  status.style.color = "#38a169";
  status.textContent = "Message sent ✔";

  // Clear form
  document.getElementById("contactForm").reset();
});
