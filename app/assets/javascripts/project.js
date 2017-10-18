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
$(document).on('turbolinks:load',function () {

    var screen = window.screen.availWidth;
    if (screen < 767) {
        var element = document.getElementById("menuhides");
        if (element.classList.contains('menu-large-hide')){

        }else{
            element.classList.toggle("menu-hide-large");

        }


    }
});

$(document).on('turbolinks:load',function () {

    $('li').click(function(){
        Turbolinks.visit($(this).find("a").attr("href"))

    });
});
