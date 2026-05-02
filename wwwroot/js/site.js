

// Auto-dismiss success alerts after 4 seconds
document.addEventListener('DOMContentLoaded', function () {

    // Auto-dismiss alerts
    document.querySelectorAll('.alert-success').forEach(function (el) {
        setTimeout(function () {
            var bsAlert = new bootstrap.Alert(el);
            bsAlert.close();
        }, 4000);
    });

    // Confirm delete forms — double-check before submit
    document.querySelectorAll('form[asp-action="Delete"], form[action$="/Delete"]')
        .forEach(function (form) {
            form.addEventListener('submit', function (e) {
                if (!confirm('Are you sure? This action cannot be undone.')) {
                    e.preventDefault();
                }
            });
        });

    // Highlight the active nav link based on current path
    var path = window.location.pathname.split('/')[1].toLowerCase();
    document.querySelectorAll('.nav-link').forEach(function (link) {
        var href = link.getAttribute('href');
        if (href && href.toLowerCase().includes(path) && path !== '') {
            link.classList.add('active');
        }
    });
});
