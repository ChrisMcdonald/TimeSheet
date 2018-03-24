function myFunction() {
    var x = document.getElementById('myDIV');
    x.classList.toggle("message-form");
}

$(document).on('turbolinks:load', function () {
    $('#button1').click(function () {
        $('messageForm').slideToggle();

    });
});


function myFunction() {
    var x = document.getElementById('NewInvoice');
    x.classList.toggle("new-invoice");
}

$(document).on('turbolinks:load', function () {
    $('#new-invoice').click(function () {
        $('.new-invoice').slideToggle();

    });
});
$(document).on('turbolinks:load',function () {
    $('li.shadow').hover(function () {
        $(this).toggleClass("background");
        // $(this).animate({height: "110"}, 50);
    }, function () {
        // $(this).animate({height: "100%"}, 50);
        $(this).toggleClass("background");

    });
});
$(document).on('turbolinks:load', function () {
    $('td.shadow').hover(function () {
        $(this).toggleClass("background");
        // $(this).animate({height: "110"}, 50);
    }, function () {
        // $(this).animate({height: "100%"}, 50);
        $(this).toggleClass("background");

    });
});
