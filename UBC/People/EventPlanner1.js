var event_id;
var changed = [];

$(document).ready(function () {

    //$('.remove').click(function () {
    $(document).on('click', '.remove', function () {
        event_person = $(this).prev().attr("id").substring(12);
        event_person_split = event_person.split('_');

        update_person_event(event_person_split[1], event_person_split[0], "Not Going");

        /*
        id = 'del' + $(this).prev().attr("id").substring(11);
        changed.indexOf(id) === -1 ? changed.push(id) : null;
        $("#hf_changes").val(changed.toString());
        $(this).parent().remove();
        */
    });

    $('.add').click(function () {
        event_id = $(this).parent().parent().attr('id');
        $("#div_coaches").dialog({
            resizable: false,
            modal: true,
            buttons: {
                "Done": function () {
                    $(this).dialog("close");
                }
            }
        });

        //alert('add')
    });
    $('.title').mouseover(function () {

        //alert('mouseover')
    });

    $('.title').tooltip({
        content: function () {
            var element = $(this);
            return element.attr("title");
        }
    });

    $('.addevent').click(function () {
        date = $(this).prev().text();
        var usewidth = $(window).width() * .9;
        if (usewidth > 810) {
            usewidth = 810;
        }
        var useheight = $(window).height() * .9;

        // width: usewidth,
        //height: useheight,
        
        $("#div_event").dialog({
            width: usewidth,
            height: useheight,
            resizable: false,
            modal: true,
            buttons: {
                "Cancel": function () {
                    $(this).dialog("close");
                }
            }
        }).html('<iframe src="eventdialog.aspx?id=new&date=' + date + '" frameborder="0" width="100%" height="100%" allowfullscreen></iframe>')
    });

    $('.title').click(function () {
        event_id = $(this).parent().parent().attr('id').substring(6);
        var usewidth = $(window).width() * .9;
        if (usewidth > 810) {
            usewidth = 810;
        }
        var useheight = $(window).height() * .9;

        // width: usewidth,
        //height: useheight,

        $("#div_event").dialog({
            width: usewidth,
            height: useheight,
            resizable: false,
            modal: true,
            buttons: {
                "Cancel": function () {
                    $(this).dialog("close");
                }
            }
        }).html('<iframe src="eventdialog.aspx?id=' + event_id + '" frameborder="0" width="100%" height="100%" allowfullscreen></iframe>')
    });

    $('.coach').click(function () {
        person_id = $(this).attr('id').substring(6);
        selectorid = 'coach_' + event_id + '_';
        selector = '[id^=' + selectorid + ']';
        alreadyused = false;
        $(selector).each(function () {
            thisid = $(this).attr('id').substring(selectorid.length);
            if (person_id == thisid) {
                alreadyused = true;
            }
        })

        if (!alreadyused) {
            name = $(this).text();
            colour = $(this).css("backgroundColor");
            $('#' + event_id).append('<div class="wrapper"><div class="person" id="coach_' + event_id + '_' + person_id + '" style="background-color:' + colour + ';">' + name + '</div><span class="remove"></span></div>');

            update_person_event(person_id, event_id.substring(6), "Going");
            /*
            id = 'add' + event_id.substring(5) + '_' + person_id;
            //alert(id);
            changed.indexOf(id) === -1 ? changed.push(id) : null;
            $("#hf_changes").val(changed.toString());
            */
        }
    });

}); //document ready

function update_person_event(person_id, event_id, attendance) {
    var arForm = [{ "name": "person_id", "value": person_id }, { "name": "event_id", "value": event_id }, { "name": "attendance", "value": attendance }, { "name": "role", "value": "Coach" }];

    var formData = JSON.stringify({ formVars: arForm });
    //alert(formData);

 

    $.ajax({
        type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
        contentType: "application/json; charset=utf-8",
        url: 'posts.asmx/update_event_person', // the url where we want to POST
        data: formData,
        dataType: 'json', // what type of data do we expect back from the server
        //success: function (result) {
        //    window.location.href = 'default.aspx';
        //},
        error: function (xhr, status) {
            alert("An error occurred: " + status);
        }
    });
   
}