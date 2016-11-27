$("form :input").each(function () {
    var input = $(this); // This is the jquery object of the input, do what you will
    $('#output').append(input.attr('id') + '|' + input.attr('title') + '|' + input.attr('maxlength') + "<br />");
});