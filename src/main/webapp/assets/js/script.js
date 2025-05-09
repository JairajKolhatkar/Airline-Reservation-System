// Wait for DOM to be fully loaded
document.addEventListener('DOMContentLoaded', function() {
    // Mobile menu toggle
    const mobileMenuToggle = document.querySelector('.mobile-menu-toggle');
    const mainNav = document.querySelector('.main-nav');
    
    if (mobileMenuToggle && mainNav) {
        mobileMenuToggle.addEventListener('click', function() {
            mainNav.classList.toggle('active');
            mobileMenuToggle.classList.toggle('active');
        });
    }
    
    // Close alert messages
    const closeAlertButtons = document.querySelectorAll('.close-alert');
    
    closeAlertButtons.forEach(function(button) {
        button.addEventListener('click', function() {
            const alert = button.parentElement;
            alert.style.display = 'none';
        });
    });
    
    // Seat selection functionality for booking
    const seatSelectionContainer = document.getElementById('seat-selection');
    
    if (seatSelectionContainer) {
        // Generate seat map
        generateSeatMap();
        
        // Add event listeners to seats
        const seats = document.querySelectorAll('.seat');
        
        seats.forEach(function(seat) {
            seat.addEventListener('click', function() {
                if (!this.classList.contains('occupied')) {
                    this.classList.toggle('selected');
                    updateSelectedSeats();
                }
            });
        });
    }
    
    // Price calculation for booking
    const classSelect = document.getElementById('class_id');
    const passengersInput = document.getElementById('passengers_count');
    const totalPriceElement = document.getElementById('total_price');
    const basePriceElement = document.getElementById('base_price');
    
    if (classSelect && passengersInput && totalPriceElement && basePriceElement) {
        const calculateTotal = function() {
            const basePrice = parseFloat(basePriceElement.dataset.price) || 0;
            const passengers = parseInt(passengersInput.value) || 1;
            const total = basePrice * passengers;
            
            totalPriceElement.textContent = total.toFixed(2);
        };
        
        classSelect.addEventListener('change', function() {
            const selectedOption = this.options[this.selectedIndex];
            basePriceElement.textContent = selectedOption.dataset.price;
            basePriceElement.dataset.price = selectedOption.dataset.price;
            calculateTotal();
        });
        
        passengersInput.addEventListener('change', calculateTotal);
        passengersInput.addEventListener('input', calculateTotal);
        
        // Initial calculation
        calculateTotal();
    }
    
    // Flight search form validation
    const searchForm = document.getElementById('flight-search-form');
    
    if (searchForm) {
        searchForm.addEventListener('submit', function(event) {
            const origin = document.getElementById('origin').value;
            const destination = document.getElementById('destination').value;
            const departureDate = document.getElementById('departure_date').value;
            
            if (!origin || !destination || !departureDate) {
                event.preventDefault();
                alert('Please fill all required fields');
                return false;
            }
            
            if (origin === destination) {
                event.preventDefault();
                alert('Origin and destination cannot be the same');
                return false;
            }
            
            const today = new Date();
            today.setHours(0, 0, 0, 0);
            const selectedDate = new Date(departureDate);
            
            if (selectedDate < today) {
                event.preventDefault();
                alert('Departure date cannot be in the past');
                return false;
            }
            
            return true;
        });
    }
    
    // Add passenger fields dynamically
    const addPassengerBtn = document.getElementById('add_passenger');
    const passengersContainer = document.getElementById('passengers_container');
    
    if (addPassengerBtn && passengersContainer) {
        addPassengerBtn.addEventListener('click', function() {
            const passengerCount = document.querySelectorAll('.passenger-details').length + 1;
            
            if (passengerCount > 10) {
                alert('Maximum 10 passengers allowed per booking');
                return;
            }
            
            const passengerHtml = `
                <div class="passenger-details" data-passenger="${passengerCount}">
                    <h4>Passenger ${passengerCount}</h4>
                    <div class="form-row">
                        <div class="form-group half">
                            <label for="first_name_${passengerCount}">First Name</label>
                            <input type="text" id="first_name_${passengerCount}" name="first_name_${passengerCount}" required>
                        </div>
                        <div class="form-group half">
                            <label for="last_name_${passengerCount}">Last Name</label>
                            <input type="text" id="last_name_${passengerCount}" name="last_name_${passengerCount}" required>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group half">
                            <label for="gender_${passengerCount}">Gender</label>
                            <select id="gender_${passengerCount}" name="gender_${passengerCount}" required>
                                <option value="">Select</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        <div class="form-group half">
                            <label for="age_${passengerCount}">Age</label>
                            <input type="number" id="age_${passengerCount}" name="age_${passengerCount}" min="0" max="120" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="seat_${passengerCount}">Seat Number</label>
                        <input type="text" id="seat_${passengerCount}" name="seat_${passengerCount}" placeholder="Select from seat map" readonly>
                    </div>
                </div>
            `;
            
            passengersContainer.insertAdjacentHTML('beforeend', passengerHtml);
            
            // Update total passengers count
            document.getElementById('passengers_count').value = passengerCount;
            
            // Trigger price calculation
            const event = new Event('change');
            document.getElementById('passengers_count').dispatchEvent(event);
        });
    }
    
    // Remove passenger
    const removePassengerBtn = document.getElementById('remove_passenger');
    
    if (removePassengerBtn && passengersContainer) {
        removePassengerBtn.addEventListener('click', function() {
            const passengerDetails = document.querySelectorAll('.passenger-details');
            
            if (passengerDetails.length > 1) {
                passengersContainer.removeChild(passengerDetails[passengerDetails.length - 1]);
                
                // Update total passengers count
                document.getElementById('passengers_count').value = passengerDetails.length - 1;
                
                // Trigger price calculation
                const event = new Event('change');
                document.getElementById('passengers_count').dispatchEvent(event);
            }
        });
    }
});

// Function to generate a seat map (for booking page)
function generateSeatMap() {
    const seatSelectionContainer = document.getElementById('seat-selection');
    
    if (!seatSelectionContainer) return;
    
    // Get available seats
    const availableSeatsElement = document.getElementById('available_seats');
    const availableSeats = availableSeatsElement ? parseInt(availableSeatsElement.value) : 0;
    
    // Create rows of seats
    const rows = Math.ceil(availableSeats / 6); // 6 seats per row (3+3)
    
    let seatMap = '<div class="seat-map">';
    seatMap += '<div class="airplane-front"></div>';
    
    for (let i = 0; i < rows; i++) {
        const rowLetter = String.fromCharCode(65 + i); // A, B, C, ...
        
        seatMap += `<div class="seat-row" data-row="${rowLetter}">`;
        seatMap += `<div class="row-label">${rowLetter}</div>`;
        
        // Left side (seats 1-3)
        seatMap += '<div class="seat-group left">';
        for (let j = 1; j <= 3; j++) {
            const seatNumber = `${rowLetter}${j}`;
            if ((i * 6) + j <= availableSeats) {
                seatMap += `<div class="seat" data-seat="${seatNumber}">${j}</div>`;
            } else {
                seatMap += '<div class="seat unavailable"></div>';
            }
        }
        seatMap += '</div>';
        
        // Aisle
        seatMap += '<div class="aisle"></div>';
        
        // Right side (seats 4-6)
        seatMap += '<div class="seat-group right">';
        for (let j = 4; j <= 6; j++) {
            const seatNumber = `${rowLetter}${j}`;
            if ((i * 6) + j <= availableSeats) {
                seatMap += `<div class="seat" data-seat="${seatNumber}">${j}</div>`;
            } else {
                seatMap += '<div class="seat unavailable"></div>';
            }
        }
        seatMap += '</div>';
        
        seatMap += '</div>'; // Close seat-row
    }
    
    seatMap += '</div>'; // Close seat-map
    
    seatSelectionContainer.innerHTML = seatMap;
}

// Update selected seats
function updateSelectedSeats() {
    const selectedSeats = document.querySelectorAll('.seat.selected');
    const passengerInputs = document.querySelectorAll('input[name^="seat_"]');
    
    // Reset all passenger seat inputs
    passengerInputs.forEach(function(input) {
        input.value = '';
    });
    
    // Assign selected seats to passengers in order
    for (let i = 0; i < Math.min(selectedSeats.length, passengerInputs.length); i++) {
        passengerInputs[i].value = selectedSeats[i].dataset.seat;
    }
} 