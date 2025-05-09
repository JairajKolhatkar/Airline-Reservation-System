/**
 * SkyJet Airlines Admin Panel JavaScript
 */
document.addEventListener('DOMContentLoaded', function() {
    initDropdowns();
    initDataTables();
    initActionButtons();
    initStatistics();
});

/**
 * Initialize dropdown menus
 */
function initDropdowns() {
    const dropdowns = document.querySelectorAll('.dropdown');
    
    dropdowns.forEach(dropdown => {
        const toggle = dropdown.querySelector('.dropdown-toggle');
        const menu = dropdown.querySelector('.dropdown-menu');
        
        // Add click event for mobile devices
        if (toggle && menu) {
            toggle.addEventListener('click', (e) => {
                e.preventDefault();
                e.stopPropagation();
                
                const isVisible = menu.style.display === 'block';
                hideAllDropdowns();
                
                if (!isVisible) {
                    menu.style.display = 'block';
                }
            });
        }
    });
    
    // Close dropdowns when clicking outside
    document.addEventListener('click', () => {
        hideAllDropdowns();
    });
}

/**
 * Hide all dropdown menus
 */
function hideAllDropdowns() {
    const menus = document.querySelectorAll('.dropdown-menu');
    menus.forEach(menu => {
        menu.style.display = 'none';
    });
}

/**
 * Initialize DataTables if present
 */
function initDataTables() {
    const tables = document.querySelectorAll('.data-table');
    
    tables.forEach(table => {
        // Add sorting functionality
        const headers = table.querySelectorAll('thead th');
        
        headers.forEach((header, index) => {
            if (!header.classList.contains('no-sort')) {
                header.addEventListener('click', () => {
                    sortTable(table, index);
                });
                header.style.cursor = 'pointer';
                
                // Add sort indicator
                const indicator = document.createElement('span');
                indicator.className = 'sort-indicator';
                indicator.textContent = ' ↕';
                header.appendChild(indicator);
            }
        });
    });
}

/**
 * Sort table by column
 */
function sortTable(table, columnIndex) {
    const tbody = table.querySelector('tbody');
    const rows = Array.from(tbody.querySelectorAll('tr'));
    const headers = table.querySelectorAll('thead th');
    const header = headers[columnIndex];
    
    // Determine sort direction
    const currentDir = header.getAttribute('data-sort') || 'asc';
    const newDir = currentDir === 'asc' ? 'desc' : 'asc';
    
    // Reset all headers
    headers.forEach(h => {
        h.setAttribute('data-sort', '');
        h.querySelector('.sort-indicator').textContent = ' ↕';
    });
    
    // Set new sort direction
    header.setAttribute('data-sort', newDir);
    header.querySelector('.sort-indicator').textContent = newDir === 'asc' ? ' ↑' : ' ↓';
    
    // Sort rows
    rows.sort((rowA, rowB) => {
        const cellA = rowA.querySelectorAll('td')[columnIndex].textContent.trim();
        const cellB = rowB.querySelectorAll('td')[columnIndex].textContent.trim();
        
        if (!isNaN(parseFloat(cellA)) && !isNaN(parseFloat(cellB))) {
            // Numeric sort
            return newDir === 'asc' 
                ? parseFloat(cellA) - parseFloat(cellB)
                : parseFloat(cellB) - parseFloat(cellA);
        } else {
            // String sort
            return newDir === 'asc'
                ? cellA.localeCompare(cellB)
                : cellB.localeCompare(cellA);
        }
    });
    
    // Clear tbody
    while (tbody.firstChild) {
        tbody.removeChild(tbody.firstChild);
    }
    
    // Add sorted rows
    rows.forEach(row => {
        tbody.appendChild(row);
    });
}

/**
 * Initialize action buttons
 */
function initActionButtons() {
    // Delete confirmation
    const deleteButtons = document.querySelectorAll('.action-btn.delete');
    
    deleteButtons.forEach(button => {
        button.addEventListener('click', (e) => {
            if (!confirm('Are you sure you want to delete this item? This action cannot be undone.')) {
                e.preventDefault();
            }
        });
    });
    
    // Status change buttons
    const statusButtons = document.querySelectorAll('.status-change-btn');
    
    statusButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            
            const itemId = this.getAttribute('data-id');
            const newStatus = this.getAttribute('data-status');
            const itemType = this.getAttribute('data-type');
            
            if (confirm(`Are you sure you want to change the status to "${newStatus}"?`)) {
                updateStatus(itemId, newStatus, itemType);
            }
        });
    });
}

/**
 * Update item status via AJAX
 */
function updateStatus(id, status, type) {
    const xhr = new XMLHttpRequest();
    xhr.open('POST', contextPath + '/admin/status-update', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    
    xhr.onload = function() {
        if (xhr.status === 200) {
            const response = JSON.parse(xhr.responseText);
            
            if (response.success) {
                // Update UI
                const statusElement = document.querySelector(`#${type}-${id} .status-badge`);
                if (statusElement) {
                    // Remove all status classes
                    statusElement.className = 'status-badge';
                    // Add new status class
                    statusElement.classList.add(status.toLowerCase());
                    // Update text
                    statusElement.textContent = status;
                }
                
                showNotification('Status updated successfully', 'success');
            } else {
                showNotification(response.message || 'Error updating status', 'error');
            }
        } else {
            showNotification('Error updating status', 'error');
        }
    };
    
    xhr.onerror = function() {
        showNotification('Network error occurred', 'error');
    };
    
    xhr.send(`id=${id}&status=${status}&type=${type}`);
}

/**
 * Show notification message
 */
function showNotification(message, type) {
    const notification = document.createElement('div');
    notification.className = `notification ${type}`;
    notification.textContent = message;
    
    document.body.appendChild(notification);
    
    // Show notification
    setTimeout(() => {
        notification.classList.add('show');
    }, 10);
    
    // Remove after 3 seconds
    setTimeout(() => {
        notification.classList.remove('show');
        
        // Remove element after fade out
        notification.addEventListener('transitionend', function() {
            if (notification.parentNode) {
                notification.parentNode.removeChild(notification);
            }
        });
    }, 3000);
}

/**
 * Initialize statistics (charts, etc.)
 */
function initStatistics() {
    // If we have charts on the page and Chart.js is loaded
    if (typeof Chart !== 'undefined' && document.getElementById('bookingsChart')) {
        initBookingsChart();
    }
    
    if (typeof Chart !== 'undefined' && document.getElementById('flightsChart')) {
        initFlightsChart();
    }
}

/**
 * Initialize bookings chart
 */
function initBookingsChart() {
    const ctx = document.getElementById('bookingsChart').getContext('2d');
    
    // Sample data - replace with real data from backend
    const chart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            datasets: [{
                label: 'Bookings',
                data: [112, 98, 123, 145, 180, 210, 252, 265, 210, 187, 145, 132],
                backgroundColor: 'rgba(52, 152, 219, 0.2)',
                borderColor: 'rgba(52, 152, 219, 1)',
                borderWidth: 2,
                tension: 0.4
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
}

/**
 * Initialize flights chart
 */
function initFlightsChart() {
    const ctx = document.getElementById('flightsChart').getContext('2d');
    
    // Sample data - replace with real data from backend
    const chart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Economy', 'Business', 'First Class'],
            datasets: [{
                label: 'Seats Sold',
                data: [480, 120, 40],
                backgroundColor: [
                    'rgba(46, 204, 113, 0.7)',
                    'rgba(52, 152, 219, 0.7)',
                    'rgba(155, 89, 182, 0.7)'
                ],
                borderColor: [
                    'rgba(46, 204, 113, 1)',
                    'rgba(52, 152, 219, 1)',
                    'rgba(155, 89, 182, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
} 