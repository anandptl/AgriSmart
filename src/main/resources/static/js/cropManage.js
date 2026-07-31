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


function switchTab(e, id) {
    document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
    document.querySelectorAll('.tab-box').forEach(b => b.classList.remove('active'));
    e.currentTarget.classList.add('active');
    document.getElementById(id).classList.add('active');
}

//unit add
    function addUnit(id, unit) {
        document.getElementById(id).addEventListener("blur", function () {
            if (this.value && !this.value.includes(unit)) {
                this.value = this.value.replace(unit, "").trim() + " " + unit;
            }
        });
    }

addUnit("temp", "°C");
addUnit("rain", "mm");

// fetch crop by the mane using ajex
function fetchCrop() {

    let cropName = document.getElementById("cropNameInput").value;

    fetch("/admin/crop/fetch?cropName=" + encodeURIComponent(cropName))
        .then(response => response.json())
        .then(data => {

            if (data.status === "error") {
                alert(data.message);
                return;
            }

            document.getElementById("updateForm").style.display = "block";

            document.getElementById("fetchButton").style.display = "none";

            document.getElementById("cropId").value = data.id;
            document.getElementById("minPrice").value = data.minPrice;
            document.getElementById("maxPrice").value = data.maxPrice;
            document.getElementById("imageName").innerText = data.cropImageName ? data.cropImageName : "No Image";

        })
        .catch(err => {
            alert("Something went wrong");
        });
}


// update crop ...
function updateCrop() {

    let id = document.getElementById("cropId").value;
    let min = parseFloat(document.getElementById("minPrice").value);
    let max = parseFloat(document.getElementById("maxPrice").value);

    if (min > max) {
        alert("Min price cannot be greater than Max price");
        return;
    }


    if (!id) {
        alert("Crop ID missing");
        return;
    }



    let formData = new FormData();
    formData.append("id", id);
    formData.append("minPrice", min);
    formData.append("maxPrice", max);

    let file = document.getElementById("imageFile").files[0];
    if (file) {
        formData.append("imageFile", file);
    }

    fetch("/admin/crop/update", {
        method: "POST",
        body: formData
    })
        .then(res => res.json())
        .then(data => {
            if (data.status === "success") {
                alert("Updated Successfully");
                //hide form..
                document.getElementById("updateForm").style.display = "none";

                // fetch button show again
                document.getElementById("fetchButton").style.display = "inline-block";

                // Clear crop name input
                document.getElementById("cropNameInput").value = "";
                document.getElementById("cropName").value = "";

            } else {
                alert(data.message);
            }
        })
        .catch(err => {
            alert("Update failed");
        });
}

// find crop for delete ...
function fetchDeleteCrop() {

    let cropName = document.getElementById("deleteCropName").value.trim();

    if (!cropName) {
        alert("Enter crop name");
        return;
    }

    fetch("/admin/crop/del-fetch?cropName=" + encodeURIComponent(cropName))
        .then(res => res.json())
        .then(data => {

            if (!data || data.status === "error") {
                alert("Crop not found");
                return;
            }

            // Save crop id
            document.getElementById("deleteCropId").value = data.deleteCropId;

            // Set confirmation text
            document.getElementById("confirmText").innerText =
                "Are you sure you want to delete " + cropName + "?";

            // Show confirm box
            document.getElementById("confirmBox").style.display = "block";

            // Hide fetch button
            document.getElementById("deleteFetchBtn").style.display = "none";
        })
        .catch(err => {
            alert("Something went wrong");
        });
}

// delete crop ....
function cancelDelete() {

    // Clear input
    document.getElementById("deleteCropName").value = "";

    // Hide confirm box
    document.getElementById("confirmBox").style.display = "none";

    // Show fetch button again
    document.getElementById("deleteFetchBtn").style.display = "inline-block";

    // Clear hidden id
    document.getElementById("deleteCropId").value = "";
}

// delete crop from database ...
function confirmDelete() {

    let id = document.getElementById("deleteCropId").value;
    console.log(id);

    if (!id) {
        alert("Crop ID missing");
        return;
    }

    fetch("/admin/crop/delete?id=" + id, {
        method: "DELETE"
    })
    .then(res => res.json())
    .then(data => {
        if (data.status === "success") {

            alert(data.message);

            document.getElementById("deleteCropName").value = "";
            document.getElementById("confirmBox").style.display = "none";
            document.getElementById("deleteFetchBtn").style.display = "inline-block";
            document.getElementById("deleteCropId").value = "";

        } else {
            alert(data.message);
        }
    })
    .catch(err => {
        alert("Delete failed");
    });
}
