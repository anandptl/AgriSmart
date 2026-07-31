document.addEventListener("DOMContentLoaded", function () {

    loadCrops();

    document.querySelectorAll(".filter-section select")
        .forEach(select => select.addEventListener("change", loadCrops));

    document.querySelector(".clear-filters-btn")
        .addEventListener("click", clearFilters);
});

function loadCrops() {

    const soilType = document.getElementById("soilType")?.value || "";
    const category = document.getElementById("category")?.value || "";
    const season = document.getElementById("season")?.value || "";
    const waterNeed = document.getElementById("water-need")?.value || "";
    const climate = document.getElementById("climate")?.value || "";

    const params = new URLSearchParams();

    if (soilType) params.append("soilType", soilType);
    if (category) params.append("category", category);
    if (season) params.append("season", season);
    if (waterNeed) params.append("waterNeed", waterNeed);
    if (climate) params.append("climate", climate);

    fetch(`/crop-Sugges/filter?${params.toString()}`)
        .then(response => response.text())   // 🔥 TEXT not JSON
        .then(html => {
            document.getElementById("cropResults").innerHTML = html;
        })
        .catch(error => console.error("Error:", error));
}

function clearFilters() {
    document.querySelectorAll(".filter-section select")
        .forEach(select => select.selectedIndex = 0);

    loadCrops();
}
