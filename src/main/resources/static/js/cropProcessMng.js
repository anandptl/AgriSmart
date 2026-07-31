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
            currentUrl.includes("Crops-List") ) {

            document.getElementById("cropSubmenu").classList.add("show");

            document
                .querySelector("[onclick*='cropSubmenu'] .arrow")
                .classList.add("rotate");
        }

    });

function switchTab(evt, tabId) {

    // Remove active class from all tabs
    document.querySelectorAll(".tab").forEach(btn => {
        btn.classList.remove("active");
    });

    // Hide all tab content
    document.querySelectorAll(".tab-box").forEach(box => {
        box.classList.remove("active");
    });

    // Activate clicked tab
    evt.currentTarget.classList.add("active");

    // Show selected tab content
    document.getElementById(tabId).classList.add("active");
}


    let stageIndex = 1;

    function addStage() {
        const tableBody = document.getElementById("stageBody");

        const row = document.createElement("tr");

        row.innerHTML = `
            <td><input type="number" name="stages[${stageIndex}].stageOrder" required></td>
            <td><input type="text" name="stages[${stageIndex}].stageName" required></td>
            <td><input type="text" name="stages[${stageIndex}].dayRange" required></td>
            <td><input type="text" name="stages[${stageIndex}].description" required></td>
        `;

        tableBody.appendChild(row);
        stageIndex++;
    }