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

    const data = {
        name: name,
        email: email,
        message: message
    };

    fetch("/contact/send", {
        method: "POST",
        headers: {
            "Content-Type":"application/json"
        },
        body: JSON.stringify(data)
    })
    .then(res => res.text())
    .then(msg => {

        status.style.color = "#38a169";
        status.textContent = msg;

        document.getElementById("contactForm").reset();
    })
    .catch(err=>{
        status.style.color = "red";
        status.textContent = "Error sending message!";
    });

});