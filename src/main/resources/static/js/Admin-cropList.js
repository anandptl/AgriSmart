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

function printPage(){
    window.print();
}

document.addEventListener("DOMContentLoaded", function(){

    document.getElementById("categoryFilter")
        .addEventListener("change", function(){

        let category = this.value;

        fetch("/crops-filter-list?category=" + encodeURIComponent(category))
            .then(res => res.text())
            .then(html => {
                document.getElementById("tableContainer").innerHTML = html;
            });

    });

});
