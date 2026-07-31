//  Farmers Search...

document.addEventListener("DOMContentLoaded", function () {

    let farmerTimer;
    let buyerTimer;

    const farmerInput = document.getElementById("activeFarmersSearch");
    const buyerInput = document.getElementById("activeBuyersSearch");

    if (farmerInput) {
        farmerInput.addEventListener("keyup", function () {

            clearTimeout(farmerTimer);
            const keyword = this.value.trim();

            farmerTimer = setTimeout(() => {

                fetch(ctx + "/admin/farmers/search?keyword=" + encodeURIComponent(keyword))
                    .then(res => res.text())
                    .then(html => {
                        document.querySelector("#farmersTableBody").innerHTML = html;
                    })
                    .catch(err => console.error("Farmer search error:", err));

            }, 300);
        });
    }

    if (buyerInput) {
        buyerInput.addEventListener("keyup", function () {

            clearTimeout(buyerTimer);
            const keyword = this.value.trim();

            buyerTimer = setTimeout(() => {

                fetch(ctx + "/admin/buyers/search?keyword=" + encodeURIComponent(keyword))
                    .then(res => res.text())
                    .then(html => {
                        document.querySelector("#buyersTableBody").innerHTML = html;
                    })
                    .catch(err => console.error("Buyer search error:", err));

            }, 300);
        });
    }

});


function toggleDropdown(id, element) {

    var submenu = document.getElementById(id);

    submenu.classList.toggle("show");
    element.querySelector(".arrow").classList.toggle("rotate");
}


document.addEventListener("DOMContentLoaded", function () {

    let currentUrl = window.location.pathname;

    // Crop Process Pages
    if (currentUrl.includes("Organic") ||
        currentUrl.includes("Inorganic")) {

        document.getElementById("processSubmenu").classList.add("show");

        document
            .querySelector("[onclick*='processSubmenu'] .arrow")
            .classList.add("rotate");
    }

    // Crop Manage Pages
    if (currentUrl.includes("Manage-Crops") ||
        currentUrl.includes("Crops-List")) {

        document.getElementById("cropSubmenu").classList.add("show");

        document
            .querySelector("[onclick*='cropSubmenu'] .arrow")
            .classList.add("rotate");
    }

});




document.addEventListener("DOMContentLoaded", function () {

    document.addEventListener("click", function (e) {

        const btn = e.target;

        // Sirf block/unblock button pe chale
        if (btn.classList.contains("btn-block") ||
            btn.classList.contains("btn-unblock")) {

            e.preventDefault();   // page reload stop

            const url = btn.getAttribute("href");

            fetch(url)
                .then(res => res.text())  // controller call
                .then(() => {

                    const row = btn.closest("tr");
                    const statusCell = row.children[2]; // STATUS column

                    // Agar BLOCK button tha
                    if (btn.classList.contains("btn-block")) {

                        statusCell.innerHTML =
                            '<span class="status-blocked">BLOCKED</span>';

                        btn.textContent = "UNBLOCK";
                        btn.classList.remove("btn-block");
                        btn.classList.add("btn-unblock");
                        btn.href = url.replace("block", "unblock");

                    } else {

                        statusCell.innerHTML =
                            '<span class="status-active">ACTIVE</span>';

                        btn.textContent = "BLOCK";
                        btn.classList.remove("btn-unblock");
                        btn.classList.add("btn-block");
                        btn.href = url.replace("unblock", "block");
                    }

                })
                .catch(err => console.error("Error:", err));
        }

    });

});
