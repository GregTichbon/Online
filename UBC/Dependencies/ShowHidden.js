var showhiddenlink = '<a id="showhidden" href="javascript:void(0)">Show hidden</a>'
$("body").prepend(showhiddenlink);

$("#showhidden").click(function () {
    $(".dependantdisplay:hidden").css("background-color", "blueviolet");;
    $(".dependantdisplay:hidden").show();
})