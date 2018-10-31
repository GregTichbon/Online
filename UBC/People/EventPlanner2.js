var event_id;
var changed = [];

$(document).ready(function () {

    //$('.remove').click(function () {
    $(document).on('click', '.remove', function () {
        id = 'del' + $(this).prev().attr("id").substring(11);
        //alert(id);
        changed.indexOf(id) === -1 ? changed.push(id) : null;
        $("#hf_changes").val(changed.toString());
        $(this).parent().remove();
    });

    $('.add').click(function () {
        event_id = $(this).parent().parent().attr('id');
        person_id = $('#hf_person_id').val();
        name = $('#hf_person_name').val();
        colour = $('#hf_person_colour').val();
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
            $('#' + event_id).append('<div class="wrapper"><div class="person" id="coach_' + event_id + '_' + person_id + '" style="background-color:' + colour + ';">' + name + '</div><span class="remove"></span></div>');
            id = 'add' + event_id.substring(5) + '_' + person_id;
            //alert(id);
            changed.indexOf(id) === -1 ? changed.push(id) : null;
            $("#hf_changes").val(changed.toString());
        }    });

    $('.title').mouseover(function () {

        //alert('mouseover')
    });

    $('.title').tooltip({
        content: function () {
            var element = $(this);
            return element.attr("title");
        }
    });

    $('.title').click(function () {
        alert('title clicked - open event')
    });


}); //document ready