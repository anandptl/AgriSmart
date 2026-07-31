// PIE
const pieLabels = window.categoryData.map(d => d.label);
const pieData = window.categoryData.map(d => d.value);

new Chart(document.getElementById("pieChart"), {
    type: 'pie',
    data: {
        labels: pieLabels,
        datasets: [{
            data: pieData,
            backgroundColor: ['#2ecc71','#f39c12','#3498db','#9b59b6','#e74c3c']
        }]
    }
});


// BAR
const barLabels = window.farmerCategoryData.map(d => d.label);
const barData = window.farmerCategoryData.map(d => d.value);

new Chart(document.getElementById("barChart"), {
    type: 'bar',
    data: {
        labels: barLabels,
        datasets: [{
            label: 'Farmers',
            data: barData,
            backgroundColor: '#38a169'
        }]
    },
    options:{
        scales:{ y:{ beginAtZero:true } }
    }
});


// LINE
new Chart(document.getElementById("lineChart"), {
    type: 'line',
    data: {
        labels:['Jan','Feb','Mar','Apr','May','Jun'],
        datasets:[{
            label:'Growth',
            data:[20,30,25,40,35,50],
            borderColor:'#38a169',
            fill:true
        }]
    }
});


// DOUGHNUT
new Chart(document.getElementById("doughnutChart"), {
    type: 'doughnut',
    data: {
        labels:['Rain','Sunlight','Humidity'],
        datasets:[{
            data:[40,35,25],
            backgroundColor:['#3498db','#f1c40f','#9b59b6']
        }]
    }
});