<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Communicate.aspx.cs" Inherits="UBC.LearntoRow.Communicate" %>

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

    <style>
        .scrollable {
            height: 500px;
            overflow-y: scroll;
        }
    </style>


    <script>
        tinymce.init({
            selector: '.tinymce',
            plugins: "code paste",
            menubar: "tools edit format view",
            paste_as_text: true
        });
        $(document).ready(function () {
            $('#btn_submit').click(function (e) {
                e.preventDefault();
                $("#tbl_results > tbody").empty();
                $('#dialog_sending').dialog({
                    modal: true,
                    width: ($(window).width() - 0) * .95,  //75 x 2 is the width of the question mark top right
                    height: 600, //auto
                    position: { my: "center", at: "100", of: window }
                });

                //$('#tbl_people > tbody  > tr').each(function () {
                $("#tbl_people > tbody > tr > td > input:checked").each(function () {
                    id = $(this).attr("id");
                    recipient = $(this).val();
                    if (id.substring(0, 9) == 'cb_email_') {
                        type = 'email';
                        id = id.substring(9);
                        emailsubject = $('#tb_subject').val();
                        emailhtml = $('#tb_htmlbody').val();
                        text = '';
                    } else if (id.substring(0, 8) == 'cb_text_') {
                        type = 'text';
                        id = id.substring(8);
                        emailsubject = '';
                        emailhtml = '';
                        text = $('#tb_txt').val();
                    }
                    name = $('#name_' + id).text();

                    var arForm = [{ "name": "signupevent_ctr", "value": 2 }, { "name": "type", "value": type }, { "name": "id", "value": id }, { "name": "emailsubject", "value": emailsubject }, { "name": "emailhtml", "value": emailhtml }, { "name": "text", "value": text }, { "name": "recipient", "value": recipient }];
                    var formData = JSON.stringify({ formVars: arForm });
                    //console.log(formData);

                    $.ajax({
                        type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                        contentType: "application/json; charset=utf-8",
                        url: "../posts.asmx/send_signup_email_text",
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
            });

            $('#cb_emailall').click(function (event) {
                if (this.checked) {
                    $('[id^=cb_email_]').each(function () {
                        this.checked = true;
                    });
                } else {
                    $('[id^=cb_email_]').each(function () {
                        this.checked = false;
                    });
                }
            });
            $('#cb_textall').click(function (event) {
                if (this.checked) {
                    $('[id^=cb_text_]').each(function () {
                        this.checked = true;
                    });
                } else {
                    $('[id^=cb_text_]').each(function () {
                        this.checked = false;
                    });
                }
            });

        }); //document ready


    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="background-color: #FCF7EA; width: 100%">
        <input type="button" id="menu" class="toprighticon btn btn-info" value="MENU" />Use ||link|| to include the link, it will be displayed as &quot;here&quot; in the body of the email.<br />
        Also can use ||firstname||<br />
        <br />
        Email Reply-To Address:<br />
        &nbsp;<input type="text" id="tb_replyto" style="width:100%" value="Not currently used" /><br />
        <br />
        Email Subject:<br />
        &nbsp;<input type="text" id="tb_subject" style="width:100%" value="Union Boat Club" /><br />
        <br />
        Email Body (HTML):<br />
        <textarea class="tinymce" id="tb_htmlbody" name="tb_htmlbody" rows="10" style="width:100%">&lt;p&gt;Hi ||firstname||&lt;/p&gt;
&lt;p&gt;
&lt;/p&gt;<p>https://ubc.org.nz/learntorow?id=||guid|| </p></textarea><br />
        &nbsp;<br />
        <br />
        Mobile
                    Text Body:<br />
        &nbsp;<textarea id="tb_txt" name="tb_txt" rows="5" style="width:100%">Hi ||firstname||
            https://ubc.org.nz/learntorow?id=||guid||
              </textarea>
        <br />
        <br />
        <br />
        <hr />
        <table id="tbl_people" class="table table-hover"><thead>
           <tr><th>Person</th><th><input id="cb_textall" type="checkbox" /> Send Text</th><th><input id="cb_emailall" type="checkbox" /> Send Email</th></tr></thead><tbody>
            <%=html %>
            </tbody>
        </table>
        <div class="form-group">
            <div class="col-sm-4">
            </div>
            <div class="col-sm-8">
                <input type="button" id="btn_submit" class="btn btn-info" value="Send" />
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
        <div class="scrollable" style="display: none">></div>
    </div>
</asp:Content>

