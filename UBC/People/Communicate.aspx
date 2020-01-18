<%@ Page ValidateRequest="false" Title="Union Boat Club Communicate" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Communicate.aspx.cs" Inherits="UBC.People.Communicate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />


    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
    <script src='//cdn.tinymce.com/4/tinymce.min.js'></script>
    <script>
        var newobj;

        tinymce.init({
            selector: '.tinymce',
            plugins: "code paste",
            menubar: "tools edit format view",
            paste_as_text: true
        });
        $(document).ready(function () {
            $('.fb_clipboard').click(function () {
                link = $(this).data('link');
                //alert(link);
                textarea = $(this).next();
                $(textarea).focus();
                $(textarea).select();
                document.execCommand('copy');

                window.open(link, 'facebook');
                //alert("Copied to clipboard");
            });

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

            $('#dd_categories_filter').select2();

            processrows();

            $('#btn_event').click(function () {
                $("#eventselector").attr('src', 'eventselector.aspx');
                $("#div_eventselector").dialog({
                    width: 800,
                    height: 600,
                    modal: true,
                    close: function () {
                        $("#eventselector").attr('src', "about:blank");
                    }
                });
            })


            $('.btn_refresh').click(function () {
                //Now will have all data but just hidden alert('Get data from server for categories: ' + $('#dd_categories_filter').val());
                processrows();
            })

            $('[name^="cb_email_"]').click(function () {
                name = "disp_" + $(this).attr('name');
                address = $(this).val();
                if ($(this).is(':checked')) {
                    $('#emailaddresses').append('<span id="' + name + '">' + address + ';</span> ');
                } else {
                    $('#' + name).remove();
                }
            })

            $('[name^="cb_remail_"]').click(function () {
                name = "disp_" + $(this).attr('name');
                address = $(this).val().split('|');
                if ($(this).is(':checked')) {
                    $('#remailaddresses').append('<span id="' + name + '">' + address[2] + ';</span> ');
                } else {
                    $('#' + name).remove();
                }
            })

            $('.btn_submit').click(function (e) {
                e.preventDefault();
                var cont = true;
                if ($("#tbl_people > tbody > tr:hidden > td > div > input:checked").length > 0) {
                    cont = confirm("There are hidden people with flags set to send.  Do you wish to continue?");
                }
                if (cont) {
                    $("#tbl_results > tbody").empty();
                    $('#dialog_sending').dialog({
                        modal: true,
                        width: ($(window).width() - 0) * .95,  //75 x 2 is the width of the question mark top right
                        height: 600, //auto
                        position: { my: "center", at: "100", of: window }
                    });
                    newobj = $("#tbl_people > tbody > tr > td > div > input:checked").toArray()
                    //console.log(newobj);
                    sendtext(0, $(newobj).length);
                }

                /*

                $("#tbl_people > tbody > tr > td > input:checked").each(function () {
                    id = $(this).attr("id");
                    recipient = $(this).val();
                    attendance = $(this).closest('tr').find('td').eq(6).text();
                    if (id.substring(0, 9) == 'cb_email_') {
                        type = 'email';
                        id = id.substring(9);
                        emailsubject = $('#tb_subject').val();
                        //emailhtml = $('#tb_htmlbody').val();
                        emailhtml = tinyMCE.get('tb_htmlbody').getContent();
                        text = '';
                    } else if (id.substring(0, 8) == 'cb_text_') {
                        type = 'text';
                        id = id.substring(8);
                        emailsubject = '';
                        emailhtml = '';
                        text = $('#tb_txt').val();
                    } else if (id.substring(0, 10) == 'cb_remail_') {
                        type = 'remail';
                        id = id.substring(10);
                        emailsubject = $('#tb_rsubject').val();
                        //emailhtml = $('#tb_rhtmlbody').val();
                        emailhtml = tinyMCE.get('tb_rhtmlbody').getContent();

                        text = '';
                    } else if (id.substring(0, 9) == 'cb_rtext_') {
                        type = 'rtext';
                        id = id.substring(9);
                        emailsubject = '';
                        emailhtml = '';
                        text = $('#tb_rtxt').val();
                    }
                    name = $('#name_' + id).text();


                    var arForm = [{ "name": "type", "value": type }, { "name": "id", "value": id }, { "name": "emailsubject", "value": emailsubject }, { "name": "emailhtml", "value": emailhtml }, { "name": "text", "value": text }, { "name": "recipient", "value": recipient }, { "name": "attendance", "value": attendance }];
                    var formData = JSON.stringify({ formVars: arForm });
                    //console.log(formData);

                    $.ajax({
                        type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                        contentType: "application/json; charset=utf-8",
                        url: "posts.asmx/send_email_text",
                        async: false,
                        data: formData,
                        dataType: 'json', // what type of data do we expect back from the server
                        success: function (data) {
                            //$('.scrollable').prepend(name + ' ' + recipient + ' ' + data.d.status + '<br />');
                            $('#tbl_results tbody').prepend("<tr><td>" + name + '</td><td>' + recipient + '</td><td>' + data.d.status + '</td></tr>');
                        },
                        error: function (XMLHttpRequest, textStatus, error) {
                            alert("AJAX error: " + textStatus + "; " + error);
                        }
                    });
                });
                //$('.scrollable').prepend('Complete' + '<br />');
                $('#tbl_results tbody').prepend('<tr><td colspan="3">Complete</td>');
                */
            });

            $('#cb_emailall').click(function (event) {
                //$('#emailaddresses').html('');
                if (this.checked) {
                    $('[id^=cb_email_]:visible').each(function () {
                        this.checked = true;
                        name = "disp_" + $(this).attr('name');
                        address = $(this).val().split('|');
                        $('#' + name).remove();
                        $('#emailaddresses').append('<span id="' + name + '">' + address + ';</span> ');
                    });
                } else {
                    $('[id^=cb_email_]:visible').each(function () {
                        this.checked = false;
                        name = "disp_" + $(this).attr('name');
                        //address = $(this).val().split('|');
                        $('#' + name).remove();
                    });
                }
            });
            $('#cb_textall').click(function (event) {
                if (this.checked) {
                    $('[id^=cb_text_]:visible').each(function () {
                        this.checked = true;
                    });
                } else {
                    $('[id^=cb_text_]:visible').each(function () {
                        this.checked = false;
                    });
                }
            });

            $('#cb_remailall').click(function (event) {
               //$('#remailaddresses').html('');
               if (this.checked) {
                    $('[id^=cb_remail_]:visible').each(function () {
                        this.checked = true;
                        name = "disp_" + $(this).attr('name');
                        address = $(this).val().split('|');
                        $('#' + name).remove();
                        $('#remailaddresses').append('<span id="' + name + '">' + address[2] + ';</span> ');
                    });
                } else {
                    $('[id^=cb_remail_]:visible').each(function () {
                        this.checked = false;
                        name = "disp_" + $(this).attr('name');
                        //address = $(this).val().split('|');
                        $('#' + name).remove();
                    });
                }
            });
            $('#cb_rtextall').click(function (event) {
                if (this.checked) {
                    $('[id^=cb_rtext_]:visible').each(function () {
                        this.checked = true;
                    });
                } else {
                    $('[id^=cb_rtext_]:visible').each(function () {
                        this.checked = false;
                    });
                }
            });


            $('#cb_na').click(function (event) {
                if (this.checked) {
                    $('.na').each(function () {
                        $(this).show();
                    });
                } else {
                    $('.na').each(function () {
                        $(this).hide();
                    });
                }
            });

            $('#dd_attendancefilter').change(function () {
                alert('todo: Only works if there is a category filter.  Could mean some selected options could be hidden????')
                processrows();
            })


            $('#tb_event_id').change(function () {
                reloadpage();
            })

            function sendtext(i, items) {

                
                    //console.log(i + ',' + items);
                    thisobj = newobj[i];
                    //console.log(thisobj);
                    id = $(thisobj).attr("id");
                    name = $(thisobj).closest('tr').find('td').eq(1).text();
                    recipient = $(thisobj).val();
                    attendance = $(thisobj).closest('tr').find('td').eq(6).text();
                    if (id.substring(0, 9) == 'cb_email_') {
                        type = 'email';
                        id = id.substring(9);
                        emailsubject = $('#tb_subject').val();
                        emailhtml = tinyMCE.get('tb_htmlbody').getContent();
                        text = '';
                    } else if (id.substring(0, 8) == 'cb_text_') {
                        type = 'text';
                        id = id.substring(8);
                        emailsubject = '';
                        emailhtml = '';
                        text = $('#tb_txt').val();
                    } else if (id.substring(0, 10) == 'cb_remail_') {
                        type = 'remail';
                        id = id.substring(10);
                        emailsubject = $('#tb_rsubject').val();
                        emailhtml = tinyMCE.get('tb_rhtmlbody').getContent();
                        text = '';
                    } else if (id.substring(0, 9) == 'cb_rtext_') {
                        type = 'rtext';
                        id = id.substring(9);
                        emailsubject = '';
                        emailhtml = '';
                        text = $('#tb_rtxt').val();
                    }

                    //use this for named parameters
                    //var arForm = { type: type, id: id, emailsubject: emailsubject, emailhtml: emailhtml, text: text, recipient: recipient, attendance: attendance };
                    //mydata = JSON.stringify(arForm);

                    //use this for NameValue[] formVars
                    var arForm = [{ "name": "type", "value": type }, { "name": "id", "value": id }, { "name": "emailsubject", "value": emailsubject }, { "name": "emailhtml", "value": emailhtml }, { "name": "text", "value": text }, { "name": "recipient", "value": recipient }, { "name": "attendance", "value": attendance }, { "name": "mode", "value": "" }];
                    var mydata = JSON.stringify({ formVars: arForm });

                    //$('#tbl_results tbody').prepend("<tr><td>" + name + '</td><td>' + recipient + '</td><td>' + 'responseFromServer.d' + '</td></tr>');

                    $.ajax({
                        type: "POST",
                        url: "posts.asmx/send_email_text",
                        data: mydata,
                        contentType: "application/json",
                        datatype: "json",
                        async: false,
                        success: function (responseFromServer) {
                            $('#tbl_results tbody').prepend("<tr><td>" + name + '</td><td>' + recipient + '</td><td>' + responseFromServer.d.status + '</td></tr>');
                        }
                    });

                    i++;
                    if (i < items) {
                        setTimeout(function () { sendtext(i, items); }, 100);
                        //} else {
                        //    $('#tbl_results tbody').prepend('<tr><td>Complete</td></tr>');
                    }
            }

        });  //document.ready

        function reloadpage() {
            window.location.href = window.location.pathname + "?id=" + $('#tb_event_id').val();
        }



        function closeeventselector() {
            $('#div_eventselector').dialog('close');
        }

        function processrows() {
            category = $('#dd_categories_filter').val();
            if (category == null) {
                $('.tr_person').show();
            } else {
                $('.tr_person').each(function () {
                    found = false;
                    for (f1 = 0; f1 < category.length; f1++) {
                        usecategory = '|' + category[f1] + '|';
                        person_category = '|' + $(this).attr('data-category') + '|';
                        if (person_category.indexOf(usecategory) != -1 && ($('#tb_event_id').val() == '' || $('#dd_attendancefilter').val() == 'All' || $(this).hasClass($('#dd_attendancefilter').val()))) {
                            found = true;
                            break;
                        }
                    }
                    if (found) {
                        $(this).show();
                        //console.log('show ' + thename);
                    } else {
                        $(this).hide();
                        //console.log('hide ' + thename);
                    }
                });
            }
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="background-color: #FCF7EA; width: 100%">
        <div class="toprighticon">
            <input type="button" class="btn_submit btn btn-info" value="Send" />
            <input type="button" class="btn btn-info" id="menu" value="MENU" />
        </div>
        <% = response %>
        Event ID:
        <input type="text" id="tb_event_id" name="tb_event_id" value="<%=event_id %>" />
        <input type="button" id="btn_event" class="btn btn-info" value="Select Event" /><%=html_event %>
        <table>
            <tr>
                <td style="width: 44%">Use ||link|| to include the link, it will be displayed as &quot;here&quot; in the body of the email.<br />
                    Also can use ||firstname||, ||caregivername||<br />
                    ||guid|| - Person&#39;s GUID<br />
                    ||accesscode||<br />
                    ||username||<br />
                    ||tempphrase||<br />
                    ||attendance|| - requires Event ID<br />
                    ||folder|| as in http://private.unionboatclub.co.nz/people/documents/||folder||/update5Dec2018.pdf<br />
                    ||redirect|| as in ||redirect||https://www.youtube.com/watch?v=sR7s-qlMfpA (||folder|| will be automatically included)<br />
                    ||personevent|| returns p=person_guid&amp;e=event_guid - requires Event ID<br />
                    <br />
                    Email messages will not be sent where there is no email subject<br />
                    Txt messages will not be sent where there is no text body.<br />
                    <br />
                    Email Reply-To Address:<br />
                    <input type="text" id="tb_replyto" style="width: 100%" value="Not currently used" /><br />
                    <br />
                    Email Subject:<br />
                    <input type="text" id="tb_subject" style="width: 100%" value="Union Boat Club" /><br />
                    <br />
                    Email Body (HTML):<br />
                    <textarea class="tinymce" id="tb_htmlbody" name="tb_htmlbody" rows="10" style="width: 100%">&lt;p&gt;Hi ||firstname||
&lt;/p&gt;&lt;p&gt;&lt;/p&gt;</textarea><br />
                    <br />
                    Facebook (Text):<br />
                    <textarea id="tb_textbody" name="tb_textbody" rows="5" style="width: 100%">Hi ||firstname||</textarea><br />
                    <br />
                    Mobile Text Body:<br />
                    <textarea id="tb_txt" name="tb_txt" rows="5" style="width: 100%">Hi ||firstname||</textarea>

                </td>
                <td style="width: 2%">&nbsp;&nbsp;</td>
                <td style="width: 48%">Use ||link|| to include the link, it will be displayed as &quot;here&quot; in the body of the email.<br />
                    Also can use ||firstname||, ||caregivername||<br />
                    ||accesscode||<br />
                    ||username||<br />
                    ||tempphrase||<br />
                    ||attendance|| - requires Event ID<br />
                    ||folder|| as in http://private.unionboatclub.co.nz/people/documents/||folder||/update5Dec2018.pdf<br />
                    ||redirect|| as in ||redirect||https://www.youtube.com/watch?v=sR7s-qlMfpA (||folder|| will be automatically included)<br />
                    ||personevent|| returns p=person_guid&amp;e=event_guid - requires Event ID<br />
                    <br />
                    Email messages will not be sent where there is no email subject<br />
                    Txt messages will not be sent where there is no text body.<br />
                    <br />
                    <br />
                    Email Reply-To Address:<br />
                    <input type="text" id="tb_rreplyto" style="width: 100%" value="Not currently used" />
                    <br />
                    <br />
                    Email Subject:<br />
                    <input type="text" id="tb_rsubject" style="width: 100%" value="Union Boat Club" />
                    <br />
                    <br />
                    Email Body (HTML):<br />
                    <textarea class="tinymce" id="tb_rhtmlbody" name="tb_rhtmlbody" rows="10" style="width: 100%">&lt;p&gt;Hi ||firstname||&lt;/p&gt;
&lt;p&gt;||rfirstname||&lt;/p&gt;</textarea><br />
                    <br />
                    Facebook (Text):<br />
                    <textarea id="tb_rtextbody" name="tb_rtextbody" rows="5" style="width: 100%">Hi ||firstname||
||rfirstname||
                    </textarea>
                    <br />
                    <br />
                    Mobile Text Body:<br />
                    <textarea id="tb_rtxt" name="tb_rtxt" rows="5" style="width: 100%">Hi ||firstname||
||rfirstname||</textarea>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <br />
        <hr />

        <%=html_facebook %>
        <select class="form-control" id="dd_categories_filter" name="dd_categories_filter" multiple="multiple">
            <%= categories_values %>
        </select>
        <button type="button" class="btn_refresh">Refresh</button><br />

        <table id="tbl_people" class="table table-hover">
            <thead>
                <tr>
                    <th colspan="2">Person</th>
                    <th>
                        <input id="cb_textall" type="checkbox" />
                        Send Text</th>
                    <th>
                        <input id="cb_emailall" type="checkbox" />
                        Send Email</th>
                    <th>Facebook</th>
                    <th>Relations - show those under <input type="text" class="numeric" id="tb_age" maxlength="2" value="0" style="width:24px"/> <button type="button" class="btn_refresh">Apply</button><br /><input id="cb_rtextall" type="checkbox" /> Send Text <input id="cb_remailall" type="checkbox" /> Send Email </th>
                    <% if (event_id != "") { %>
                    <th>Attendance<br /><select id="dd_attendancefilter"><option>All</option><%=attendance_values %></select></th>
                    <%} %>
                </tr>
            </thead>
            <tbody>
                <%=html %>
            </tbody>
        </table>
        <div id="emailaddresses" style="max-width:100%"></div>
        <br />
        <div id="remailaddresses" style="max-width:100%"></div>
        <div class="form-group">
            <div class="col-sm-4">
            </div>
            <div class="col-sm-8">
                <input type="button" class="btn_submit btn btn-info" value="Send" />
            </div>
        </div>
        <br />
        <div id="dialog_sending" title="Sending ..." style="display: none">
            <table id="tbl_results" class="table table-hover">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Address</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
        <div id="div_eventselector" title="Event Selector" style="display: none;">
            <iframe id="eventselector" width="550" height="500"></iframe>
        </div>
    </div>
</asp:Content>
