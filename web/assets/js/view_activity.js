document.addEventListener('DOMContentLoaded', function() {
    // Calculate totals for each row on initial load
    calculateRowTotals();

    var countCells = document.querySelectorAll('.count');
    for (var i = 0; i < countCells.length; i++) {
        countCells[i].setAttribute('contenteditable', 'true');
        
        countCells[i].addEventListener('blur', function() {
            calculateRowTotals();
        });

        countCells[i].addEventListener('mouseover', function() {
            this.style.backgroundColor = '#ecf0f1';
            this.style.cursor = 'pointer';
        });

        countCells[i].addEventListener('mouseout', function() {
            this.style.backgroundColor = '';
        });
    }
});

// Function to calculate totals for each row
function calculateRowTotals() {
    var rows = document.querySelectorAll('#projectTable tbody tr');
    
    for (var i = 0; i < rows.length; i++) {
        var row = rows[i];
        var approved = parseInt(row.cells[2].textContent, 10);
        var pending = parseInt(row.cells[3].textContent, 10);
        var rejected = parseInt(row.cells[4].textContent, 10);

        if (isNaN(approved)) approved = 0;
        if (isNaN(pending)) pending = 0;
        if (isNaN(rejected)) rejected = 0;

        var total = approved + pending + rejected;
        row.cells[5].textContent = total;
    }
}