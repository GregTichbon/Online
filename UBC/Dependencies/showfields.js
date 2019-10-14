var fieldsdiv = $("<div>", { id: "fields" });
$("body").append(fieldsdiv);

var x = '';
$('input, textarea, select').each(function (index) {
    // x = x + '<br>' + '@pre' + this.id + '@post';
    if (this.id.substring(0, 2) != '__') {
        var $myLabel = $('label[for="' + this.name + '"]');
        x = x + '<br>' + $myLabel.html() + "=" + this.name;
    }

})
var fieldsdiv = '<div id="fields">' + x + '</div>';
$("body").append(fieldsdiv);
//$('#fields').html(x);