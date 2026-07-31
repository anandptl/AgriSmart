// Dropdown Select
            document.getElementById("cropSelect")
            .addEventListener("change", function(){

                if(!this.value) return;

                fetch("/process/details?cropId=" + this.value)
                    .then(res => res.text())
                    .then(html => {
                        document.getElementById("processContainer")
                                .innerHTML = html;
                    });
            });

            // Search
            function searchCrop(){

                let name =
                    document.getElementById("cropSearch").value;

                if(!name) return;

                fetch("/process/search?cropName=" +
                       encodeURIComponent(name))
                    .then(res => res.text())
                    .then(html => {
                        document.getElementById("processContainer")
                                .innerHTML = html;
                    });
            }