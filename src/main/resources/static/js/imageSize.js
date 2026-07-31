
document.getElementById("profilePhoto").addEventListener("change", function() {
    const file = this.files[0];
    if (file) {
        const fileSizeInKB = file.size / 1024; // bytes → KB
        const fileSizeInMB = file.size / (1024 * 1024); // bytes → MB

        console.log("File size:", fileSizeInKB.toFixed(2), "KB");

        if (fileSizeInMB > 2) { // 2 MB limit
            alert("⚠️ Image size must be less than 2 MB!");
            this.value = ""; // clear file input
        }
    }
});
