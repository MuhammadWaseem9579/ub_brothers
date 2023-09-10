// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "./jquery_min.js";
import './jquery.min.js';
import './bootstrap.bundle.min.js';
import './jquery.easing.min.js';
import './sb-admin-2.min.js';
import './Chart.min.js';
import './chart-area-demo.js';
import './chart-pie-demo.js';
import './jquery.dataTables.min.js';
import './dataTables.bootstrap4.min.js';
import './datatables-demo.js';


$(document).ready(function() {
  $('a[data-confirm]').on('click', function(e) {
    var confirmationMessage = $(this).data('confirm');
    
    // Display the confirmation dialog with the specified message
    if (!confirm(confirmationMessage)) {
      e.preventDefault(); // Cancel the click event if the user does not confirm
    }
  });
});
