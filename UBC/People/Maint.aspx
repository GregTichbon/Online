<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Maint.aspx.cs" Inherits="UBC.People.Maint" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap-datetimepicker.min.css")%>" rel="stylesheet" />
    <link href="<%: ResolveUrl("~/Dependencies/UBC.css")%>" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropper/4.0.0/cropper.min.css" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="<%: ResolveUrl("~/Dependencies/UBC.js")%>"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cropper/4.0.0/cropper.min.js"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/jquery.validate.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/additional-methods.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/moment.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/bootstrap-datetimepicker.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/jscolor.js")%>"></script>

    <!--additional-methods.min.js-->

    <style>
         .imagecontainer {
            max-width: 800px;
            max-height: 800px;
            margin: 20px auto;
        }

        #preview {
            overflow: hidden;
            width: 200px;
            height: 200px;
        }

        img {
            max-width: 100%;
        }

        #canvas {
            background-color: #ffffff;
            cursor: default;
            border: 1px solid black;
            width: 1200px;
        }

        .notcurrentcategory {
            background-color: grey;
        }

    </style>

    <script type="text/javascript">



        var tr;
        var mode;
        var newctr = 0;

        $(document).ready(function () {
            $(document).uitooltip({
                position: {
                    my: "right center",
                    at: "left center"
                }
            });

            var canvas = $("#canvas"),
                context = canvas.get(0).getContext("2d")//,
            //$result = $('#result');

            $(".nav-tabs a").click(function () {
                $(this).tab('show');
            });
            $('.nav-tabs a').on('shown.bs.tab', function (event) {
                var x = $(event.target).text();         // active tab
                var y = $(event.relatedTarget).text();  // previous tab
                $(".act span").text(x);
                $(".prev span").text(y);
            });

            $.validator.addMethod("DateisAfter", function (value, element, params) {
                console.log(value);
                console.log(element);
                console.log($(params[0]).val());

                otherdate = $(params[0]).val();
                returnval = true;
                if (value != "") {
                    if (moment(value) <= moment(otherdate)) {
                        returnval = false;
                    }
                }
                return returnval;
            }, 'This date must be after the date noted');

            $("#form1").validate({
                rules: {
                    tb_birthdate: {
                        pattern: /(([0-9])|([0-2][0-9])|([3][0-1])) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d{4}/
                    }
                },
                messages: {
                    tb_birthdate: {
                        pattern: "Must be in the format of day month year, eg: 23 Jun 1985"
                    }
                }
            });
            $("#form2").validate();
            $("#form3").validate({
                rules: {
                    tb_notes_followup: {
                        required: function () {
                            return $('#dd_notes_followupactioned').val() != '';
                        },
                        date: true,
                        //DateisAfter: ["#tb_eventfrom", "#tb_eventto"]
                        DateisAfter: ['#tb_notes_datetime']
                    }
                }
            })

            $('.submit').click(function () {
                delim = String.fromCharCode(254);


               /*----------------------------------------------TRANSACTIONS-----------------------------------------*/
               $('#transactionstable > tbody > tr[maint="changed"]').each(function () {
                    tr_id = $(this).attr('id');
                    tr_date = $(this).find('td:eq(1)').text();
                    tr_system = $(this).find('td:eq(2)').text();
                    tr_code = $(this).find('td:eq(3)').text();
                    tr_event_id = $(this).find('td:eq(4)').attr('event_id');
                    tr_amount = $(this).find('td:eq(5)').text();
                    tr_note = $(this).find('td:eq(6)').text();
                    //tr_banked = $(this).find('td:eq(7)').text();

                    value = tr_date + delim + tr_system + delim + tr_code + delim + tr_event_id + delim + tr_amount + delim + tr_note; // + delim + tr_banked
                    $('<input>').attr({
                        type: 'hidden',
                        name: tr_id,
                        value: value
                    }).appendTo('#form1');
                });

                /*----------------------------------------------CATEGORY-----------------------------------------*/
                $('#categorytable > tbody > tr[maint="changed"]').each(function () {
                    tr_id = $(this).attr('id');
                    tr_category = $(this).find('td:eq(1)').attr('category_id');
                    tr_startdate = $(this).find('td:eq(2)').text();
                    tr_enddate = $(this).find('td:eq(3)').text();
                    tr_note = $(this).find('td:eq(4)').text();
                   
                    value = tr_category + delim + tr_startdate + delim + tr_enddate + delim + tr_note;
                    $('<input>').attr({
                        type: 'hidden',
                        name: tr_id,
                        value: value
                    }).appendTo('#form1');
                });
                $('#categorytable > tbody > tr[maint="deleted"]').each(function () {
                    //don't do if new
                    tr_id = $(this).attr('id') + '_delete';
                    if (tr_id.substring(0, 3) != 'new') {
                        $('<input>').attr({
                            type: 'hidden',
                            name: tr_id,
                            value: ""
                        }).appendTo('#form1');
                    }
                });

                /*----------------------------------------------PHONE-----------------------------------------*/
                $('#phonetable > tbody > tr[maint="changed"]').each(function () {
                    tr_id = $(this).attr('id');
                    tr_phone = $(this).find('td:eq(1)').text();
                    tr_mobile = $(this).find('td:eq(2)').text();
                    tr_note = $(this).find('td:eq(3)').text();
                    tr_text = $(this).find('td:eq(4)').text();

                    value = tr_phone + delim + tr_mobile + delim + tr_note + delim + tr_text;
                    $('<input>').attr({
                        type: 'hidden',
                        name: tr_id,
                        value: value
                    }).appendTo('#form1');
                });
                $('#phonetable > tbody > tr[maint="deleted"]').each(function () {
                    //don't do if new
                    tr_id = $(this).attr('id') + '_delete';
                    if (tr_id.substring(0, 3) != 'new') {
                        $('<input>').attr({
                            type: 'hidden',
                            name: tr_id,
                            value: ""
                        }).appendTo('#form1'); 
                    }
                });
                 /*----------------------------------------------NOTE-----------------------------------------*/
                $('#notetable > tbody > tr[maint="changed"]').each(function () {
                    tr_id = $(this).attr('id');
                    tr_datetime = $(this).find('td:eq(1)').text();
                    tr_note = $(this).find('td:eq(3)').text();
                    tr_followup = $(this).find('td:eq(4)').text();
                    tr_followupactioned = $(this).find('td:eq(5)').text();

                    value = tr_datetime + delim + tr_note + delim + tr_followup + delim + tr_followupactioned;
                    $('<input>').attr({
                        type: 'hidden',
                        name: tr_id,
                        value: value
                    }).appendTo('#form1');
                });
                $('#notetable > tbody > tr[maint="deleted"]').each(function () {
                    //don't do if new
                    tr_id = $(this).attr('id') + '_delete';
                    if (tr_id.substring(0, 3) != 'new') {
                        $('<input>').attr({
                            type: 'hidden',
                            name: tr_id,
                            value: ""
                        }).appendTo('#form1'); 
                    }
                });

               /*----------------------------------------------EMAIL-----------------------------------------*/
               $('#emailtable > tbody > tr[maint="changed"]').each(function () {
                    tr_id = $(this).attr('id');
                    tr_emailaddress = $(this).find('td:eq(1)').text();
                    tr_note = $(this).find('td:eq(2)').text();

                    value = tr_emailaddress + delim + tr_note;
                    $('<input>').attr({
                        type: 'hidden',
                        name: tr_id,
                        value: value
                    }).appendTo('#form1');

                });
                $('#emailtable > tbody > tr[maint="deleted"]').each(function () {
                    tr_id = $(this).attr('id') + '_delete';
                    if (tr_id.substring(0, 3) != 'new') {
                        $('<input>').attr({
                            type: 'hidden',
                            name: tr_id,
                            value: ""
                        }).appendTo('#form1');
                    }

                });

                /*----------------------------------------------RELATIONSHIP-----------------------------------------*/
                $('#relationshiptable > tbody > tr[maint="changed"]').each(function () {
                    tr_id = $(this).attr('id');
                    tr_relationshiptype_id = $(this).find('td:eq(1)').attr('relationshiptype_id');
                    tr_person_id = $(this).find('td:eq(2)').attr('relationshipperson_id');
                    tr_note = $(this).find('td:eq(3)').text();
                   
                    value = tr_relationshiptype_id + delim + tr_person_id + delim + tr_note;
                    $('<input>').attr({
                        type: 'hidden',
                        name: tr_id,
                        value: value
                    }).appendTo('#form1');
                });
                $('#relationshiptable > tbody > tr[maint="deleted"]').each(function () {
                    //don't do if new
                    tr_id = $(this).attr('id') + '_delete';
                    if (tr_id.substring(0, 3) != 'new') {
                        $('<input>').attr({
                            type: 'hidden',
                            name: tr_id,
                            value: ""
                        }).appendTo('#form1');
                    }
                });
            });  //.submit end
            



            $('#menu').click(function () {
                window.location.href = '../default.aspx';
            })
            $('#search').click(function () {
                window.location.href = 'search.aspx';
            })

            $('.registrationview').click(function () {
                id = $(this).attr('id');
                idparts = id.split("_");
                if (idparts[2] == '2017/18' || idparts[2] == '2018/19') {
                    window.open("RegisterDisplay.aspx?id=" + idparts[1], 'Register');
                } else {
                    window.open("RegistrationDisplay.aspx?id=" + idparts[1], 'Register');
                }
            });

             $('.registrationedit').click(function () {
                id = $(this).attr('id');
                idparts = id.split("_");
                alert('To do: Update Status information: ie: Have updated the main record from this registration - Person can be logged in user');
            });           

            $('.standarddate').datetimepicker({
                format: 'D MMM YYYY',
                extraFormats: ['D MMM YY', 'D MMM YYYY', 'DD/MM/YY', 'DD/MM/YYYY', 'DD.MM.YY', 'DD.MM.YYYY', 'DD MM YY', 'DD MM YYYY'],
                //daysOfWeekDisabled: [0, 6],
                showClear: true,
                viewDate: false,
                useCurrent: true
                //,maxDate: moment().add(-1, 'year')
            });

            $('.datetime').datetimepicker({
                format: 'D MMM YYYY hh:mm',
                extraFormats: ['D MMM YY', 'D MMM YYYY', 'DD/MM/YY', 'DD/MM/YYYY', 'DD.MM.YY', 'DD.MM.YYYY', 'DD MM YY', 'DD MM YYYY'],
                //daysOfWeekDisabled: [0, 6],
                showClear: true,
                viewDate: false,
                useCurrent: true
                //,maxDate: moment().add(-1, 'year')
            });

            $('#div_birthdate').datetimepicker({
                format: 'D MMM YYYY',
                extraFormats: ['D MMM YY', 'D MMM YYYY', 'DD/MM/YY', 'DD/MM/YYYY', 'DD.MM.YY', 'DD.MM.YYYY', 'DD MM YY', 'DD MM YYYY'],
                //daysOfWeekDisabled: [0, 6],
                showClear: true,
                viewDate: false,
                useCurrent: false,
                sideBySide: true,
                viewMode: 'years'
                //,maxDate: moment().add(-1, 'year')
            });

            $("#div_birthdate").on("dp.change", function (e) {
                calculateage(e.date);
            });

            var e = moment($("#div_birthdate").find("input").val());
            calculateage(e);

            $(".numeric").keydown(function (event) {
                if (event.shiftKey == true) {
                    event.preventDefault();
                }

                if ((event.keyCode >= 48 && event.keyCode <= 57) ||
                    (event.keyCode >= 96 && event.keyCode <= 105) ||
                    event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 ||
                    event.keyCode == 39 || event.keyCode == 46 || (event.keyCode == 190 && 1 == 2)) {
                } else {
                    event.preventDefault();
                }

                if ($(this).val().indexOf('.') !== -1 && event.keyCode == 190)
                    event.preventDefault();
                //if a decimal has been added, disable the "."-button

            });

            /* ========================================= TRANSACTIONS ===========================================*/
            $(document).on('click', '.transactionsedit', function () {
                mode = $(this).data('mode');
                if (mode == "add") {
                    $("#dialog-transactions").find(':input').val('');
                } else {
                    tr = $(this).closest('tr');
                    $('#tb_transactions_date').val($(tr).find('td').eq(1).text());
                    $('#dd_transactions_system').val($(tr).find('td').eq(2).text());
                    $('#dd_transactions_code').val($(tr).find('td').eq(3).text());
                    $('#dd_transactions_event').val($(tr).find('td').eq(4).attr('event_id'));
                    $('#tb_transactions_amount').val($(tr).find('td').eq(5).text());
                    $('#tb_transactions_note').val($(tr).find('td').eq(6).text());
                    //$('#tb_transactions_banked').val($(tr).find('td').eq(7).text());
                }

                mywidth = $(window).width() * .95;
                if (mywidth > 800) {
                    mywidth = 800;
                }

                $("#dialog-transactions").dialog({
                    resizable: false,
                    height: 600,
                    width: mywidth,
                    modal: true 
                    /*
                    ,open: function (type, data) {
                        $(this).appendTo($('form')); // reinsert the dialog to the form       
                    }*/
                    ,appendTo: "#form2"  
                });

                var myButtons = {
                    "Cancel": function () {
                        $(this).dialog("close");
                    },
                    "Save": function () {
                        if ($("#form2").valid()) {
                            if (mode == "add") {
                                tr = $('#div_transactions > table > tbody tr:first').clone();
                                $(tr).removeAttr('style');
                                $('#div_transactions > table > tbody > tr:last').before(tr);
                                $(tr).attr('id', 'transactions_new_' + get_newctr());
                                $(tr).find('td:first').attr("class", "inserted");
                            } else {
                                $(tr).find('td:first').attr("class", "changed");

                            }
                            $(tr).attr('maint', 'changed');
                            $(tr).find('td').eq(1).text($('#tb_transactions_date').val());
                            $(tr).find('td').eq(2).text($('#dd_transactions_system').val());
                            $(tr).find('td').eq(3).text($('#dd_transactions_code').val());
                            $(tr).find('td').eq(4).text($('#dd_transactions_event option:selected').text());
                            $(tr).find('td').eq(4).attr('event_id', $('#dd_transactions_event').val());
                            $(tr).find('td').eq(5).text(formatcurrency($('#tb_transactions_amount').val()));
                            $(tr).find('td').eq(6).text($('#tb_transactions_note').val());
                            totaltransactions();
                            //$(tr).find('td').eq(7).text($('#tb_transactions_banked').val());
                            //alert("Database will be updated when record submited");
                            $(this).dialog("close");
                        }
                    }
                }


                if (mode != 'add') {
                    myButtons["Delete"] = function () {
                        if (window.confirm("Are you sure you want to delete this transaction?")) {
                            $(tr).find('td:first').attr("class", "deleted");
                            $(tr).attr('maint', 'deleted');
                            //$(tr).remove
                            totaltransactions();
                            alert('To do: Delete in database');
                            $(this).dialog("close");
                        }
                    }
                }


                $("#dialog-transactions").dialog('option', 'buttons', myButtons);
            })

             /* ========================================= CATEGORY ===========================================*/

            $(document).on('click', '.categoryedit', function () {
                mode = $(this).data('mode');
                if (mode == "add") {
                    $("#dialog-category").find(':input').val('');
                } else {
                    tr = $(this).closest('tr');
                    $('#dd_category_category').val($(tr).find('td').eq(1).attr('category_id'));
                    $('#tb_category_startdate').val($(tr).find('td').eq(2).text());
                    $('#tb_category_enddate').val($(tr).find('td').eq(3).text());
                    $('#tb_category_note').val($(tr).find('td').eq(4).text());
                }

                mywidth = $(window).width() * .95;
                if (mywidth > 800) {
                    mywidth = 800;
                }

                $("#dialog-category").dialog({
                    resizable: false,
                    height: 600,
                    width: mywidth,
                    modal: true
                });

                var myButtons = {
                    "Cancel": function () {
                        $(this).dialog("close");
                    },
                    "Save": function () {
                        if (mode == "add") {
                            tr = $('#div_category > table > tbody tr:first').clone();
                            $(tr).removeAttr('style');
                            $('#div_category > table > tbody > tr:last').before(tr);
                            $(tr).attr('id', 'category_new_' + get_newctr());
                            $(tr).find('td:first').attr("class", "inserted");
                        } else {
                            $(tr).find('td:first').attr("class", "changed");

                        }
                        $(tr).attr('maint', 'changed');
                        $(tr).find('td').eq(1).text($('#dd_category_category option:selected').text());
                        $(tr).find('td').eq(1).attr('category_id', $('#dd_category_category').val());
                        $(tr).find('td').eq(2).text($('#tb_category_startdate').val());
                        $(tr).find('td').eq(3).text($('#tb_category_enddate').val());
                        $(tr).find('td').eq(4).text($('#tb_category_note').val());
                        //alert("Database will be updated when record submited");
                        $(this).dialog("close");
                    }
                }


                if (mode != 'add') {
                    myButtons["Delete"] = function () {
                        if (window.confirm("It may be better to use the 'End Date'.  Are you sure you want to delete this category?")) {
                            $(tr).find('td:first').attr("class", "deleted");
                            $(tr).attr('maint', 'deleted');
                            //$(tr).remove
                            $(this).dialog("close");
                        }
                    }
                }


                $("#dialog-category").dialog('option', 'buttons', myButtons);
            })

            /* ========================================= PHONE ===========================================*/
            $(document).on('click', '.phoneedit', function () {
                //$('.phonesedit').click(function () {
                mode = $(this).data('mode');
                if (mode == "add") {
                    $("#dialog-phones").find(':input').val('');
                } else {
                    tr = $(this).closest('tr');
                    $('#tb_phones_number').val($(tr).find('td').eq(1).text());
                    $('#dd_phones_mobile').val($(tr).find('td').eq(2).text());
                    if ($('#dd_phones_mobile').val() != 'Yes') {
                        $('#dd_phones_sendtexts').attr("disabled", true);
                    } else {
                        $('#dd_phones_sendtexts').val($(tr).find('td').eq(3).text());
                    }
                    //$('#dd_phones_sendtexts').val($(tr).find('td').eq(3).attr('event_id'));
                    $('#tb_phones_note').val($(tr).find('td').eq(4).text());
                }

                mywidth = $(window).width() * .95;
                if (mywidth > 800) {
                    mywidth = 800;
                }

                $("#dialog-phones").dialog({
                    resizable: false,
                    height: 600,
                    width: mywidth,
                    modal: true
                });

                var myButtons = {
                    "Cancel": function () {
                        $(this).dialog("close");
                    },
                    "Save": function () {
                        if (mode == "add") {
                            tr = $('#div_phone > table > tbody tr:first').clone();
                            $(tr).removeAttr('style');
                            //$('#div_phone > table > tbody > tr:last').before(tr);
                            $('#div_phone > table > tbody').append(tr);
                            $(tr).attr('id', 'phone_new_' + get_newctr());
                            $(tr).find('td:first').attr("class", "inserted");
                        } else {
                            $(tr).find('td:first').attr("class", "changed");

                        }
                        $(tr).attr('maint', 'changed');
                        $(tr).find('td').eq(1).html('<a href="tel:' + $('#tb_phones_number').val() + '">' + $('#tb_phones_number').val() + '</a>');
                        $(tr).find('td').eq(2).text($('#dd_phones_mobile').val());
                        $(tr).find('td').eq(3).text($('#dd_phones_sendtexts').val());
                        $(tr).find('td').eq(4).text($('#tb_phones_note').val());
                        if ($('#dd_phones_sendtexts').val() == 'Yes') {
                            $(tr).find('td').eq(5).html('<a class="send_text">Send</a>');
                        } else {
                            $(tr).find('td').eq(5).html('');
                        }
                        //alert("Database will be updated when record submited");
                        $(this).dialog("close");
                    }
                }

                if (mode != 'add') {
                    myButtons["Delete"] = function () {
                        if (window.confirm("Are you sure you want to delete this phone?")) {
                            $(tr).find('td:first').attr("class", "deleted");
                            $(tr).attr('maint', 'deleted');
                            //$(tr).remove
                            $(this).dialog("close");
                        }
                    }
                }
                $("#dialog-phones").dialog('option', 'buttons', myButtons);
            })

            $('#dd_phones_mobile').change(function () {
                if ($(this).val() == "No") {
                    $('#dd_phones_sendtexts').val('');
                    $('#dd_phones_sendtexts').attr("disabled", true);
                } else {
                    $('#dd_phones_sendtexts').removeAttr("disabled");
                }
            });

            /* ========================================= NOTE ===========================================*/
            $(document).on('click', '.noteedit', function () {
                //$('.notesedit').click(function () {
                alert('Still working on - you should be able to view all notes but only edit your own.  Only use followupactioned if followup date set')
                mode = $(this).data('mode');
                if (mode == "add") {
                    $("#dialog-notes").find(':input').val('');
                    $('#span_notes_madeby').text('<%:Session["UBC_name"] %>');
                } else {
                    tr = $(this).closest('tr');
                    $('#tb_notes_datetime').val($(tr).find('td').eq(1).text());
                    $('#span_notes_madeby').text($(tr).find('td').eq(2).text());
                    $('#tb_notes_note').val($(tr).find('td').eq(3).text());
                    $('#tb_notes_followup').val($(tr).find('td').eq(4).text());  //this is a date
                    $('#dd_notes_followupactioned').val($(tr).find('td').eq(5).text());
                }

                mywidth = $(window).width() * .95;
                if (mywidth > 800) {
                    mywidth = 800;
                }

                $("#dialog-notes").dialog({
                    resizable: false,
                    height: 600,
                    width: mywidth,
                    modal: true
                    , appendTo: "#form3"
                });

                var myButtons = {
                    "Cancel": function () {
                        $(this).dialog("close");
                    },
                    "Save": function () {
                        if ($("#form3").valid()) {
                            if (mode == "add") {
                                tr = $('#div_note > table > tbody tr:first').clone();
                                $(tr).removeAttr('style');
                                $('#div_note > table > tbody').append(tr);
                                $(tr).attr('id', 'note_new_' + get_newctr());
                                $(tr).find('td:first').attr("class", "inserted");
                            } else {
                                $(tr).find('td:first').attr("class", "changed");

                            }
                            $(tr).attr('maint', 'changed');

                            $(tr).find('td').eq(1).text($('#tb_notes_datetime').val());
                            $(tr).find('td').eq(2).text($('#span_notes_madeby').val());
                            $(tr).find('td').eq(3).text($('#tb_notes_note').val());
                            $(tr).find('td').eq(4).text($('#tb_notes_followup').val());
                            $(tr).find('td').eq(5).text($('#dd_notes_followupactioned').val());
                            //alert("Database will be updated when record submited");
                            $(this).dialog("close");
                        }
                    }
                }

                if (mode != 'add') {
                    myButtons["Delete"] = function () {
                        if (window.confirm("Are you sure you want to delete this note?")) {
                            $(tr).find('td:first').attr("class", "deleted");
                            $(tr).attr('maint', 'deleted');
                            //$(tr).remove
                            $(this).dialog("close");
                        }
                    }
                }
                $("#dialog-notes").dialog('option', 'buttons', myButtons);
            })

            /* ========================================= RELATIONSHIPS ===========================================*/
            $(document).on('click', '.relationshipsedit', function () {
                //$('.relationshipsedit').click(function () {
                $('#div_relationships_person').text($('#tb_firstname').val());
                mode = $(this).data('mode');
                if (mode == "add") {
                    $("#dialog-relationships").find(':input').val('');
                } else {
                    tr = $(this).closest('tr');
                    $('#dd_relationships_relationship').val($(tr).find('td').eq(1).attr('relationshiptype_id'));
                    $('#tb_relationships_person').val($(tr).find('td').eq(2).text());
                    //$('#dd_relationships_status').val($(tr).find('td').eq(3).text());
                    $('#tb_relationships_note').val($(tr).find('td').eq(3).text());
                }

                mywidth = $(window).width() * .95;
                if (mywidth > 800) {
                    mywidth = 800;
                }

                $("#dialog-relationships").dialog({
                    resizable: false,
                    height: 600,
                    width: mywidth,
                    modal: true
                });

                var myButtons = {
                    "Cancel": function () {
                        $(this).dialog("close");
                    },
                    "Save": function () {
                        if (mode == "add") {
                            tr = $('#div_relationships > table > tbody tr:first').clone();
                            $(tr).removeAttr('style');
                            //$('#div_relationship > table > tbody > tr:last').before(tr);
                            $('#div_relationships > table > tbody').append(tr);
                            $(tr).attr('id', 'relationships_new_' + get_newctr());
                            $(tr).find('td:first').attr("class", "inserted");
                        } else {
                            $(tr).find('td:first').attr("class", "changed");

                        }
                        $(tr).attr('maint', 'changed');
                        $(tr).find('td').eq(1).text('is the ' + $('#dd_relationships_relationship option:selected').text() + ' of');
                        $(tr).find('td').eq(1).attr('relationshiptype_id', $('#dd_relationships_relationship').val());
                        $(tr).find('td').eq(2).text($('#tb_relationships_person').val());
                        $(tr).find('td').eq(2).attr('relationshipperson_id', $('#tb_relationships_person').attr('relationshipperson_id'));
                        //$(tr).find('td').eq(3).text($('#dd_relationships_status').val());
                        $(tr).find('td').eq(3).text($('#tb_relationships_note').val());
                        $(this).dialog("close");
                    }
                }

                if (mode != 'add') {
                    myButtons["Delete"] = function () {
                        if (window.confirm("Are you sure you want to delete this relationship?")) {
                            $(tr).find('td:first').attr("class", "deleted");
                            $(tr).attr('maint', 'deleted');
                            //$(tr).remove
                            $(this).dialog("close");
                        }
                    }
                }
                $("#dialog-relationships").dialog('option', 'buttons', myButtons);
            })
            $("#tb_relationships_person").autocomplete({
                appendTo: "#dialog-relationships",
                source: "../data.asmx/person_name_autocomplete",
                minLength: 2,
                select: function (event, ui) {
                    //event.preventDefault();
                    selected = ui.item;
                    //alert(selected.guid);
                    $(this).attr('relationshipperson_id', selected.person_id);

                }
            })

    

/* ========================================= EMAIL ===========================================*/
            $(document).on('click', '.emailedit', function () {
                //$('.emailedit').click(function () {
                mode = $(this).data('mode');
                if (mode == "add") {
                    $("#dialog-email").find(':input').val('');
                } else {
                    tr = $(this).closest('tr');
                    $('#tb_email_emailaddress').val($(tr).find('td').eq(1).text());
                    $('#tb_email_note').val($(tr).find('td').eq(2).text());
                }

                mywidth = $(window).width() * .95;
                if (mywidth > 800) {
                    mywidth = 800;
                }

                $("#dialog-email").dialog({
                    resizable: false,
                    height: 600,
                    width: mywidth,
                    modal: true
                });

                var myButtons = {
                    "Cancel": function () {
                        $(this).dialog("close");
                    },
                    "Save": function () {
                        //if ($("#dialog-email").valid()) {
                            if (mode == "add") {
                                tr = $('#div_email > table > tbody tr:first').clone();
                                $(tr).removeAttr('style');
                                //$('#div_email > table > tbody > tr:last').before(tr);
                                $('#div_email > table > tbody').append(tr);
                                $(tr).attr('id', 'email_new_' + get_newctr());
                                $(tr).find('td:first').attr("class", "inserted");
                            } else {
                                $(tr).find('td:first').attr("class", "changed");

                            }
                            $(tr).attr('maint', 'changed');
                            $(tr).find('td').eq(1).text($('#tb_email_emailaddress').val());
                            $(tr).find('td').eq(2).text($('#tb_email_note').val());
                            $(tr).find('td').eq(3).html('<a class="send_email_system">Send</a>');
                            //$(tr).find('td').eq(4).html('<a class="send_email_local" href="mailto:' + $('#tb_email_emailaddress').val() + '?subject=Union Boat Club&amp;body=Hi ' + 'Greg' + '">Send</a>');
                            $(tr).find('td').eq(4).html('<a class="send_email_local">Send</a>');

                            //alert("Database will be updated when record submited");
                            $(this).dialog("close");
                        //}
                    }
                }


                if (mode != 'add') {
                    myButtons["Delete"] = function () {
                        if (window.confirm("Are you sure you want to delete this email?")) {
                            $(tr).find('td:first').attr("class", "deleted");
                            $(tr).attr('maint', 'deleted');
                            //$(tr).remove
                            $(this).dialog("close");
                        }
                    }
                }


                $("#dialog-email").dialog('option', 'buttons', myButtons);

            })

            /* ========================================= EMAIL END ===========================================*/

            $('#dd_emails_mobile').change(function () {
                if ($(this).val() == "No") {
                    $('#dd_emails_sendtexts').val('');
                    $('#dd_emails_sendtexts').attr("disabled", true);
                } else {
                    $('#dd_emails_sendtexts').removeAttr("disabled");
                }
            });


            //$('.send_text').click(function () {
            $(document).on('click', '.send_text', function () {
                phonenumber = $(this).closest('tr').find('td').eq(1).text();
                mywidth = $(window).width() * .95;
                if (mywidth > 800) {
                    mywidth = 800;
                }
                $("#dialog-sendtext").dialog({
                    resizable: false,
                    height: 250,
                    width: mywidth,
                    modal: true,
                    buttons: {
                        "Cancel": function () {
                            $(this).dialog("close");
                        },
                        "Send": function () {
                            $.post("posts.asmx/send_text", { PhoneNumber: phonenumber, Message: $('#tb_textmessage').val() }, function (data) {
                                alert(data);
                            },
                                'html'
                            );
                            $(this).dialog("close");
                        }
                    }
                });
            })

            //$('.send_email_system').click(function () {
            $(document).on('click', '.send_email_system', function () {
                mywidth = $(window).width() * .95;
                if (mywidth > 800) {
                    mywidth = 800;
                }
                $("#dialog-sendemail").dialog({
                    resizable: false,
                    height: 400,
                    width: mywidth,
                    modal: true,
                    buttons: {
                        "Cancel": function () {
                            $(this).dialog("close");
                        },
                        "Send": function () {
                            alert("to do - send to: " + $('td:eq(1)', $(this).parents('tr')).text());
                            $(this).dialog("close");
                        }
                    }
                });
            })

            //$('.send_email_local').click(function () {
            $(document).on('click', '.send_email_local', function () {
                email = $('td:eq(1)', $(this).parents('tr')).text();
                firstname = $('#tb_firstname').val();
                knownas = $('#tb_knownas').val();
                if (knownas == "") {
                    knownas = firstname;
                }
                $(this).attr("href", "mailto:" + email + "?subject=Union Boat Club&body=Hi " + knownas);
            })

            $('#getphoto').click(function () {
                mywidth = $(window).width() * .95;
                if (mywidth > 800) {
                    mywidth = 800;
                }
                $("#dialog-getphoto").dialog({
                    resizable: false,
                    height: 600,
                    width: mywidth,
                    modal: true,
                    buttons: {
                        "Restore": function () {
                            canvas.cropper('reset');
                            //$result.empty();
                        },
                        "Cancel": function () {
                            canvas.cropper("destroy");
                            $(this).dialog("close");
                        },
                        "Upload": function () {
                            var image = canvas.cropper('getCroppedCanvas').toDataURL("image/jpg");
                            image = image.replace('data:image/png;base64,', '');
                            $.ajax({
                                type: "POST",
                                //async: false,
                                url: "posts.asmx/SaveImage",
                                data: '{"imageData": "' + image + '", "id": "' + <%: hf_person_id %> + '"}',
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (result) {
                                    //alert(result);
                                    d = new Date();
                                    $("#img_photo").attr("src", "images/<%:hf_person_id %>.jpg?" + d.getTime());
                                },
                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                    alert("Status: " + textStatus); alert("Error: " + errorThrown);
                                }
                            });
                            canvas.cropper("destroy");
                            $(this).dialog("close");
                        }
                    }
                });
            })
            $('#fileInput').on('change', function () {
                if (this.files && this.files[0]) {
                    if (this.files[0].type.match(/^image\//)) {
                        var reader = new FileReader();
                        reader.onload = function (evt) {
                            var img = new Image();
                            img.onload = function () {
                                context.canvas.height = img.height;
                                context.canvas.width = img.width;
                                context.drawImage(img, 0, 0);
                                var cropper = canvas.cropper({
                                    preview: '#preview',
                                    dragMode: 'crop',
                                    autoCropArea: 0.65,
                                    rotatable: true,
                                    cropBoxMovable: true,
                                    cropBoxResizable: true
                                });
                            };
                            img.src = evt.target.result;
                        };
                        reader.readAsDataURL(this.files[0]);
                    }
                    else {
                        alert("Invalid file type! Please select an image file.");
                    }
                }
                else {
                    alert('No file(s) selected.');
                }
            });

            $('.registration_view').click(function () {
                alert('To do: ajax aspx return dialog, not editable OR dialog iframe');
            })


            $('.inhibitcutcopypaste').bind("cut copy paste", function (e) {
                e.preventDefault();
            });

            //$('[required]').css('border', '1px solid red');
            $('[required]').addClass('required');
        });

        function calculateage(e) {   
            if (moment().diff(e, 'seconds') < 0) {
                e.date = moment(e).subtract(100, 'years');
                $("#tb_birthdate").val(moment(e).format('D MMM YYYY'));
            }
            var years = moment().diff(e, 'years');
            thisyear = moment().year();
            thismonth = moment().month() + 1;
            if (thismonth >= 9) {
                thisyear = thisyear + 1;
            }
            var jan1 = moment([thisyear, 0, 1]);

            //age = moment().diff(birthday, 'years');

            $("#span_age").text('Age: ' + years + ' years, ' + jan1.diff(e, 'years') + ' years at 1 Jan ' + thisyear);
        }

        function get_newctr() {
            newctr++;
            return newctr;
        }

        function totaltransactions() {
            transactionstotal = 0

            $('#div_transactions > table > tbody > tr:not(:first-child, :last-child)').each(function () {
                if ($(this).attr('maint') != 'deleted') {
                    transactionstotal += parseFloat($(this).find('td').eq(5).text());
                }
            })
            Cr = '';
            if (transactionstotal > 0) {
                Cr = 'Cr';
            }
            $('#div_transactions > table > tbody > tr:last').find('td').eq(0).html('<b>' + parseFloat(transactionstotal).toFixed(2) + Cr + '</b>');
        }

    


    </script>

</head>
<body>

    <div class="container" style="background-color: #FCF7EA">
        <form id="form1" runat="server" class="form-horizontal" role="form">

            <input id="hf_guid" name="hf_guid" type="hidden" value="<%:hf_guid%>" />

             <div class="toprighticon">
            <input type="button" id="search" class="btn btn-info" value="Search" />

            <input type="button" id="menu" class="btn btn-info" value="MENU" />
                 </div>

            <h1>Union Boat Club - Person Maintenance
            </h1>

            <div class="row">
                <div class="col-md-8">
                    <div class="row form-group">
                        <label class="control-label col-md-6" for="tb_firstname">First name</label>
                        <div class="col-md-6">
                            <input id="tb_firstname" name="tb_firstname" type="text" class="form-control" value="<%:tb_firstname%>" maxlength="20" required="required" />
                        </div>

                    </div>
                    <div class="row form-group">
                        <label class="control-label col-md-6" for="tb_knownas">Known as</label>
                        <div class="col-md-6">
                            <input id="tb_knownas" name="tb_knownas" type="text" class="form-control" value="<%:tb_knownas%>" maxlength="20" />
                        </div>
                    </div>
                    <div class="row form-group">
                        <label class="control-label col-md-6" for="tb_lastname">Last name</label>
                        <div class="col-md-6">
                            <input id="tb_lastname" name="tb_lastname" type="text" class="form-control" value="<%:tb_lastname%>" maxlength="20" />
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <img id="img_photo" alt="" src="Images/<%: hf_person_id %>.jpg" style="width: 200px" /><br />
                    <a id="getphoto">Upload Photo</a>
                </div>
            </div>

            <div id="dialog-getphoto" title="Upload Photo" style="display: none">
                <div class="imagecontainer">
                    <input type="file" id="fileInput" class="btn btn-info" accept="image/*" />
                    <canvas id="canvas" style="display: none">Your browser does not support the HTML5 canvas element.
                    </canvas>
                    <br />
                    <input type="button" id="btn_Crop" class="btn btn-info" value="Crop" style="display: none" />
                    <div id="preview"></div>
                    <div id="result"></div>
                </div>

                <!--<iframe height="95%" width="95%" frameborder="0" scrolling="no" src="uploadphoto.aspx?id=<%: hf_person_id %>"></iframe>-->
            </div>

            <div id="dialog-sendtext" title="Send Text" style="display: none" class="form-horizontal">
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_textmessage">Message</label>
                    <div class="col-sm-8">
                        <textarea id="tb_textmessage" name="tb_textmessage" class="form-control"></textarea>
                    </div>
                </div>
            </div>

            <div id="dialog-sendemail" title="Send Email" style="display: none" class="form-horizontal">
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_subject">Subject</label>
                    <div class="col-sm-8">
                        <input id="tb_subject" name="tb_subject" type="text" class="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_body">Message</label>
                    <div class="col-sm-8">
                        <textarea id="tb_body" name="tb_body" class="form-control" rows="6"></textarea>
                    </div>
                </div>
            </div>
            <!-- =================================TRANSACTIONS===================================  -->
            <div id="dialog-transactions" title="Maintain Transactions" style="display: none" class="form-horizontal">
                <div class="form-group">
                    <label for="tb_transactions_date" class="control-label col-sm-4">
                        Date
                    </label>
                    <div class="col-sm-8">
                        <div class="input-group standarddate">
                            <input id="tb_transactions_date" name="tb_transactions_date" placeholder="eg: 23 Jun 1985" type="text" class="form-control" required="required" />
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_transactions_system">System</label>
                    <div class="col-sm-8">
                        <select id="dd_transactions_system" name="dd_transactions_system" class="form-control" required="required">
                            <%= Generic.Functions.populateselect(transactions_system, "","None") %>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_transactions_code">Code</label>
                    <div class="col-sm-8">
                        <select id="dd_transactions_code" name="dd_transactions_code" class="form-control" required="required">
                            <%= Generic.Functions.populateselect(transactions_code, "","None") %>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_transactions_event">Event</label>
                    <div class="col-sm-8">
                        <select id="dd_transactions_event" name="dd_transactions_event" class="form-control">
                            <option value="">None</option>
                            <%= person_financial_events %>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_transactions_amount">Amount</label>
                    <div class="col-sm-8">
                        <input id="tb_transactions_amount" name="tb_transactions_amount" type="text" class="form-control" required="required" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_transactions_note">Note</label>
                    <div class="col-sm-8">
                        <input id="tb_transactions_note" name="tb_transactions_note" type="text" class="form-control" />
                    </div>
                </div>
                <!--
                <div class="form-group">
                    <label for="tb_transactions_banked" class="control-label col-sm-4">
                        Banked
                    </label>
                    <div class="col-sm-8">
                        <div class="input-group standarddate">
                            <input id="tb_transactions_banked" name="tb_transactions_banked" placeholder="eg: 23 Jun 1985" type="text" class="form-control" />
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                    </div>
                </div>
                -->
            </div>

            <!-- =================================CATEGORY===================================  -->
            <div id="dialog-category" title="Maintain category" style="display: none" class="form-horizontal">
                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_category_category">System</label>
                    <div class="col-sm-8">
                        <select id="dd_category_category" name="dd_category_category" class="form-control">
                            <%=  category_category  %>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="tb_category_startdate" class="control-label col-sm-4">
                        Start Date
                    </label>
                    <div class="col-sm-8">
                        <div class="input-group standarddate">
                            <input id="tb_category_startdate" name="tb_category_startdate" placeholder="eg: 23 Jun 1985" type="text" class="form-control" />
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="tb_category_enddate" class="control-label col-sm-4">
                        End Date
                    </label>
                    <div class="col-sm-8">
                        <div class="input-group standarddate">
                            <input id="tb_category_enddate" name="tb_category_enddate" placeholder="eg: 23 Jun 1985" type="text" class="form-control" />
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_category_note">Note</label>
                    <div class="col-sm-8">
                        <input id="tb_category_note" name="tb_category_note" type="text" class="form-control" />
                    </div>
                </div>

            </div>

            <!-- ================================= PHONE ===================================  -->
            <div id="dialog-phones" title="Maintain phones" style="display: none" class="form-horizontal">
                <div class="form-group">
                    <label for="tb_phones_number" class="control-label col-sm-4">
                        Number
                    </label>
                    <div class="col-sm-8">
                        <input id="tb_phones_number" name="tb_phones_number" type="text" class="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_phones_mobile">Mobile</label>
                    <div class="col-sm-8">
                        <select id="dd_phones_mobile" name="dd_phones_mobile" class="form-control">
                            <%= Generic.Functions.populateselect(yesno, "","None") %>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_phones_sendtexts">Send texts</label>
                    <div class="col-sm-8">
                        <select id="dd_phones_sendtexts" name="dd_phones_sendtexts" class="form-control">
                            <%= Generic.Functions.populateselect(yesno, "","") %>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_phones_note">Note</label>
                    <div class="col-sm-8">
                        <input id="tb_phones_note" name="tb_phones_note" type="text" class="form-control" />
                    </div>
                </div>
            </div>
            <!-- ================================= NOTE ===================================  -->
            <div id="dialog-notes" title="Maintain notes" style="display: none" class="form-horizontal">

                <div class="form-group">
                    <label for="tb_notes_datetime" class="control-label col-sm-4">
                        Date
                    </label>
                    <div class="col-sm-8">
                        <div class="input-group datetime">
                            <input id="tb_notes_datetime" name="tb_notes_datetime" placeholder="eg: 23 Jun 1985" type="text" class="form-control" required="required" />
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="span_notes_madeby">Made by</label>
                    <div class="col-sm-8">
                        <span id="span_notes_madeby" class="form-control"></span>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_notes_note">Note</label>
                    <div class="col-sm-8">
                        <textarea id="tb_notes_note" name="tb_notes_note" class="form-control"></textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label for="tb_notes_followup" class="control-label col-sm-4">
                        Followup Date
                    </label>
                    <div class="col-sm-8">
                        <div class="input-group standarddate">
                            <input id="tb_notes_followup" name="tb_notes_followup" placeholder="eg: 23 Jun 1985" type="text" class="form-control"  />
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-calendar"></span>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-sm-4" for="dd_notes_followupactioned">Followup Actioned</label>
                    <div class="col-sm-8">
                        <select id="dd_notes_followupactioned" name="dd_notes_followupactioned" class="form-control">
                            <%= Generic.Functions.populateselect(yesno, "","") %>
                        </select>
                    </div>
                </div>
            </div>
            <!-- ================================= EMAIL ===================================  -->
            <div id="dialog-email" title="Maintain email" style="display: none" class="form-horizontal">
                <div class="form-group">
                    <label for="tb_email_emailaddress" class="control-label col-sm-4">
                        Email Address
                    </label>
                    <div class="col-sm-8">
                        <input id="tb_email_emailaddress" name="tb_email_emailaddress" type="email" required="required" class="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_email_note">Note</label>
                    <div class="col-sm-8">
                        <input id="tb_email_note" name="tb_email_note" type="text" class="form-control" />
                    </div>
                </div>
            </div>
            <!-- ================================= RELATIONSHIPS ===================================  -->
            <div id="dialog-relationships" title="Maintain relationship" style="display: none" class="form-horizontal">
                
                <div class="form-group">
                    <div class="col-sm-4">
                        </div>
                    <div id="div_relationships_person" class="col-sm-8">
                        
                    </div>
                </div>
                
                
                <div class="form-group">
                    <label for="dd_relationships_relationship" class="control-label col-sm-4">
                        Is the
                    </label>
                    <div class="col-sm-8">
                         <select id="dd_relationships_relationship" name="dd_relationships_relationship" class="form-control">
                            <%=  relationships_relationshiptypes  %>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="tb_relationships_person" class="control-label col-sm-4">
                        Of
                    </label>
                    <div class="col-sm-8">
                        <input id="tb_relationships_person" name="tb_relationships_person" type="text" required="required" class="form-control" />
                    </div>
                </div>
                <!--
                <div class="form-group">
                    <label for="tb_relationships_status" class="control-label col-sm-4">
                        Status
                    </label>
                    <div class="col-sm-8">
                        <input id="tb_relationships_status" name="tb_relationships_status" type="text" required="required" class="form-control" />
                    </div>
                </div>
                -->
                <div class="form-group">
                    <label class="control-label col-sm-4" for="tb_relationships_note">Note</label>
                    <div class="col-sm-8">
                        <input id="tb_relationships_note" name="tb_relationships_note" type="text" class="form-control" />
                    </div>
                </div>
            </div>
            <!-- ================================= END ===================================  -->

            <ul class="nav nav-tabs">
                <li class="active"><a data-target="#div_basic">Basic</a></li>
                <%=html_tabs %>
            </ul>
            <div class="tab-content">
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_basic" class="tab-pane fade in active">
                    <h3>Basic</h3>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="dd_relationshiponly">Relationship Only</label>
                        <div class="col-sm-8">
                            <select id="dd_relationshiponly" name="dd_relationshiponly" class="form-control" required="required">
                                <%= Generic.Functions.populateselect(yesno, dd_relationshiponly,"None") %>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="dd_gender">Gender</label>
                        <div class="col-sm-8">
                            <select id="dd_gender" name="dd_gender" class="form-control" required="required">
                                <%= Generic.Functions.populateselect(gender, dd_gender,"None") %>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_facebook">Facebook</label>
                        <div class="col-sm-7">
                            <input id="tb_facebook" name="tb_facebook" type="text" class="form-control" value="<%:tb_facebook%>" maxlength="150" />
                        </div>
                        <div class="col-sm-1">
                            <a class="btn btn-info" role="button" href="<%: tb_facebook %>" target="UBC_Facebook">Go</a>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="div_guid">GUID</label>
                        <div class="col-sm-8">
                            <div id="div_guid"><%=hf_guid%></div>
                        </div>
                     
                    </div>
                </div>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_general" class="tab-pane fade in">
                    <h3>General</h3>
                   
                    <div class="form-group">
                        <label for="tb_birthdate" class="control-label col-sm-4">
                            Date of birth
                        </label>
                        <div class="col-sm-8">
                            <div class="input-group date" id="div_birthdate">
                                <input id="tb_birthdate" name="tb_birthdate" placeholder="eg: 23 Jun 1985" type="text" class="form-control" value="<%: tb_birthdate %>" />

                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>

                                <span id="span_age" class="input-group-addon"></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_medical">Medical</label>
                        <div class="col-sm-8">
                            <textarea id="tb_medical" name="tb_medical" class="form-control"><%: tb_medical %></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_dietry">Dietary requirements</label>
                        <div class="col-sm-8">
                            <textarea id="tb_dietry" name="tb_dietry" class="form-control"><%: tb_dietry %></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="dd_feecategory">Fee category</label>
                        <div class="col-sm-3">
                            <select id="dd_feecategory" name="dd_feecategory" class="form-control">
                                <%= Generic.Functions.populateselect(feecategory, dd_feecategory,"") %>
                            </select>
                        </div>
                        <label class="control-label col-sm-2" for="dd_rowingrole">Rowing Role</label>
                        <div class="col-sm-3">
                            <select id="dd_rowingrole" name="dd_rowingrole" class="form-control" required="required">
                                <%= Generic.Functions.populateselect(rowingrole, dd_rowingrole,"") %>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="dd_familymember">
                            <img src="../Dependencies/images/questionsmall.png" data-toggle="tooltip" data-html="true" title="If there are more than 1 family member registered with UBC record a number otherwise leave blank" /> Family member</label>
                        <div class="col-sm-8">
                            <select id="dd_familymember" name="dd_familymember" class="form-control">
                                <%= Generic.Functions.populateselect(familymember, dd_familymember,"") %>
                            </select>
                        </div>
                    </div>
                     <div class="form-group">
                        <label class="control-label col-sm-4" for="dd_lastseasonregistered">Last Season Registered</label>
                        <div class="col-sm-8">
                            <select id="dd_lastseasonregistered" name="dd_lastseasonregistered" class="form-control">
                                <%= Generic.Functions.populateselect(seasons, dd_lastseasonregistered,"") %>
                            </select>
                        </div>
                     </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_boatstorage"><img src="../Dependencies/images/questionsmall.png" data-toggle="tooltip" data-html="true" title="Record a description of the boat or leave blank" /> Boat Storage</label>
                        <div class="col-sm-4">
                            <input id="tb_boatstorage" name="tb_boatstorage" type="text" class="form-control" value="<%:tb_boatstorage%>" maxlength="100" />
                        </div>
                        <label class="control-label col-sm-2" for="tb_boatstoragefee">Annual fee</label>
                        <div class="col-sm-2">
                            <input id="tb_boatstoragefee" name="tb_boatstoragefee" type="text" class="form-control numeric" value="<%:tb_boatstoragefee%>" maxlength="4" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="dd_school">School</label>
                        <div class="col-sm-8">
                            <select id="dd_school" name="dd_school" class="form-control">
                                <%= Generic.Functions.populateselect(school, dd_school,"") %>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_schoolyear">School year</label>
                        <div class="col-sm-4">
                            <input id="tb_schoolyear" name="tb_schoolyear" type="text" class="form-control numeric" value="<%:tb_schoolyear%>" maxlength="2" />
                        </div>
                        <label class="control-label col-sm-1" for="tb_schoolyearat">At</label>
                        <div class="col-sm-3">
                            <input id="tb_schoolyearat" name="tb_schoolyearat" type="text" class="form-control numeric" value="<%:tb_schoolyearat%>" maxlength="4" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-4" for="dd_swimmer">Can swim 50m with clothes</label>
                        <div class="col-sm-8">
                            <select id="dd_swimmer" name="dd_swimmer" class="form-control">
                                <%= Generic.Functions.populateselect(yesno, dd_swimmer,"") %>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_rowit_id">RowIt ID</label>
                        <div class="col-sm-4">
                            <input id="tb_rowit_id" name="tb_rowit_id" type="text" class="form-control numeric" value="<%:tb_rowit_id%>" maxlength="10" />
                        </div>
                    </div>
                     
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_rowingnzid">Rowing NZ ID</label>
                        <div class="col-sm-3">
                            <input id="tb_rowingnzid" name="tb_rowingnzid" type="text" class="form-control numeric" value="<%:tb_rowingnzid%>" maxlength="10" />
                        </div>
                         
                            <label class="control-label col-sm-1" for="tb_rowingnzid">Season</label>
                       
                        <div class="col-sm-4">
                            <select id="dd_rowingnzseason" name="dd_rowingnzseason" class="form-control">
                                <%= Generic.Functions.populateselect(seasons, dd_rowingnzseason,"") %>
                            </select>
                        </div>
                    </div>
                         
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_schoolyear">Key number</label>
                        <div class="col-sm-8">
                            <input id="tb_keynumber" name="tb_keynumber" type="text" class="form-control" value="<%:tb_keynumber%>" maxlength="10" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_notes">On loan from club</label>
                        <div class="col-sm-8">
                            <textarea id="tb_onloanfromclub" name="tb_onloanfromclub" class="form-control"><%: tb_onloanfromclub %></textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_notes">Notes</label>
                        <div class="col-sm-8">
                            <textarea id="tb_notes" name="tb_notes" class="form-control"><%: tb_notes %></textarea>
                        </div>
                    </div>
                </div>
                    
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_attendance" class="tab-pane fade in">
                    <h3>Attendance</h3>
                    <table class="table">
                        <%= html_attendance %>
                    </table>
                </div>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_category" class="tab-pane fade in">
                    <h3>Category</h3>
                    <table id="categorytable" class="table">
                        <%= html_category %>
                    </table>
                </div>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_finance" class="tab-pane fade in">
                    <h3>Finance</h3>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_invoicerecipient">Invoice Recipient</label>
                        <div class="col-sm-8">
                            <textarea id="tb_invoicerecipient" name="tb_invoicerecipient" class="form-control"><%: tb_invoicerecipient %></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="dd_invoiceaddresstype">Address type</label>
                        <div class="col-sm-8">
                            <select id="dd_invoiceaddresstype" name="dd_invoiceaddresstype" class="form-control">
                                <%= Generic.Functions.populateselect(invoiceaddresstypes, dd_invoiceaddresstype,"") %>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_invoiceaddress">Invoice Address</label>
                        <div class="col-sm-8">
                            <textarea id="tb_invoiceaddress" name="tb_invoiceaddress" class="form-control"><%: tb_invoiceaddress %></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_financialnote">Note</label>
                        <div class="col-sm-8">
                            <textarea id="tb_financialnote" name="tb_financialnote" class="form-control"><%: tb_financialnote %></textarea>
                        </div>
                    </div>
                </div>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_transactions" class="tab-pane fade in">
                    <h3>Transactions</h3>
                    <table id="transactionstable" class="table">
                        <%= html_transactions %>
                    </table>
                    <a href="reports/FriendsStatementsPreview.aspx?id=<%: hf_person_id %>" target="_blank">Statement</a>
                </div>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_relationships" class="tab-pane fade in">
                    <h3>Relationships</h3>
                    <table id="relationshiptable" class="table">
                        <%= html_relationships %>
                    </table>
                </div>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_phone" class="tab-pane fade in">
                    <h3>Phone</h3>
                  <table id="phonetable" class="table">
                      <%= html_phone %>
                    </table>
                </div>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_email" class="tab-pane fade in">
                    <h3>Email</h3>
                    <table id="emailtable" class="table">
                        <%= html_email %>
                    </table>
                </div>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_results" class="tab-pane fade in">
                    <h3>Results</h3>
                    <button type="button" id="results_add">Add</button>
                    <table id="tbl_results">
                        <%= html_results %>
                    </table>
                </div>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_system" class="tab-pane fade in">
                    <h3>System</h3>

                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_colour">Colour</label>
                        <div class="col-sm-8">
                            <input id="tb_colour" name="tb_colour" class="jscolor" value="<%: tb_colour %>" />
                        </div>
                    </div>

                </div>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_address" class="tab-pane fade in">
                    <h3>Address</h3>

                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_residentialaddress">Residential address</label>
                        <div class="col-sm-8">
                            <textarea id="tb_residentialaddress" name="tb_residentialaddress" class="form-control" rows="6"><%: tb_residentialaddress %></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="tb_postaladdress">Postal address</label>
                        <div class="col-sm-8">
                            <textarea id="tb_postaladdress" name="tb_postaladdress" class="form-control" rows="6"><%: tb_postaladdress %></textarea>
                        </div>
                    </div>
                </div>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_registration" class="tab-pane fade in">
                    <h3>Registration</h3>
                    <table style="width: 100%">
                        <%= html_registration %>
                    </table>
                </div>

                <p></p>
                <p></p>


                <!------------------------------------------------------------------------------------------------------>
                <div id="div_loginregister" class="tab-pane fade in">
                    <h3>Logins</h3>
                    <table class="table" style="width: 100%">
                        <%= html_loginregister %>
                    </table>
                </div>

                <p></p>
                <p></p>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_note" class="tab-pane fade in">
                    <h3>Notes</h3>
                    <table id="notetable" class="table" style="width: 100%">
                        <%= html_note %>
                    </table>
                </div>

                <p></p>
                <p></p>
                <!------------------------------------------------------------------------------------------------------>
                <div id="div_tracker" class="tab-pane fade in">
                    <h3>Tracker</h3>
                    <table class="table" style="width: 100%">
                        <%= html_tracker %>
                    </table>
                </div>

                <p></p>
                <p></p>

                <!------------------------------------------------------------------------------------------------------>

                <div id="div_arrangements" class="tab-pane fade in">
                    <h3>Arrangements</h3>
                    <table class="table" style="width: 100%">
                        <%= html_arrangements %>
                    </table>
                </div>

                <p></p>
                <p></p>


                <!------------------------------------------------------------------------------------------------------>

            </div>
            <!-- tabs -->
            <div class="form-group">
                <div class="col-sm-4">
                </div>
                <div class="col-sm-8">
                    <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="submit btn btn-info" Text="Submit" />
                </div>
            </div>
        </form>
        <form id="form2"></form>
        <form id="form3"></form>
    </div>



</body>
</html>
