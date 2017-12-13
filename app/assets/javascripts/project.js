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
    var x = document.getElementById('NewProject');
    x.classList.toggle("new-project");
}

$(document).on('turbolinks:load', function () {
    $('#new-project').click(function () {
        $('NewProject').slideToggle();

    });
});
$(document).on('turbolinks:load',function () {
    $('li.shadow').hover(
        function () {

            $(this).closest('div').toggleClass("background");
        // $(this).animate({height: "110"}, 50);
    }, function () {
        // $(this).animate({height: "100%"}, 50);
        $(this).closest('div').toggleClass("background");

    });
});
$(document).on('click', 'li', function () {
    Turbolinks.visit($(this).find("a").attr("href"));
});

$(document).on('turbolinks:load',function () {
    $("#menu-toggle").click(function (e) {
        e.preventDefault();
        var x = document.getElementById('menuhides');
        var body = document.getElementById("bodysize");

        if (x.style.visibility === '' || x.style.visibility === 'hidden') {
            x.style.visibility = 'visible';
            body.classList.add('col-md-10');

        } else {
            x.style.visibility = 'hidden';
            body.classList.remove('col-md-10');
        }
    });
});
$(document).on('turbolinks:load', function () {
    $('.ana').fadeOut(1200);

    $('#user-details').click(function () {

        $('user_partial .show-users-controler').html("<%= j render 'user_details' %>")

    });
});

jQuery.fn.flash = function (color, duration) {
    var current = this.css('backgroundColor');
    this.animate({backgroundColor: 'rgb(' + color + ')'}, duration / 2)
        .animate({backgroundColor: current}, duration / 2);
};